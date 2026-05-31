# prep-brief schema

Canonical format for `side-door-workspace/interview-prep/<company-slug>-<role-slug>.md`. The user reads this the morning of the interview. Make it skim-able.

```markdown
# Interview prep — {Company} / {Role}

- **When:** {date + time}
- **Format:** {video / on-site / phone}
- **Stage:** {recruiter / hiring manager / technical / panel / final}
- **Interviewer(s):** {name (title)}
- **Hiring path:** {direct (company) | agency: {agency name}}
- **ATS in use:** {Greenhouse | Lever | Workday | ... | unknown}
- **Prepared:** {YYYY-MM-DD} by side-door

## The 60-second briefing

{3–4 sentences. What this company is, what's happening with them right now, what this role does, why the user is interviewing.}

## What you must know about them

- **Product:** {one paragraph}
- **Stage / funding:** {one line}
- **Most consequential recent news (last 6 months):**
  1. {date — one line — [source]({url})}
  2. {date — one line — [source]({url})}
  3. {date — one line — [source]({url})}
- **The competitive position:** {one or two lines}

## What you must know about each interviewer

### {Interviewer name} — {title}

- **Background:** {one sentence}
- **What they ship / write about lately:** {one sentence with link}
- **What they likely probe on:** {one sentence}

(repeat per interviewer)

## Behavioral questions — likely

For each, the question + 3–5 bullet skeleton answer + which resume story to lift.

### Q: {question, in interviewer voice}
- **Skeleton:**
  - {bullet}
  - {bullet}
  - {bullet}
- **Story to lift:** "{verbatim bullet from resume}" — {company, year}
- **Trap to avoid:** {one line}

(repeat for 4–6 behavioral)

## Technical / domain questions — likely

(repeat structure for 4–6 technical)

## Curveballs

- **{question}** — {how you'll answer in 1–2 sentences. Honest, not evasive.}

## YOUR questions for them (pick 4)

1. {role-specific question based on research}
2. {role-specific question}
3. {role-specific question}
4. {role-specific question}
5. {fallback if conversation goes that way}

## Things to verify before the interview

- {a fact in your tailored cover letter that needs checking}
- {a claim you may make in answers that the user should sanity-check}

## The honest gaps

- **Gap:** {a real gap in the user's fit for this role}
- **How to address if asked:** {one sentence — honest, forward-looking}

(repeat per gap; 1–3 max)

## Logistics

- **Login / dial-in:** {if known}
- **Address:** {if on-site}
- **Recommended arrival / login buffer:** {time}
- **What to bring:** {portfolio / IDE / pen + paper / nothing}

---

## Research log (for audit)

| Source | URL | Used for |
| --- | --- | --- |
| {source} | {url} | {claim it supports} |
```

Rules:

- Every factual claim must be traceable to the research log.
- Behavioral skeletons reference real resume bullets — link the bullet text verbatim.
- Don't pad. A 2-page brief beats a 10-page brief on interview morning.
