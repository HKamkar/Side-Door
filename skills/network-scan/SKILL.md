---
name: network-scan
description: >
  This skill should be used when the user wants to find warm-intro opportunities — companies on their shortlist where they already have a LinkedIn connection who could intro them. Triggers: "who do I know at", "find my contacts at", "scan my network", "network match", "warm intros", "any connections at {company}", "where do I have an in". Reads the user's LinkedIn connections CSV (exported from LinkedIn's official data download), indexes contacts by company, then cross-references against the shortlist or against a user-supplied list of target companies. Writes `side-door-workspace/network-matches.md` ranking opportunities by closeness-of-connection × strength-of-shortlist-match. Honest about LinkedIn's data scope (the export does not give relationship strength signal; only "connected on" date).
metadata:
  version: "0.1.0"
---

# Network Scan

You are finding warm-intro paths through the user's existing network. Warm intros statistically convert at 4-10x cold applications. This skill is one of the highest-leverage moves in the plugin.

## Step 1 — Find the contacts file

Look for the user's LinkedIn connections export. Standard filenames:
- `Connections.csv` (LinkedIn's exact filename)
- `linkedin-connections.csv`
- `connections.csv`

Look in `side-door-workspace/`, the working folder root, and the user's Downloads folder if accessible.

If not found, instruct the user how to export — see `references/linkedin-export-howto.md`. Wait until the file is in place.

## Step 2 — Parse the CSV

LinkedIn's export has these columns (as of 2026):
- `First Name`, `Last Name`, `URL`, `Email Address`, `Company`, `Position`, `Connected On`

Parse all rows. Normalize:
- Strip whitespace.
- Lowercase company names for matching (but keep the original casing for display).
- Apply common-name aliases — `Google` matches `Google LLC` and `Alphabet`. `Meta` matches `Facebook`. Maintain a small alias list in `references/company-aliases.md`.

Skip rows with empty `Company` — they're not useful for matching.

Index by lowercased company → list of `{name, position, url, connected_on}`.

## Step 3 — Pick the target list

Three modes (the user's request determines which):

| Mode | Trigger | Source |
| --- | --- | --- |
| Shortlist scan | User said "scan my shortlist" or "find network matches" with a shortlist present | Read `side-door-workspace/shortlist.md`, extract every Company column |
| Custom list | User pasted or named target companies | Use those |
| Single company | "Who do I know at Stripe?" | Just that company |

## Step 4 — Match and score

For each target company, find matching contacts. Score each match on three signals:

1. **Recency** — `Connected On` date. More recent = warmer. 0–2 yrs ago: 3 pts. 2–5 yrs: 2 pts. 5+ yrs: 1 pt.
2. **Role relevance** — does the contact's `Position` plausibly know the hiring team for the role the user is targeting?
   - Hiring manager of that function: 3 pts.
   - Same function, different team (e.g., another senior engineer at the company): 2 pts.
   - Recruiter or talent at the company: 2 pts.
   - Other function: 1 pt.
3. **Posting-side signal** — how strong is the underlying posting fit (from `shortlist.md` if present)?
   - Strong fit (75+): 3 pts.
   - Worth a shot (50-74): 2 pts.
   - Stretch (35-49): 1 pt.
   - Not on shortlist: 0 pts (but still report).

Total: 0–9 pts. Sort matches by total, descending.

## Step 5 — Write network-matches.md

Use `references/network-matches-schema.md` for the format. Sections:

1. **Top warm-intro opportunities** — top 10 matches with score ≥ 6.
2. **Worth a message** — matches scoring 4–5.
3. **Long shots / FYI** — matches 1–3.
4. **Target companies with no contacts** — list these explicitly so the user knows where there's no warm path.
5. **Outreach templates** — three short templates the user can adapt (warm intro request, direct DM to contact, recruiter at target).

## Step 6 — Brief the user

Surface only the top 5 warm-intro opportunities + the count of "no contact" companies. Offer:

1. "Draft the intro message to {top contact}" — adapt the template inline.
2. "Tailor my resume for {top company} so I have it ready when the intro lands" — invoke `tailor-resume`.
3. "Log these companies as `interested` in my tracker" — invoke `application-tracker`.

## What this skill never does

- **Never scrapes LinkedIn live.** Only reads the official user-exported CSV. LinkedIn's TOS prohibits scraping; the data download is the supported path.
- **Never messages contacts on the user's behalf.** Drafts text; the user sends.
- **Never claims a relationship is closer than the data shows.** The CSV only has `Connected On`. It does not have "how often you've talked" or "how strong the tie is" — surface the user's own judgement as the deciding factor.
- **Never stores or surfaces contact data beyond what's needed.** Emails are noted as "have email" / "no email" — don't write the email to the matches file. The user can look it up in the CSV if they want it.
- **Never recommends a contact who left the company.** The CSV is point-in-time; before recommending an action, advise the user to check LinkedIn for the contact's current employer.
