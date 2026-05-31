---
name: application-tracker
description: >
  This skill should be used when the user wants to log, query, update, or review their job applications, OR to manage reusable application form answers ("application-data"). Triggers: "what did I apply to", "show me my applications", "log this as applied", "mark this as rejected", "what's my next follow-up", "any deadlines this week", "I heard back from {company}", "add a note to {company}", "what's the status of {role}", "weekly application report", "save this answer for next time", "what's my standard answer to {form question}", "update my form answers", "my salary expectation is X". Maintains TWO files: (1) `side-door-workspace/applications.csv` — one row per application, with status, dates, source; (2) `side-door-workspace/application-data.md` — reusable answers to common form fields (salary expectation, citizenship, why-this-company stock phrase, visa status, years of experience, etc.) so the user doesn't retype them per application.
metadata:
  version: "0.1.0"
---

# Application Tracker

You are maintaining the user's application state. Two files, both source-of-truth:

1. **`side-door-workspace/applications.csv`** — the log: one row per application. What you applied to, when, status, next action.
2. **`side-door-workspace/application-data.md`** — the reusable answers: salary expectation, citizenship, visa status, years of experience, "why this company" stock phrasing, etc. Pulled when filling out an application form to save the user from retyping.

Every other skill reads from and writes to these files through this skill.

## CSV schema

The CSV has exactly these columns, in order:

```
id,company,role,location,source_url,date_added,date_applied,status,next_action,next_action_date,salary_range,recruiter_name,recruiter_email,interview_dates,notes
```

- **id** — short slug: `{company-slug}-{role-slug}-{YYMM}` (e.g., `acme-senior-eng-2606`). This MUST match the folder name `tailor-resume` and `cover-letter` use under `jobs/`, so the tracker row and the tailored files cross-reference cleanly.
- **company** — display name
- **role** — display title (the one from the JD)
- **location** — city/country or "Remote"
- **source_url** — the posting URL
- **date_added** — YYYY-MM-DD
- **date_applied** — YYYY-MM-DD or empty
- **status** — one of: `interested`, `tailored`, `applied`, `screening`, `interviewing`, `offer`, `rejected`, `withdrawn`, `ghosted`, `accepted`
- **next_action** — short string: "send follow-up email", "respond to Sarah", "prepare for technical round", or empty
- **next_action_date** — YYYY-MM-DD or empty
- **salary_range** — as stated in JD or offer
- **recruiter_name** — or empty
- **recruiter_email** — or empty
- **interview_dates** — semicolon-separated list: "2026-06-03 (screen);2026-06-10 (tech)"
- **notes** — freeform; semicolons are NOT allowed (use commas or new entries)

Always quote fields if they contain commas. Always preserve column order.

## Operations

### Add a new application
- Generate id from company + role + YYMM.
- Default status: `interested`. If the user is logging a tailored package, use `tailored`. If they say "I applied", use `applied` and fill `date_applied`.
- If the source posting exists in `side-door-workspace/postings/`, mirror its URL and location.
- Append the row to the CSV.

### Update an existing application
- Find by id, or by company + role (ask if ambiguous).
- Update the column(s) requested. Preserve everything else.
- If status moves to `applied` and `date_applied` is empty, fill it with today.
- If status moves to `interviewing`, ask for the interview date and add it to `interview_dates`.
- If status moves to `offer`, `rejected`, `accepted`, `withdrawn`: clear `next_action` and `next_action_date`.
- If status moves to `ghosted`: only do this 14+ days after last activity. Confirm with the user.

### Query
- "What's open?" → all rows where status ∈ {tailored, applied, screening, interviewing}.
- "What's overdue?" → rows where `next_action_date` ≤ today AND status not in {rejected, withdrawn, ghosted, accepted}.
- "What's this week?" → rows where `next_action_date` is in the next 7 days.
- "Status of {company}" → that row.
- Render as a clean table in chat. Don't paste the whole CSV unless asked.

### Weekly report
- Total apps in the last 7 days.
- Funnel: interested → tailored → applied → screening → interviewing → offer.
- Conversion since last week (e.g., 12 applied → 3 screening — 25% recruiter-screen rate).
- Stale: applied >21 days ago with no response, suggest follow-up or mark as ghosted.
- Top 3 next actions for the coming week.

### Bulk import from shortlist
- When the user says "log the shortlist", read `side-door-workspace/shortlist.md`, add each Strong fit + Worth a shot as `interested`. Skip Stretch unless user says otherwise.
- Skip ids that already exist in the CSV.

## Status state machine

Valid transitions only — flag anything weird:

```
interested → tailored → applied → screening → interviewing → offer → accepted
                                                                  → rejected
        any state → withdrawn (user pulled the application)
applied / screening / interviewing → ghosted (no response 14+ days)
applied / screening / interviewing → rejected (employer pulled)
```

If a user says "I applied to {company}" but no row exists, ask if you should create one — they may have applied outside the plugin.

## Initialization

If `side-door-workspace/applications.csv` does not exist, create it with just the header row. Do not invent past applications.

If `side-door-workspace/application-data.md` does not exist, create it with the schema in `references/application-data-schema.md` and ALL fields blank — the user fills them in over time, or you fill them in when you learn them from setup-interview / from a question the user just answered.

## Application-data operations

The application-data.md file holds the reusable answers. Schema in `references/application-data-schema.md`. Key fields:

- Salary expectation (per region / currency)
- Citizenship + work authorization status (per country)
- Visa sponsorship needed yes/no
- Current notice period
- Earliest start date
- Years of experience (computed; auto-update if profile.md updates)
- "Why are you interested in <field/function>" — a one-paragraph stock answer the user can adapt
- "What are you looking for in your next role" — a one-paragraph stock answer
- Diversity/EEO declarations the user is comfortable saving (only what the user volunteers)
- Reference contacts (name + relationship + email + permission-to-share status)
- Portfolio URLs, LinkedIn URL, GitHub URL

### When to read application-data.md

- When the user is filling out a form and asks "what should I put for X?" — look it up.
- When `tailor-resume` is producing notes and the JD asks for "expected comp" — pull from here.
- When `cover-letter` is writing — the "what are you looking for" stock answer may seed the third paragraph (rewritten for specificity).

### When to write to application-data.md

- When the user provides a reusable answer ("for any form, my salary expectation is €X" → save).
- When `setup-interview` runs (it captures salary floor, citizenship, etc. — sync those here so the form-filling lookup works).
- When a value changes ("my notice period is now 2 weeks, was 4" → update).

### Never write to application-data.md

- Sensitive personal info the user hasn't volunteered (race, religion, health, sexual orientation, exact home address). EEO declarations only if the user explicitly says "save this answer for next time".
- Passwords, account numbers, ID numbers.
- Anything from a third party without the user's involvement.

## Always

- Show the user the change you made in plain language ("Marked Acme Senior Engineer as `screening`, set next action: respond to Sarah by 2026-06-04").
- For destructive actions (delete a row, change status to `withdrawn`), ask once before doing it.
- Sort the report tables: by `next_action_date` ascending for action lists; by `date_applied` descending for status reviews.
- Convert relative dates ("next Friday") to absolute dates (YYYY-MM-DD) before writing to the CSV.

## Never

- Never delete rows on autopilot. Withdrawn / rejected / ghosted are statuses, not deletions.
- Never invent application history.
- Never change `date_applied` once set unless the user explicitly says "I applied on X date, fix it".
- Never paste full PII (recruiter emails, phone numbers) in chat unless the user explicitly asks.
