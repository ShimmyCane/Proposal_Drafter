from pathlib import Path
import re

path = Path(r"01_Preparation\Past Proposals\260723_Combined Proposals.htm")
text = path.read_text(encoding="utf-8")

replacements = [
    ("Liz Robertson and Ju Rocha", "[Name] and [Name]"),
    ("Ju Rocha", "[Name]"),
    ("Robertson + Rocha Design Studio", "[Client]"),
    ("Shi Architect", "[Client]"),
    ("SHI Architect", "[Client]"),
    ("Junming Shi", "[Name]"),
    ("Jimmy Shi", "[Name]"),
    ("Kris Ackerman", "[Name]"),
    ("John Ancelmo", "[Name]"),
    ("Cheryl Holstrom", "[Name]"),
    ("CJ Holstrom, Inc.", "[Client]"),
    ("Walter Burgess", "[Name]"),
    ("Billy Richard", "[Name]"),
    ("Maria Peralta", "[Name]"),
    ("Winston Pies", "[Client]"),
    ("Fit for Life 1, Inc.", "[Client]"),
    ("Life 1, Inc.", "[Client]"),
    ("Angeles Madison Residential", "[Client]"),
    ("EcoBuild.LA", "[Client]"),
    ("4625 Admiralty Way Suite 105", "[Address]"),
    ("5740 Appian Way", "[Address]"),
    ("Long Beach, CA 90803", "[Address]"),
    ("3606 Cimarron St", "[Address]"),
    ("3606 Cimarron Street Los Angeles, CA 90018", "[Address]"),
    ("LA, CA 90018", "[Address]"),
    ("Los Angeles, CA 90018", "[Address]"),
    ("8950 W. Olympic Blvd., Suite 495 Beverly Hills, CA 90211", "[Address]"),
    ("713 S Green ST, Pasadena, CA", "[Address]"),
    ("713 GREEN ST", "[Address]"),
    ("Altadena, CA 91001", "[Address]"),
    ("Torrance, CA 90505", "[Address]"),
]

for old, new in replacements:
    text = text.replace(old, new)

text = re.sub(r"\b[\w.+-]+@[\w.-]+\.[A-Za-z]{2,}\b", "[Contact]", text)
text = re.sub(r"\(\d{3}\)[\s-]?\d{3}[-. ]\d{4}", "[Contact]", text)
text = re.sub(r"\b[A-Z][a-z]+\s+[A-Z][a-z]+\b", "[Name]", text)

path.write_text(text, encoding="utf-8")
print(f"updated {path}")
