---
name: tailor-resume
description: >
  This skill should be used when the user wants to tailor their resume for one specific posting. Triggers: "tailor my resume for this job", "rewrite my resume for {URL}", "customize my CV for this posting", "make me a resume for the X role", "fit my resume to this JD". Does NOT write the cover letter — that's the cover-letter skill, which runs after this one. Reads `side-door-workspace/profile.md` and the parsed posting file, then produces a tailored resume as a DOCX in `side-door-workspace/jobs/{company}-{role}-{YYMM}/resume.docx`. Never invents facts. Surfaces the JD-to-resume mapping table so the user can sanity-check. Runs an ATS keyword diff and an honest gap flag.
metadata:
  version: "0.1.0"
---

# Tailor Resume

You are rewriting the user's resume for ONE specific posting. The user reviews every word; you do not press send. Two non-negotiables:

1. **Truth.** Never claim experience the original resume does not support. Tailoring means selecting, ordering, and phrasing — not inventing.
2. **Specificity.** The output must read like it was written for this posting — not a generic "senior engineer" resume.

This skill produces ONLY the resume. The cover letter is a separate skill (`cover-letter`) that runs after this one and reads what this skill produced.

## Step 1 — Identify the posting

Get the posting one of three ways:

- User pasted a URL → fetch and parse it now (use `WebFetch` or Chrome). If parsing fails, fall back to asking the user for the JD text.
- User referenced a posting from `shortlist.md` ("the second strong fit", "the Acme one") → read `side-door-workspace/postings/<slug>.md`.
- User pasted the JD text directly → parse it inline; save it to `postings/` for reuse.

Confirm the posting back to the user in one sentence before you start writing.

## Step 1.5 — Identify the ATS and hiring path

Check the posting file's `ATS:` and `Hiring path:` fields (or detect from the apply URL using `../../references/agency-and-ats-detection.md`).

The ATS determines format choices:

- **Strict parsers** (Workday, Taleo, SuccessFactors, iCIMS): DOCX, plain `-` or `•` bullets, single column, no tables, no text boxes, no headers/footers, headings as bold text rather than styled.
- **Lenient parsers** (Greenhouse, Lever, Ashby, SmartRecruiters, Workable, Recruitee, Teamtailor, Pinpoint): DOCX or PDF both fine, basic tables and columns survive.
- **Unknown**: default to the strict profile — it's the safe option.

Record the ATS and hiring path at the top of `notes.md`.

## Step 2 — Read profile + posting side by side

Read:
- `side-door-workspace/profile.md` — the whole thing including the `## Stories bank`, `## Honest gaps`, and `## Salary history` sections if they exist (added by `setup-interview`).
- The posting file.

## Step 3 — Build the mapping table

For each must-have in the JD, identify ONE bullet (or one story from the Stories bank) that proves it. If you can't find one, mark it as "no proof". Show the user the table before you write:

```
JD must-have                    -> Resume bullet to lift                                          | Confidence
Python at scale                 -> "Migrated batch pipeline to Spark, 4x throughput" (Acme, 2022) | high
Mentor junior engineers         -> NO PROOF — will surface as gap                                 | n/a
Healthcare regulatory exposure  -> Story "HIPAA Audit Lead" from stories bank                     | high
```

If multiple must-haves have "no proof", tell the user before tailoring — sometimes the answer is "this posting is a stretch, skip it".

## Step 4 — ATS keyword diff

Run a keyword diff between the JD's must-haves and the current resume. Bucket each must-have:

- **Present verbatim** — no action.
- **Present as synonym** — consider replacing the user's wording with the JD's exact phrase IF the underlying skill is genuinely the same.
- **Missing but the user has the experience** (per profile/stories bank) — surface to the user with a question to extract the detail you need to add it. This is the interrogation loop.
- **Missing entirely** — do NOT add. Flag as a gap in `notes.md`.

Surface the bucket counts to the user briefly: "4 must-haves present, 1 synonym-rephrase recommended, 1 you have but isn't on the resume yet (need to add), 1 honest gap."

## Step 5 — Metric interrogation

Scan the user's existing bullets for missing numbers. Pick 3–5 verb-heavy bullets that have no metric and ask one question each that might surface one:

- "Led the migration to Postgres" → "How long did it take and what changed in latency or cost?"
- "Owned onboarding redesign" → "What changed in activation rate or time-to-first-action?"
- "Mentored junior engineers" → "How many, and over what period?"

Ask these together. The user answers what they can; you fold the answers into the bullets.

## Step 6 — Tailor

Read `references/resume-tailoring-rules.md` for the exact rewriting rules. Generate the tailored resume as a DOCX using the `docx` skill. Save to:

`side-door-workspace/jobs/<company-slug>-<role-slug>-<YYMM>/resume.docx`

(Note: the folder name format is `<company>-<role>-<YYMM>` — `application-tracker` uses the same convention so logging joins cleanly.)

## Step 7 — Save notes.md

In the same job folder, write `notes.md`:

- ATS and hiring path (from Step 1.5).
- The mapping table from Step 3.
- The ATS keyword diff buckets from Step 4.
- The metric-interrogation answers folded in.
- The honest gaps you flagged (read from `## Honest gaps` in profile.md and from "no proof" rows in the mapping table).
- Rewriting choices: 1–2 sentences explaining the most consequential edits.

This file is what `cover-letter` reads next.

## Step 8 — Brief the user

Tell them, in 3–5 lines:

- Where the resume.docx was saved.
- The mapping summary (X/Y must-haves matched, gaps).
- The 2–3 most consequential edits.

Then offer:

1. "Write the cover letter for this one" — invoke `cover-letter`.
2. "Log this as `tailored, ready to apply` in the tracker" — invoke `application-tracker`.
3. "Find more roles like this" — invoke `job-search`.

## What this skill never does

- Never invents skills, projects, certifications, employers, or dates.
- Never claims experience the resume + stories bank don't support.
- Never overwrites the user's original resume — only writes to `jobs/`.
- Never writes the cover letter. That's the `cover-letter` skill.
- Never modifies company names, titles, or dates on the resume.
