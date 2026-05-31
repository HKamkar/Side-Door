# posting file schema

Canonical format for `side-door-workspace/postings/<slug>.md`. One file per posting. Filename: `<company-slug>-<title-slug>.md`.

```markdown
# {Company} — {Title}

- **URL:** {full URL}
- **Posted:** {date as stated, or "unknown"}
- **Captured:** {YYYY-MM-DD by this run}
- **Location:** {city, or "Remote", or "Hybrid — city"}
- **Remote policy:** {fully remote | hybrid | on-site | not stated}
- **Comp range (if stated):** {range with currency, or "not stated"}
- **Source:** {LinkedIn | Indeed | Glassdoor | Wellfound | company-site | other}
- **Hiring path:** {direct (company) | agency: {agency name}} — see `references/agency-and-ats-detection.md`
- **ATS:** {Greenhouse | Lever | Workday | Ashby | SmartRecruiters | iCIMS | Taleo | SuccessFactors | Workable | Recruitee | BambooHR | Jobvite | Personio | Rippling ATS | Pinpoint | Teamtailor | other-named | unknown} — derived from the apply-URL pattern

## One-line summary

{One sentence: what the company wants this person to do.}

## Must-have requirements

- {requirement}
- {requirement}

## Nice-to-have

- {requirement}

## Team / context

{Any text the JD gives about team size, reporting line, what they're building.}

## Verbatim JD highlights

> {Pull 3–6 short verbatim quotes from the JD that matter most. Do not paraphrase — quote.}

## Authorization signals

- {e.g., "visa sponsorship available" / "must have US work authorization" / "not stated"}

## Red flags

- {Anything that looked off: vague "rockstar" language, salary listed but suspiciously low, posted >90 days ago, requirements wildly exceed the title, etc. Or "none noted".}
```

Rules:

- If a section has no content, write "not stated" — do not invent.
- Verbatim quotes only in "Verbatim JD highlights". Anywhere else: your wording.
- If the page failed to load, do not create the file. Log the URL in the shortlist as "fetch failed".
