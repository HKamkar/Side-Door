# application-data.md schema

Canonical format for `side-door-workspace/application-data.md`. Initialize all fields blank; fill in over time as the user provides answers or as `setup-interview` runs.

```markdown
# Application data

_Reusable answers to common job-application form fields. Update as your situation changes._

## Identity

- **Full legal name:** {as on passport / ID — leave blank if user prefers}
- **Preferred name:** {what they go by professionally}
- **Email:** {primary job-search email}
- **Phone (with country code):** {primary}
- **LinkedIn URL:** {full URL}
- **Portfolio URL:** {full URL or "n/a"}
- **GitHub URL:** {full URL or "n/a"}
- **Personal website:** {full URL or "n/a"}

## Authorization & geography

- **Citizenship(s):** {country, country}
- **Countries I can work in without sponsorship:** {country, country}
- **Sponsorship needed for:** {country (visa type if known), or "none — willing to relocate self-funded", or "none"}
- **Current location:** {city, country}
- **Cities open to relocating to:** {city, city, or "no relocation"}
- **Remote / hybrid preference:** {remote-only / hybrid up to N days / on-site OK}

## Compensation

- **Salary floor (below this, not worth conversation):** {amount + currency + basis (base or total comp)}
- **Salary expectation — base:** {range}
- **Salary expectation — total comp (base + variable + equity):** {range}
- **Currency basis:** {EUR / USD / GBP / etc.}
- **Equity preference:** {strong / open / cash-heavy preferred}
- **Bonus structure tolerance:** {pure base / OTE OK / equity-heavy OK}

## Timing

- **Notice period:** {N weeks / "currently between roles"}
- **Earliest start date:** {YYYY-MM-DD or "X weeks from offer"}
- **Time zones I can work in:** {e.g., "CET ±3h"}

## Years of experience

- **Years (computed):** {N} — auto-synced from profile.md
- **Years per primary skill:** {e.g., "Python: 8, AWS: 6, Kubernetes: 4"}

## Stock answers

### "Why are you interested in {this kind of role}?"
{One paragraph the user wrote that holds up across postings. They can adapt the company-specific bit at the front.}

### "What are you looking for in your next role?"
{One paragraph the user wrote. Honest about preferences without naming a specific company.}

### "Tell us about a recent accomplishment"
{One STAR-shaped paragraph. Pick the strongest from the stories bank.}

### "Why are you leaving your current role?"
{One short paragraph. Forward-looking, not negative.}

### "What questions do you have for us at this stage?"
{2-3 generic-but-good questions the user can default to in a form.}

## EEO / diversity declarations (only if user explicitly saves)

Leave entirely blank unless the user says "save this answer for next time" for a specific field.

- **Gender:** {only if user explicitly saved}
- **Ethnicity / race:** {only if user explicitly saved}
- **Veteran status:** {only if user explicitly saved}
- **Disability status:** {only if user explicitly saved}

## References

| Name | Relationship | Email | Permission-to-share status | Date confirmed |
| --- | --- | --- | --- | --- |
| {name} | {e.g., "Former manager at PrevCo"} | {email} | {yes / pending / no} | {YYYY-MM-DD} |

Never list a reference whose permission status is "no" or "pending".
Never share reference details in a tracker entry or a cover letter — only when the form explicitly asks for them.

## Files I'll commonly need

- **Latest CV (canonical, untailored):** {filename in working folder}
- **Latest portfolio PDF:** {filename or "n/a"}
- **Cover letter signature / sign-off block:** {standard sign-off the user uses}

## Last updated

- **{YYYY-MM-DD}** — {what changed}
```

Rules:

- Initialize with all fields blank. Don't guess defaults.
- When `setup-interview` runs, sync the salary floor, citizenship, geography, and notice period into this file automatically.
- When the user provides a new reusable answer mid-conversation, prompt: "Save this to application-data so we don't have to redo it next time? (y/n)" — don't auto-save.
- When the user asks "what did I tell you for {field}?" — read from here.
- Treat the EEO block as user-managed only. Never auto-populate.
