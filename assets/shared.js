import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.45.4/+esm';

// Only this account can read or write the Architecture database (see the RLS policies on each table).
export const OWNER_EMAIL = 'splusystudio@gmail.com';

const SUPABASE_URL = 'https://xabgankckrcuhcgdolrg.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_kncKodoYJZ6ByexwWM_TtQ_OpW68M5f';

export const db = createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, {
  auth: { persistSession: true, autoRefreshToken: true, detectSessionInUrl: true },
});

export function esc(value) {
  return String(value ?? '').replace(/[&<>"']/g, (c) => (
    { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]
  ));
}

// Resolves with the owner's session. Until then it shows a magic-link form inside `container`.
export async function requireSignIn(container) {
  const { data } = await db.auth.getSession();
  if (data.session && data.session.user.email === OWNER_EMAIL) return data.session;
  if (data.session) await db.auth.signOut();

  return new Promise((resolve) => {
    const { data: { subscription } } = db.auth.onAuthStateChange((_event, session) => {
      if (session && session.user.email === OWNER_EMAIL) {
        subscription.unsubscribe();
        container.replaceChildren();
        resolve(session);
      }
    });

    container.innerHTML = `
      <form class="signin">
        <h2>Sign in</h2>
        <p>We'll email you a sign-in link.</p>
        <label>Email <input type="email" name="email" required autocomplete="email" value="${esc(OWNER_EMAIL)}"></label>
        <button type="submit">Send link</button>
        <p class="status" role="status"></p>
      </form>`;

    const form = container.querySelector('form');
    form.addEventListener('submit', async (event) => {
      event.preventDefault();
      const status = form.querySelector('.status');
      const { error } = await db.auth.signInWithOtp({
        email: form.email.value.trim(),
        options: { emailRedirectTo: location.href.split('#')[0] },
      });
      status.textContent = error ? error.message : 'Check your email for the sign-in link.';
    });
  });
}
