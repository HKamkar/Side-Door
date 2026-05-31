# Resume tailoring rules

Strict rules for how the tailored resume must differ from the original.

## What you may change

- **Summary / objective line.** Rewrite to mirror the JD's language using truthful claims only. 2–3 sentences max.
- **Order of bullets within a role.** Most-relevant-to-JD first.
- **Selection of bullets within a role.** Suppress bullets that are noise for this JD. Keep 3–6 per recent role, 2–4 for older roles.
- **Wording of bullets.** Replace the user's wording with the JD's vocabulary ONLY when the underlying fact is the same. Examples:
  - User wrote "designed REST endpoints" → JD says "APIs" → "Designed REST APIs" is fine.
  - User wrote "led migration to Postgres" → JD says "MySQL" → DO NOT change. You may instead say "led a relational database migration" if you need to abstract.
- **Skills section grouping/order.** Reorder skills so JD-relevant ones lead. Do NOT add skills not in the profile's `core` or `mentioned` lists.

## What you must NOT change

- Company names, titles, dates, locations, education facts.
- Any factual claim about scope, scale, or outcomes (numbers, team sizes, percentages).
- The resume's overall length by more than ~15% unless the user asked.

## What you must NOT add

- Skills the user does not have on their resume.
- Certifications, licenses, or memberships not on the original.
- Projects, employers, or volunteer work not on the original.
- Quantified outcomes not on the original ("increased revenue 30%" only if the user wrote that, not because the JD wants metrics).

## Format

- Use the `docx` skill to produce a clean DOCX.
- One-page if the original was one page; two-page if the original was two pages.
- ATS-friendly format: text only, no tables, no text boxes, no images, no columns. Headers at H2, role titles at H3.
- Standard fonts: Calibri or Helvetica, 10–11pt body, 14–16pt name.
- Do NOT include a photo even if the original had one (US/UK conventions don't include photos; if the user is targeting a region where photos are standard like DE/JP/BR, keep the original).

### ATS-specific tightening

If the target ATS is one of the strict parsers (Workday, Taleo, SuccessFactors, iCIMS):

- Use only `-` or `•` for bullets — no other glyphs.
- Single column always.
- No tables for skills (use comma-separated lists in a `Skills` heading instead).
- No headers or footers (Workday strips them silently and re-flows the page).
- Headings as bold text, not styled paragraphs.
- No icons in section headers.

If the ATS is lenient (Greenhouse, Lever, Ashby, SmartRecruiters, Workable, Recruitee, Teamtailor, Pinpoint) and the original resume had a clean two-column or skills-table layout that worked, you may keep it.

## ATS keyword diff (do this BEFORE rewriting)

Before tailoring bullets, do a keyword diff between the JD and the current resume:

1. List every must-have skill / tool / domain term from the JD.
2. For each, check: is the exact phrase present in the resume? Is a close synonym present? Is the underlying experience present but worded differently?
3. Output a 3-bucket diff:
   - **Present verbatim** — no action.
   - **Present as synonym or close variant** — consider replacing the user's wording with the JD's exact phrase IF the underlying skill is genuinely the same.
   - **Missing on resume but present in the user's actual experience** — surface to the user with a question: "you said you led X — did you also do Y? If so, want to add a line?" This is the interrogation loop.
   - **Missing entirely** — do NOT add. Flag as a gap in `notes.md`.

This step makes the tailoring honest AND keyword-aware. The ATS filter is real; truth-fabrication is also real. The diff resolves both.

## Metric interrogation

While tailoring, scan the user's existing bullets for missed numbers. For each verb-heavy bullet without a number, ask one question that might surface a metric:

- "Led the migration to Postgres" → "How long did the migration take, and what changed in latency or cost?"
- "Owned onboarding redesign" → "What changed in activation rate or time-to-first-action?"
- "Mentored junior engineers" → "How many, and over what period?"

Limit to 3–5 questions per resume — past that, fatigue. The user answers what they can; you fold the answers into the bullets.

## Honesty test

Before saving, run this mental check on every modified bullet: "If the hiring manager asked the user to elaborate on this in an interview, could the user do it without lying?" If the answer is no for any bullet, rewrite or remove it.
