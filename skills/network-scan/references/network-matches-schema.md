# network-matches.md schema

Canonical format for `side-door-workspace/network-matches.md`.

```markdown
# Network matches — {YYYY-MM-DD}

_Scanned {N} contacts from `Connections.csv` against {M} target companies._

## Top warm-intro opportunities (score 6+)

| # | Company | Contact | Their role | Connected on | Posting fit | Score | Has email? |
| - | --- | --- | --- | --- | --- | --- | --- |
| 1 | {Company} | {Name} | {Position} | {YYYY-MM} | Strong (84) | 9 | yes |
| 2 | {Company} | {Name} | {Position} | {YYYY-MM} | Strong (78) | 8 | no |

## Worth a message (score 4–5)

| # | Company | Contact | Their role | Connected on | Posting fit | Score |
| - | --- | --- | --- | --- | --- | --- |

## Long shots / FYI (score 1–3)

| # | Company | Contact | Their role | Connected on | Posting fit | Score |
| - | --- | --- | --- | --- | --- | --- |

## Target companies with no contacts

These are on the shortlist (or target list) but you have no LinkedIn connection there. Cold-outreach territory.

- {Company}
- {Company}
- {Company}

## Outreach templates

### Template A — message to a contact you haven't talked to in 1–3 years

> Hey {first name} — random ping. I've been looking at {Company} for a {role} role (the {specific posting/team} one), and I noticed you're {their current role} there. Would you be open to a 15-minute call so I can ask three questions before I apply? Happy to send the questions in advance.

### Template B — direct message asking for an intro to the hiring manager

> Hi {first name}, hope you're well. I'm applying to {role} at {Company} and saw on the JD it reports to {hiring manager name if known, otherwise "the {function} team"}. Would you be willing to introduce me, or point me to who I should be talking to? I'll send a one-paragraph "why me" you can forward.

### Template C — short note to a recruiter contact at the target

> Hi {first name}, are you working on {role / {team}} reqs at {Company}? I'm seriously interested and have {specific aligned experience}. Happy to send my CV or just chat first.

## How to use this file

- Pick the top 1–3 from "warm-intro opportunities".
- Send Template A to start (low ask). Template B comes after they reply.
- Template C is for recruiter contacts specifically — direct.
- Mark each company you reach out to as `interested` in the tracker so you don't double up.
- Re-run `network-scan` after refreshing the shortlist.

---

## Limitations of this scan

- The CSV is point-in-time. Some contacts may have changed employer; check LinkedIn before messaging.
- Tie strength is approximated by connection date only. The user's own knowledge of "can I actually message this person" is the deciding factor.
- "Has email?" indicates only whether the email is in the CSV — not that emailing is the right channel. LinkedIn DM is usually warmer.
```

Rules:

- Never include the contact's email address in this file — only "yes / no" on whether one was in the CSV.
- Never include profile URLs unless the user explicitly asks (they can be looked up from the CSV).
- Always include the "Target companies with no contacts" section — it tells the user where to switch to cold outreach.
