---
name: cover-letter
description: >
  This skill should be used when the user wants a cover letter for one specific posting. Triggers: "write a cover letter for {company}", "draft my cover letter", "cover letter for the X role", "write the letter for this one", "make me the cover letter". Reads the JD, the profile, the stories bank, and (if present) what `tailor-resume` already saved in the job folder — so the cover letter aligns with the tailored resume rather than introducing different framings. Writes `cover-letter.docx` next to `resume.docx`. Strict rules: 250–400 words, three or four paragraphs, no banned phrases, opening line must reference something specific about the company.
metadata:
  version: "0.1.0"
---

# Cover Letter

You are writing one cover letter for one posting. Not the resume — that's `tailor-resume`. A good cover letter is a short, specific argument for why this user, for this role, at this company. Not a recap of the resume.

## Step 1 — Locate the job folder

Three modes — match the user's wording:

- **"the last one" / "for that one" / empty intent / "write the cover letter"** → look at `side-door-workspace/jobs/` and pick the most recently modified folder. Confirm with the user in one line ("Writing the cover letter for {Company} — {Role} in {YYMM}, the one we tailored 12 min ago. OK?") before proceeding.
- **A specific company or posting URL the user names** → find or create the matching `side-door-workspace/jobs/{company}-{role}-{YYMM}/` folder. If the posting is new, parse it like `tailor-resume` does (or invoke `tailor-resume` first if the resume isn't tailored yet — the cover letter aligns better when it does).
- **Standalone (no tailored resume yet)** → proceed, but tell the user the letter will read better if `tailor-resume` runs first. Create the job folder yourself.

If multiple recent folders exist and intent is ambiguous, list the 3 most recent and let the user pick.

## Step 2 — Read the substrate

Read in order:

1. `side-door-workspace/profile.md` — including the `## Stories bank` if `setup-interview` has run.
2. The posting file: `side-door-workspace/postings/<slug>.md`.
3. `<job-folder>/notes.md` if `tailor-resume` already ran — this tells you which bullets / stories the resume foregrounded, so the cover letter doesn't contradict the resume's emphasis.
4. The ATS field tells you almost nothing about cover letters (most ATSes have a free-text field). The hiring path matters more — see Step 3.

## Step 3 — Hiring-path framing

Check the posting's `Hiring path:` field.

- **Direct (company)** — addressed to "Hiring Team at {Company}" or to a named hiring manager if known. Body talks directly to the company.
- **Agency** — addressed to the recruiter (by name if known, "Hiring Team at {Agency}" otherwise). Body acknowledges briefly that you understand they're representing a client and that you're open to a quick discussion of the client's specifics. Don't name a client the agency hasn't introduced.

## Step 4 — Company-specific opener

The first paragraph must reference one specific thing about the company that's not a Wikipedia summary. Acceptable sources:

- A recent product launch (last 12 months).
- A public roadmap post or engineering blog.
- A talk or paper by the hiring manager or named interviewer.
- A customer story they published.
- A funding round and what it implies.

Do a quick web check (`WebSearch` or Chrome) for one of these. If you genuinely can't find anything specific in ~5 minutes, ASK the user: "I can't find a specific thing about {Company} I'm confident about. Anything you'd like me to reference — something you saw recently or know about them?" Do not fabricate a "recent launch" or invent a quote.

## Step 5 — Write

Follow `references/cover-letter-rules.md` strictly. Summary:

- **Para 1 (40–80 words)** — name the role + the specific company thing + why it matters to the user.
- **Para 2 (80–140 words)** — 2 concrete proofs from real resume/profile experience, each one sentence (situation–action–outcome), mapped to the JD's top 2 requirements.
- **Para 3 (60–100 words)** — why this company specifically (not "this kind of company"). One sentence connecting the user's domain experience or stated narrative (from `## Aspirational anchor` if present) to the company's mission/product.
- **Para 4 (30–50 words)** — call to action + location/availability if relevant + thanks + name.

Total: 250–400 words.

Voice: first person, active. Plain language. No banned phrases (`../../references/banned-phrases.md`).

## Step 6 — Self-critique pass (mandatory before saving)

Walk every sentence of the draft. For each, run these checks:

1. **Em dash check.** Search the draft for `—` and `–`. Both are banned in this format. Replace with commas, periods, colons, semicolons, parentheses, or hyphens.
2. **Sentence length.** Any sentence over 25 words → split or shorten.
3. **Read-aloud test.** If a sentence takes more than one breath to read out loud, cut or split it.
4. **Consecutive-sentence variation.** No two consecutive sentences begin with the same word or the same structure ("I led... I built... I shipped..." → vary).
5. **Tense and attribution discipline** — see `references/cover-letter-rules.md` for the rules. Past roles in past tense; present tense ONLY for roles with end date "Present". Every company name has the cited achievement traceable to THAT company's role + date range on the resume — never merge metrics from different companies into one sentence. No "earlier" / "later" without checking resume dates first.
6. **Banned-phrases sweep.** Grep the draft against `../../references/banned-phrases.md`. Zero tolerance — every banned phrase is replaced or cut.

If any check fails, fix BEFORE saving the DOCX. The cover letter is short; a single AI-tic sentence can sink the whole document.

## Step 7 — Output

Save as DOCX using the `docx` skill: `<job-folder>/cover-letter.docx`.

Append to `<job-folder>/notes.md`:
- The specific company hook you used and its source URL.
- Any fact in the letter the user should verify before sending.
- Word count.

## Step 8 — Brief the user

Tell them, in 3–5 lines:

- Where the cover letter was saved.
- The company-specific hook you used + the source URL.
- The 2 proofs you pulled and which JD requirements they map to.
- Anything you want them to verify before sending.

Then offer:

1. "Log this as `tailored, ready to apply` in the tracker" — invoke `application-tracker`.
2. "Mark as applied" — invoke `application-tracker` with status `applied`.
3. "Prep me for the interview" — invoke `interview-prep`.

## What this skill never does

- Never writes more than 400 words.
- Never fabricates a company specific. If you can't find one, ask.
- Never uses any phrase from the banned-phrases reference.
- Never contradicts the tailored resume's emphasis if `tailor-resume` has already run for this posting.
- Never re-litigates the resume's content. The cover letter is an argument, not a summary.
- Never claims a relationship with the company (employees, customers, alums) that the user hasn't stated.
