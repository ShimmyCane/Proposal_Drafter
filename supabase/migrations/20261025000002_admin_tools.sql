-- Admin helpers, run by the site admin in the Supabase SQL editor.
-- The admin schema is not exposed through the API, and the website's roles
-- (anon, authenticated) have no access to it.
--
--   select admin.create_user('person@example.com', 'a-temporary-password');
--   select admin.set_password('person@example.com', 'a-new-password');
--   select * from admin.list_users();
--   select admin.remove_user('person@example.com');
--
-- The supported alternative for creating users is the dashboard:
-- Authentication -> Users -> Add user -> Create new user (tick "Auto Confirm User").

create schema admin;
revoke all on schema admin from public, anon, authenticated;

create function admin.create_user(p_email text, p_password text)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_email text := lower(trim(p_email));
  v_id uuid := gen_random_uuid();
begin
  if v_email !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$' then
    raise exception 'Not a valid email address: %', p_email;
  end if;
  if length(p_password) < 8 then
    raise exception 'Password must be at least 8 characters';
  end if;
  if exists (select 1 from auth.users where email = v_email) then
    raise exception 'A user with email % already exists', v_email;
  end if;

  insert into auth.users (
    instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at,
    confirmation_token, recovery_token, email_change_token_new, email_change
  ) values (
    '00000000-0000-0000-0000-000000000000', v_id, 'authenticated', 'authenticated', v_email,
    extensions.crypt(p_password, extensions.gen_salt('bf')), now(),
    '{"provider": "email", "providers": ["email"]}'::jsonb, '{}'::jsonb, now(), now(),
    '', '', '', ''
  );

  insert into auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
  values (
    v_id::text, v_id,
    jsonb_build_object('sub', v_id::text, 'email', v_email, 'email_verified', true),
    'email', now(), now(), now()
  );

  return v_id;
end;
$$;

create function admin.set_password(p_email text, p_password text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  if length(p_password) < 8 then
    raise exception 'Password must be at least 8 characters';
  end if;
  update auth.users
    set encrypted_password = extensions.crypt(p_password, extensions.gen_salt('bf')),
        email_confirmed_at = coalesce(email_confirmed_at, now()),
        updated_at = now()
    where email = lower(trim(p_email));
  if not found then
    raise exception 'No user with email %', p_email;
  end if;
end;
$$;

-- Deletes the account and, through on delete cascade, all of that user's rows.
-- Their uploaded files stay in the past-proposals bucket under their user id folder;
-- delete that folder from Storage in the dashboard.
create function admin.remove_user(p_email text)
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  delete from auth.users where email = lower(trim(p_email));
  if not found then
    raise exception 'No user with email %', p_email;
  end if;
end;
$$;

create function admin.list_users()
returns table (email text, created_at timestamptz, last_sign_in_at timestamptz, ai_review_opt_in boolean)
language sql
security definer
set search_path = ''
as $$
  select u.email::text, u.created_at, u.last_sign_in_at, coalesce(p.ai_review_opt_in, false)
  from auth.users u
  left join public.profiles p on p.id = u.id
  order by u.created_at;
$$;

-- ---------------------------------------------------------------------------
-- AI review (done in a Claude Code session, never by the website)
-- ---------------------------------------------------------------------------

-- Past proposals the AI may read: only from users who turned on AI review in Account.
create view admin.ai_review_queue as
  select u.email::text as email, pp.id, pp.title, pp.client_name, pp.year, pp.project_type,
         pp.notes, pp.body_text, pp.created_at
  from public.past_proposals pp
  join public.profiles p on p.id = pp.owner_id and p.ai_review_opt_in
  join auth.users u on u.id = pp.owner_id;

-- Writes one suggestion into a user's account. It shows up in their template editor,
-- labelled as AI-drafted, and changes nothing until they choose to copy it in.
create function admin.add_ai_suggestion(
  p_email text, p_kind text, p_project_type text, p_title text, p_body jsonb, p_notes text, p_source text
)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_owner uuid;
  v_id uuid;
begin
  select u.id into v_owner
  from auth.users u
  join public.profiles p on p.id = u.id and p.ai_review_opt_in
  where u.email = lower(trim(p_email));
  if v_owner is null then
    raise exception 'No user % with AI review turned on', p_email;
  end if;

  insert into public.ai_suggestions (owner_id, kind, project_type, title, body, notes, source)
  values (v_owner, p_kind, coalesce(p_project_type, ''), p_title, p_body, p_notes, p_source)
  returning id into v_id;
  return v_id;
end;
$$;

revoke all on all functions in schema admin from public, anon, authenticated;
revoke all on all tables in schema admin from public, anon, authenticated;
