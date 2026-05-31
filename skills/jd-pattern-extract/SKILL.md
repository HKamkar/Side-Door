---
name: jd-pattern-extract
description: >
  This skill should be used when the user wants to find the pattern across multiple job descriptions for the same kind of role. Triggers: "what do these jobs all want", "find the common pattern in these JDs", "what should I emphasize for senior backend roles", "compare these 5 postings", "what do recruiters in this field actually look for", "give me the shared requirements", "what skills come up everywhere". Reads 3-6 job descriptions (from `side-door-workspace/postings/`, pasted URLs, or pasted text), then extracts the union and intersection of requirements, the recurring vocabulary, the comp band pattern, and the seniority signal. Writes `side-door-workspace/patterns/{title-slug}-{YYYYMMDD}.md` — the "what to emphasize everywhere" output that informs the profile, resume, and search.
metadata:
  version: "0.1.0"
---

# JD Pattern Extract

You are finding the signal across multiple job descriptions for the same kind of role. One posting is a sample of one. Three to six postings tell you what the market actually wants — independent of any single hiring manager's preferences.

## Step 1 — Collect the JDs

You need 3–6 postings for the SAME role family (e.g., all "Senior Backend Engineer" postings, or all "Product Marketing Manager" postings). Mixing senior backend with junior PM produces noise — refuse and ask the user to narrow.

Three sources, in order of preference:

1. **From `side-door-workspace/postings/`** — if the shortlist already has parsed postings, ask the user which ones to pattern (offer the top 5 by score from `shortlist.md`).
2. **Pasted URLs** — fetch each via `WebFetch` or Chrome MCP. Parse into the same posting schema and save to `postings/`.
3. **Pasted JD text** — parse inline, save to `postings/raw-{slug}.md`.

If fewer than 3 JDs are available, tell the user the output will be unreliable and ask for more. If more than 6, ask which 6 — past that the analysis flattens.

Confirm the role family in one sentence ("Patterning 5 Senior Backend Engineer postings: Acme, BetaCorp, CharlieAI, Delta, Echo") before proceeding.

## Step 2 — Tabulate requirements

Build a requirements matrix in memory. Rows = every unique requirement that appears in any JD. Columns = the JDs. Mark each cell:

- **M** — must-have in this JD
- **N** — nice-to-have in this JD
- **·** — not mentioned

Normalize aggressively. "Python" and "Python 3" are one row. "Distributed systems" and "scaling distributed systems" are one row. "Postgres" and "PostgreSQL" are one row. "AWS" and "cloud (AWS/GCP/Azure)" — these are NOT the same; the second is the row "any major cloud" and AWS-specific is its own row underneath.

Use `references/normalization-rules.md` for the canonical list of merges.

## Step 3 — Bucket the requirements

From the matrix, classify each row:

- **Universal must (in 80%+ of postings as M)** — these are the table stakes. Resume must show these clearly. Cover letter must mention them.
- **Common must (50–79% as M)** — strong signals. Lead with them in your "key skills" section if you have them.
- **Differentiator (in 1–2 postings only, as M or N)** — interesting for the specific posting but don't reshape the whole resume around it.
- **Universal nice (in 50%+ as N)** — bonus material; one mention in resume is enough.
- **Noise (in 1 posting only as N)** — ignore.

## Step 4 — Extract the recurring vocabulary

Beyond requirements, capture the *words* the JDs repeat. Make four lists:

- **Verbs the JDs use** — "architect", "ship", "drive", "own", "scale", "mentor", "lead". These tell you what action vocabulary belongs in the resume.
- **Tools and platforms named** — frequency-sorted list.
- **Domain phrases** — e.g., "high-throughput", "B2B SaaS", "regulated industry", "consumer-facing", "internal tooling". These tell you the kind of work, not the skills.
- **Seniority signals** — phrases like "ambiguity", "across orgs", "set technical direction", "0-to-1", "scale beyond" — these are the markers that separate senior from mid.

For each list, show the top 10 by frequency, with counts.

## Step 5 — Compute the meta-signals

- **Comp band pattern** — for postings that disclose comp, show the range. Note the median. If half disclose and half don't, mention the asymmetry.
- **Seniority calibration** — average "years required" if stated. Note the variance.
- **Remote / location pattern** — what fraction are remote / hybrid / on-site. Geographic concentration if any.
- **Hiring agency vs in-house** — which postings are direct from the company vs via an agency (Hays, Robert Half, Michael Page, Randstad, etc.). See `../../references/agency-and-ats-detection.md` for the lookup heuristics.
- **ATS pattern** — which ATSes appear across the postings (Workday, Greenhouse, Lever, Ashby, SmartRecruiters, iCIMS, etc.). Same reference.

## Step 6 — Write the pattern brief

Write `side-door-workspace/patterns/<title-slug>-<YYYYMMDD>.md` using `references/pattern-brief-schema.md`. The brief is structured so:

- Section 1 — "If you do nothing else": the top 5 universal musts and the top 5 recurring verbs, plus a recommended resume summary line built from the intersection.
- Section 2 — the full requirements matrix.
- Section 3 — the vocabulary lists.
- Section 4 — the meta-signals (comp, seniority, location, agency/ATS).
- Section 5 — a candidate-side action list: "in your profile, add X. In your resume, surface Y. When searching, broaden/narrow to Z."

## Step 7 — Reconcile against profile

Read `side-door-workspace/profile.md`. Compare the universal musts to the user's `core` skills:

- **Already shown** — universal must matches a `core` skill on the profile. No action.
- **Buried** — user has the skill but it's only in one bullet or in `mentioned`, not `core`. Flag: "promote to lead skill".
- **Gap** — user does not have a universal must. Flag honestly. This is the gap to close (course, side project, narrative reframe) — or the signal to widen the role search.

Output the reconciliation as a 3-column table in the brief.

## Step 8 — Brief the user

In chat, surface only:

- Role family + N postings analyzed.
- Top 3 universal musts.
- Top 3 recurring verbs (so the user can hear how the market talks).
- The 1–2 most consequential gaps from the reconciliation.
- Where the brief was saved.

Offer next moves:

1. "Update my profile with these targeting changes" — invoke `resume-profile` with the pattern brief as input.
2. "Tailor a resume for the top fit using this pattern as the baseline" — invoke `tailor-application`.
3. "Refine the search with these signals" — invoke `job-search`.

## What this skill never does

- Never patterns fewer than 3 JDs and pretends the output is reliable.
- Never mixes role families ("senior backend" + "staff backend" + "principal architect" are not the same family).
- Never invents a "universal must" from a phrase that only appears in one posting.
- Never tells the user a gap is unfixable — every gap is a course / project / reframe / search-widening, and the brief should suggest which.
