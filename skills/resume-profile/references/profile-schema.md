# profile.md schema

Canonical format for `side-door-workspace/profile.md`. Every other side-door skill reads this file; the format is contract, not a suggestion.

```markdown
# Profile — {Full Name}

_Built from {filename} on {YYYY-MM-DD}._

## Identity

- **Name:** {full name}
- **Email:** {email or "not on resume"}
- **Phone:** {phone or "not on resume"}
- **Location:** {city, country, or "not on resume"}
- **LinkedIn:** {url or "not on resume"}
- **Portfolio / GitHub:** {url or "not on resume"}

## Experience summary

- **Years of professional experience:** {N years} ({calculation: "first role 2014 -> latest 2026, minus 2018 gap = 11 years"})
- **Seniority band:** {junior | mid | senior | staff | principal | director | VP | C-level}
- **Seniority evidence:**
  - {evidence 1 — e.g., "led team of 6 at Acme Corp"}
  - {evidence 2 — e.g., "promoted to Staff in 2023"}
- **Seniority conflicts / flags:** {anything that doesn't add up, or "none"}

## Hard skills

### {Category 1 — e.g., Languages}
- `core` — {skill}, {skill}
- `mentioned` — {skill}, {skill}

### {Category 2 — e.g., Frameworks / Platforms}
- `core` — {skill}
- `mentioned` — {skill}, {skill}

### {Category 3 — e.g., Domain / Industry tools}
- `core` — {skill}
- `mentioned` — {skill}

## Soft skills (evidenced)

- **{soft skill}** — backed by: "{verbatim bullet from resume}"
- **{soft skill}** — backed by: "{verbatim bullet from resume}"

## Domain experience

| Industry | Company | Years | Role |
| --- | --- | --- | --- |
| {industry} | {company} | {N} | {title} |

## Work authorization

- **Status as stated on resume:** {citizenship / visa / "not stated"}
- **Relocation:** {willing / specific cities / not stated}
- **Remote preference:** {fully remote / hybrid / on-site / not stated}

## Languages spoken

- {language} — {fluency if stated}

## Education

| Degree | Institution | Year | Notes |
| --- | --- | --- | --- |
| {degree} | {institution} | {year} | {honors, relevant coursework, or blank} |

## Red flags / clarifications needed

- {flag 1 — e.g., "11-month gap between 2021 and 2022, no explanation on resume"}
- {flag 2 — or "none"}

---

## Qualified job titles (inferred)

For each title: fit, why, why not.

### 1. {Title} — `strong`
- **Why:** {one sentence grounded in resume evidence}
- **Why not:** {one honest sentence about the gap, or "no significant gap"}
- **Typical seniority match:** {junior | mid | senior | staff}
- **Typical industries hiring this:** {industry, industry}

### 2. {Title} — `strong`
...

### 3. {Title} — `stretch`
- **Why:** {evidence}
- **Why not:** {what's missing — be honest}
- **Gap to close:** {one specific thing — e.g., "no managerial experience; would need to frame technical-lead bullets as people leadership"}

...

## How to use this profile

- `job-search` reads "Qualified job titles" and uses the top 3–5 as search queries.
- `tailor-application` reads the full profile to know which bullets to lift and which to suppress.
- `interview-prep` reads "Domain experience" and "Soft skills (evidenced)" to predict behavioral questions.
- `application-tracker` references the title list when categorizing logged applications.

To rebuild: re-run the resume-profile skill. It overwrites this file.
```
