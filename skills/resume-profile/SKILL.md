---
name: resume-profile
description: >
  This skill should be used whenever the user wants to understand what jobs they qualify for, asks "what roles am I a fit for", "read my resume", "build my profile", "what should I be applying to", "what's my title", "what level am I", or any equivalent. Also runs automatically when any other side-door skill needs a profile and `side-door-workspace/profile.md` does not exist. Extracts hard skills, soft skills, domain experience, seniority, years of experience, location/work-authorization signals, and a ranked list of job titles the user is qualified for — written to `side-door-workspace/profile.md` as the canonical profile every other skill reads.
metadata:
  version: "0.1.0"
---

# Resume Profile

You are building the canonical profile of the user from their resume. Every other skill in the plugin reads `side-door-workspace/profile.md`. Get this right and the rest works; get it sloppy and everything downstream is off.

## Step 1 — Find the resume

Look in the working folder root for: `*.pdf`, `*.docx`, `*.doc`, `*.md`, `*.txt` whose filename contains `resume`, `cv`, or matches the user's name pattern. If multiple candidates exist, prefer the most recently modified.

If no resume is found, ask the user to drop one into the folder. Do not invent a profile from chat history.

## Step 2 — Extract the raw text

- **PDF**: Use the `pdf` skill (Read tool on the PDF works for short ones; for long PDFs use the pdf skill's extraction scripts).
- **DOCX**: Use the `docx` skill to extract text.
- **MD / TXT**: Read directly.

If extraction yields garbage (OCR artefacts, columns interleaved), tell the user and ask for a cleaner version. Do not guess.

## Step 3 — Build the profile

Read `references/profile-schema.md` for the exact output format. The profile must contain:

1. **Identity & contact** — name, email, phone, location (city + country), LinkedIn, portfolio. Mark each as present/missing.
2. **Years of experience** — calculated from the earliest dated role to the latest, minus obvious gaps. State the calculation.
3. **Seniority signals** — junior / mid / senior / staff / principal / director / VP / C-level. Justify with two pieces of evidence from the resume (team size led, scope of decisions, titles held, years in field). If signals conflict (e.g., "Senior Engineer" title but 2 years of experience), flag it.
4. **Hard skills** — grouped by category (languages, frameworks, tools, platforms, domain). Mark each as `core` (used in 2+ roles or named in the headline) or `mentioned` (listed but no role detail).
5. **Soft skills** — only those evidenced by a concrete sentence in the resume. No filler ("team player", "passionate") unless backed by a bullet.
6. **Domain experience** — industries the user has shipped in (fintech, healthcare, B2B SaaS, public sector, etc.), with the company that proves it.
7. **Work authorization signals** — visa status, citizenship, "open to relocation", remote preferences, if stated. If not stated, write `Not stated`.
8. **Languages spoken** — only if listed on the resume.
9. **Education** — degree, institution, year. If a CS degree exists but the user worked as a marketer for ten years, weight the work history, not the degree.
10. **Red flags / clarifications needed** — gaps over 12 months, very short tenures, missing dates, unclear titles. Surface these — they affect targeting.

## Step 4 — Infer qualified job titles

This is the hard part. The user did not give you a target title. Do not assume one from their most recent role.

For each candidate title:

- **Title** — the canonical industry name (use the most common variant, not a niche one).
- **Seniority** — match the user's seniority to the title's expected band.
- **Fit score** — `strong` (matches 80%+ of the typical requirements), `stretch` (50–80%, would need to argue some adjacent experience), `aspirational` (under 50%, would need a story).
- **Why** — one sentence grounded in resume evidence.
- **Why not** — one honest sentence about what's weak or missing.

Generate **5–10 candidate titles**, spanning:

- The obvious next step from the most recent role.
- Lateral moves into adjacent functions (e.g., backend engineer → DevOps, platform, ML infra).
- Step-up moves at the same function (e.g., Senior → Staff).
- One or two stretch titles that match the user's domain expertise but a different function (e.g., senior engineer in healthtech → technical product manager).

**Do not** include titles the user is plainly not qualified for. "Aspirational" still needs adjacent evidence.

## Step 5 — Write the profile

Write to `side-door-workspace/profile.md` using the exact schema in `references/profile-schema.md`. Overwrite any existing file but tell the user you did so.

## Step 6 — Brief the user

Surface only the headlines:

- "Read your resume — here's what I'd target."
- The 3 strongest candidate titles, with one-line "why" each.
- 1–2 stretch titles, with the gap to close.
- Any red flags (career gap, very recent role change, missing dates) that need a clarification before applying.
- Where the profile was saved.

Ask if they want to (a) refine any of the title targets, (b) run `job-search` now to find postings, or (c) tailor for a specific posting they already have.

## What this skill never does

- Never invent skills or years of experience the resume does not support.
- Never assume the user wants their most recent title again — they may want a step up or a pivot.
- Never read the profile aloud in full — it's a file; surface headlines.
- Never overwrite a resume file. Only writes the profile.
