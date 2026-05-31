---
name: job-search
description: >
  This skill should be used when the user wants to find job listings, asks "find me jobs", "what jobs are out there for me", "search LinkedIn", "look on Indeed", "find roles like this", "any new postings", "what's open at {company}", or any equivalent. Also runs when the user pastes a job board URL and asks to scan it. Searches LinkedIn, Indeed, Glassdoor, Wellfound, and company career pages using Claude in Chrome when an active browser is available, otherwise falls back to WebSearch + WebFetch. Scores every found posting against `side-door-workspace/profile.md` and writes a ranked shortlist to `side-door-workspace/shortlist.md`. Saves each posting's parsed JD to `side-door-workspace/postings/{slug}.md` so other skills can read them.
metadata:
  version: "0.1.0"
---

# Job Search

You are finding job postings for the user and scoring them against their profile. Do not promise jobs. Do not invent listings — every posting on the shortlist must have a real, fetchable URL.

## Step 1 — Profile gate

Read `side-door-workspace/profile.md`. If it does not exist, invoke `resume-profile` first and then return here. Do not run a search against an empty profile — you would get noise.

From the profile, extract:

- The top 3–5 `strong` titles.
- 1–2 `stretch` titles (only if the user asked for stretch fits).
- Location and remote preference.
- Years of experience and seniority band (used to filter out "5+ years required" when the user has 1).

## Step 2 — Clarify the search

Ask the user three short questions before searching — do not assume defaults:

1. **Geography** — which city/country/region, or "remote only", or "open globally"? Default-suggest what's on the profile, but ask.
2. **Industry filters** — keep open, or focus on the user's strongest domains?
3. **Company size** — startup / scale-up / enterprise / no preference?

If the user said "just find me something" — pick the strongest defaults from the profile, tell them what you assumed, and proceed.

## Step 3 — Pick the sourcing mode

Decide one of three sourcing modes:

| Mode | When to use | How |
| --- | --- | --- |
| Browse | An active Chrome browser is connected (`mcp__Claude_in_Chrome__list_connected_browsers` returns one) and the user is logged in to LinkedIn or wants live board data | Use `mcp__Claude_in_Chrome__navigate` + `get_page_text` against LinkedIn, Indeed, Glassdoor, Wellfound, and 1–2 company pages |
| Search | No browser available, or user wants breadth over depth | `WebSearch` queries like `"{title}" "{location}" site:linkedin.com/jobs OR site:indeed.com OR site:wellfound.com`; then `WebFetch` each result |
| Paste | User provided 1+ URLs in the message | Skip the search; jump to step 4 with their URLs |

Before browsing, confirm the browser + Google account state with the user (per Claude in Chrome guidance). If the user only has a non-Chrome browser, fall back to Search mode.

Aim for 15–25 candidate postings to start. Quality over quantity — better to surface 8 strong fits than 40 noisy ones.

## Step 4 — Parse each posting

For each posting URL:

1. Fetch the page (Chrome or WebFetch).
2. Extract: company, title, location, remote/hybrid/on-site, seniority signals from the JD, must-have requirements, nice-to-have requirements, comp band if stated, posted date, application URL.
3. **Detect the hiring path and ATS** from the apply URL. Use `../../references/agency-and-ats-detection.md` — the URL pattern (`boards.greenhouse.io/*`, `jobs.lever.co/*`, `*.myworkdayjobs.com/*`, etc.) tells you the ATS. The apply-domain (e.g., `hays.com`, `roberthalf.com`, `michaelpage.*`, `randstad.*`) tells you if it's an agency posting. Record both in the posting file.
4. Write to `side-door-workspace/postings/<company-slug>-<title-slug>.md` using the schema in `references/posting-schema.md`.
5. If extraction fails (login wall, JS-rendered with empty body, 404), record the URL and skip — do not invent details.

## Step 5 — Score each posting

For each parsed posting, compute a fit score from the profile. Use `../../references/fit-scoring.md` for the exact criteria. Summary:

- **Title match** — does the posting title appear in the user's "Qualified job titles" list?
- **Seniority match** — does the JD's required years match the user's band?
- **Hard skill match** — what % of must-haves does the user demonstrably have (from `core` skills in profile)?
- **Domain match** — does the user have shipped experience in this industry?
- **Location / authorization match** — is location feasible? Does the JD ask for authorization the user does not have stated?
- **Recency / activity** — older than 30 days is colder; "posted today" is hotter.

Score each on a 0–100 scale with a one-line reason. Bucket into:

- **Strong fits** (75+) — apply within a week.
- **Worth a shot** (50–74) — apply if you have bandwidth; needs framing.
- **Stretch** (35–49) — only apply if the company is a 10/10 for the user; otherwise skip.
- **Skip** (under 35) — do not surface.

## Step 6 — Write the shortlist

Write `side-door-workspace/shortlist.md` using the schema in `references/shortlist-schema.md`. Sort by score within each bucket. Include the link, score, one-line reason, and the path to the parsed posting file.

If a prior shortlist exists, do not overwrite blindly — append new postings and mark the prior ones as "from previous run, status unchanged" unless the user said "fresh search".

## Step 7 — Brief the user

Surface only the top 5 Strong fits and the count in each bucket. Do not paste the whole shortlist. Offer three next moves:

1. "Tailor a resume + cover letter for the top fit" — invoke `tailor-application`.
2. "Show me the Stretch bucket too" — read out the next tier.
3. "Save these to the tracker" — invoke `application-tracker` to log them as `interested`.

## What this skill never does

- Never fabricate a job posting URL. Real URLs only.
- Never lie about whether a posting requires authorization the user lacks — flag it.
- Never recommend a posting with score under 35.
- Never overwrite a posting file the user has marked as `applied` in the tracker.
- Do not pay-walled scraping — if a site blocks, fall through to the next source and note it.
