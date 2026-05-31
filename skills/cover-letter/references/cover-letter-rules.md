# Cover letter rules

A cover letter is a short, specific argument for why this user, for this role, at this company. Not a recap of the resume.

## Structure

**Paragraph 1 — opening (40–80 words)**
- Name the exact role.
- Open with one specific thing about the company that proves you read more than the home page: a recent product launch, a public roadmap item, a blog post by the hiring manager, a recent funding round and what it implies, a customer story they published. Tie it to why the user wants this role.
- If no specific is available, surface that to the user — do not invent one.

**Paragraph 2 — proof (80–140 words)**
- 2 concrete proofs from the user's actual experience, mapped to the JD's top 2 requirements.
- Each proof is one sentence: situation, action, outcome (S-A-O). Lift directly from real resume bullets.
- Do not say "I have X years of experience" — that's the resume's job. Show, don't summarize.

**Paragraph 3 — fit and motivation (60–100 words)**
- Why this company specifically, not this kind of company.
- One sentence connecting the user's domain experience or values to the company's stated mission/product.
- Keep this short — generic motivation paragraphs are the worst part of bad cover letters.

**Paragraph 4 — close (30–50 words)**
- A direct call to action: "I'd welcome a conversation about how I can contribute to [team]."
- Location / availability if relevant ("I'm in Amsterdam and available within 4 weeks.").
- Thanks, full name.

## Total

250–400 words. Anything longer gets skimmed. Anything shorter feels like a form letter.

## Voice

- First person, active.
- Plain language. No "I am writing to express my keen interest" — start with the point.
- One contraction is fine if the user's resume tone allows; otherwise none.
- Match the formality of the company. Big bank → formal. Series A SaaS → conversational.

## What you must NOT do

- Don't restate the resume.
- Don't list every skill the user has — pick 2.
- Don't promise things the user can't back up.
- Don't claim familiarity with company internals you haven't verified.
- Don't use the phrases in `../../../references/banned-phrases.md`.

## Tense discipline

The single most common AI tic in cover letters is wrong tense.

- **Roles with end date "Present" on the resume** → that's the user's current role. Use present tense: *"I lead..."*, *"I own..."*.
- **All other roles** → past role. Use past tense: *"I led..."*, *"I owned..."*. Even if the project was impressive, the user is not currently doing it.
- **Never** describe a non-current role with phrases like "in my current role at {prior employer}" — that's an unforced factual error.

If the resume is ambiguous about whether a role is current, default to past tense and surface the question to the user.

## Company-attribution lock

Every sentence that names a company must say something the resume attributes to THAT company's role + date range. Specifically:

- **Don't merge metrics from different companies into one sentence.** If the user shipped X at Company A and grew Y at Company B, that's two sentences, not one. "I shipped X at Acme and grew Y by 40%" reads as if both happened at Acme.
- **Don't use temporal connectors** ("earlier," "later," "before that") unless you have verified the chronology against the resume's date ranges. AI models invent timelines.
- **Final pass before saving**: for every company name in the letter, read the corresponding role on the resume and confirm the cited achievement is right there. If it's not, fix the attribution or remove the sentence.

## Sentence variation

- No two consecutive sentences begin with the same word.
- No two consecutive sentences follow the same structure (Subject-Verb-Object every time = robotic).
- Mix short, punchy statements with one or two longer sentences. Variety reads as human; repetition reads as template.

## Useful sentence starters (steal these)

Templates that connect achievement to need without sounding AI:

- "At {Company}, I {action} that {metric/outcome} — similar to what {target company}'s team is doing with {their thing}."
- "My experience with {specific skill} directly relates to your need for {JD requirement}."
- "The challenge you describe around {their stated problem} is one I {past action} at {prior employer}."
- "When {prior company} faced {analogous problem}, I {what you did}; the result was {specific outcome}."

Use these as scaffolding, then rewrite into the user's voice. Never paste verbatim across cover letters — same scaffolding sentence appearing in two cover letters is its own AI tell.

## Format

- DOCX via the `docx` skill.
- Header block: user's name, email, phone, LinkedIn (from profile).
- Date in `D Month YYYY` format.
- Recipient: "Hiring Team at {Company}" or the named hiring manager if known (don't guess a name).
- Single column. Body in 11pt Calibri or Helvetica. No coloured accents.
