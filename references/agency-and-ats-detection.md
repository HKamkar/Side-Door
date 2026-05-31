# Agency and ATS detection

How to recognize the hiring path and the applicant tracking system from a posting URL or page. This signal matters because it changes resume format choices, application strategy, and who the user is actually talking to first.

## Why this matters

- **ATS** (Applicant Tracking System) — the software that parses the resume and runs the first filter. Different ATSes parse differently. Knowing the ATS tells you which resume format choices matter.
- **Hiring agency vs in-house** — a posting through Hays, Robert Half, Michael Page, Randstad, or a boutique recruiter means the user is talking to a recruiter whose incentive is placement fees, not the company's culture. Different prep, different negotiation, different timeline.

## ATS detection — URL patterns

| ATS | URL pattern in apply link |
| --- | --- |
| Greenhouse | `boards.greenhouse.io/*`, `boards-api.greenhouse.io/*`, `job-boards.greenhouse.io/*` |
| Lever | `jobs.lever.co/*`, `*.lever.co/*` |
| Workday | `*.myworkdayjobs.com/*`, `wd*.myworkday.com/*` |
| Ashby | `jobs.ashbyhq.com/*`, `*.ashbyhq.com/*` |
| SmartRecruiters | `careers.smartrecruiters.com/*`, `jobs.smartrecruiters.com/*` |
| iCIMS | `*.icims.com/*` |
| Taleo | `*.taleo.net/*` |
| SuccessFactors | `*.successfactors.com/*`, `career*.sapsf.com/*` |
| Workable | `apply.workable.com/*`, `*.workable.com/*` |
| Recruitee | `*.recruitee.com/*` |
| BambooHR | `*.bamboohr.com/jobs/*` |
| Jobvite | `jobs.jobvite.com/*`, `*.jobvite.com/*` |
| JazzHR | `*.applytojob.com/*` |
| Personio | `*.jobs.personio.com/*`, `*.jobs.personio.de/*` |
| Rippling ATS | `ats.rippling.com/*` |
| Pinpoint | `*.pinpointhq.com/*` |
| Teamtailor | `*.teamtailor.com/*` |

If the URL doesn't match, check the page for a footer logo or "Powered by {ATS}" line — most ATSes brand the bottom of their pages.

## ATS — what each one means for the resume

| ATS | Notes |
| --- | --- |
| Greenhouse, Lever, Ashby, SmartRecruiters, Workable, Recruitee, Teamtailor, Pinpoint | Modern, lenient parsers. PDF or DOCX both fine. Bullets, basic tables, columns mostly survive. |
| Workday, Taleo, SuccessFactors, iCIMS | Older, stricter parsers. Prefer DOCX. Use plain bullets (`-` or `•`), single column, no tables, no text boxes, no headers/footers. Headings as bold text, not styled. |
| BambooHR, JazzHR, Jobvite | Mixed. DOCX safer than PDF. Plain layout. |
| Personio | DOCX or PDF fine; common in DE/EU postings. |
| Rippling ATS | Modern; either format. |

If the ATS is unknown, default to a DOCX with plain bullets, single column, no tables — the safe option for stricter parsers.

## Hiring agency detection — domain patterns

If the apply URL is on one of these domains, the posting is via an agency, not the hiring company directly:

| Agency | Domain |
| --- | --- |
| Hays | `hays.com`, `hays.co.uk`, `hays.nl`, `hays.de`, etc. |
| Robert Half | `roberthalf.com`, `roberthalf.co.uk`, etc. |
| Michael Page | `michaelpage.com`, `michaelpage.co.uk`, `michaelpage.nl`, etc. |
| PageGroup brands | `pagepersonnel.*`, `pageexecutive.*` |
| Randstad | `randstad.com`, `randstad.co.uk`, `randstad.nl`, etc. |
| Adecco | `adecco.com`, `adecco.co.uk`, etc. |
| Robert Walters | `robertwalters.com`, `robertwalters.co.uk`, etc. |
| Kelly Services | `kellyservices.com` |
| ManpowerGroup / Experis | `manpower.com`, `experis.com` |
| Modis / Akkodis | `modis.com`, `akkodis.com` |
| Harvey Nash | `harveynash.com` |
| Spencer Ogden | `spencer-ogden.com` |
| Frank Recruitment Group brands | `frgconsulting.com`, `nigelfrank.com`, `masonfrank.com`, `andersonfrank.com`, `washingtonfrank.com` |
| BPS World | `bps-world.com` |
| Levin | `levin-recruit.com` |

For boutique / regional agencies not on this list, recognize them by: the JD says "our client is a leading {industry} company in {city}" without naming the client; the email contact uses a recruiting agency domain; LinkedIn shows the recruiter's headline is at an agency.

## Hiring agency — what it means

- **The recruiter screen is the first round.** Their job is to qualify the user against the client's brief in 20–30 minutes.
- **Comp negotiation goes through them.** They have a fee structure tied to the placed salary (typically 15–25% of first-year salary). Their incentive is alignment-ish — higher salary is higher fee, but a placed candidate is better than no placement.
- **Timelines compress.** Agency briefs are often urgent.
- **Be careful about resume distribution.** Agencies sometimes send the resume to multiple clients. Ask which client(s) it will be sent to before agreeing.
- **Don't assume the JD is the client's actual wording.** Agencies rewrite. The pattern brief should note this if a posting is agency-sourced.

## Where to record the signal

- In `posting-schema.md` — add `ATS:` and `Hiring path:` fields per posting.
- In `pattern-brief-schema.md` — Meta-signals section already includes ATS pattern and Hiring path mix.
- In `tailor-application` — the ATS field changes format choices (DOCX strictness, bullet symbols, layout).
- In `interview-prep` — the Hiring path field changes who the first screen is with and what they're optimizing for.

## What never to do

- Never assume an agency posting is "less legitimate". They're a normal part of hiring in many markets (NL, UK, DE especially).
- Never use the ATS signal to "trick" the parser with hidden white-on-white keyword stuffing. ATS vendors flag this; recruiters can see it; the resume gets rejected and the user is blocked from re-applying.
- Never reveal the client's name to other applications if the agency has not yet introduced the user to the client.
