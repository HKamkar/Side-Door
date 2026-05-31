# Side Door

An end-to-end job-hunting and interview-prep plugin for Cowork. Works with any resume — no hard-coded job titles, industries, or seniority assumptions. The plugin reads the user's resume, runs a structured work-history interview, infers what roles they qualify for, finds matching listings, scans the user's network for warm intros, tailors applications (resume + cover letter separately), prepares them for interviews, and tracks every application in a local file with reusable form answers.

## How to start

Drop a resume (PDF, DOCX, or Markdown) into the working folder and say one of:

- "Set me up" / "Onboard me" — runs the full setup (resume → preferences → LinkedIn import → work-history interview). Idempotent, picks up where you left off.
- "Setup interview" — skips straight to the work-history interview if the rest is already done
- "Help me find a job"
- "What roles am I qualified for?"
- "Find me jobs that match my resume"
- "Tailor my resume for this posting: {URL}"
- "Write the cover letter for that one"
- "Who do I know at {company}?"
- "Help me prep for my interview at {company}"
- "What's on my application tracker?"

The router skill picks the right specialist.

## Install

1. Download `side-door.plugin` from [Releases](../../releases) (or build it yourself: `zip -r side-door.plugin . -x "*.DS_Store" -x ".git/*"`).
2. In Cowork, install the `.plugin` file.
3. Open a folder you want to use for job hunting and start with: **"set me up"**.

## Skills

| Skill | Triggers when the user wants to... |
| --- | --- |
| `side-door-router` | ...get started or asks any vague job-related question |
| `setup` | ...do the one-time onboarding (resume → preferences → LinkedIn import → work-history interview). Idempotent: runs only what's missing. Say "setup interview" to skip to just the interview. |
| `resume-profile` | ...understand what roles they qualify for; build the canonical profile every other skill reads |
| `job-search` | ...find, score, and shortlist job postings (detects ATS and hiring-agency at parse time) |
| `network-scan` | ...find warm-intro opportunities by cross-referencing their LinkedIn connections export against target companies |
| `jd-pattern-extract` | ...find what 3–6 similar postings ALL want — the "what to emphasize everywhere" signal |
| `tailor-resume` | ...tailor the resume for one specific posting (ATS-aware format, keyword diff, metric interrogation). Does NOT write the cover letter — that's the next skill. |
| `cover-letter` | ...write the cover letter for one specific posting. Reads what `tailor-resume` produced so they don't contradict each other. 250–400 words, no banned phrases, company-specific opener required. |
| `interview-prep` | ...research a company, generate likely questions, run a mock interview (knows direct vs agency screen) |
| `application-tracker` | ...log/update applications AND maintain `application-data.md` with reusable answers (salary expectation, citizenship, visa, stock paragraphs) so the user doesn't retype them per form |

## Files the plugin creates in the working folder

```
side-door-workspace/
├── profile.md              # extracted by resume-profile + augmented by setup (interview phase)
├── preferences.md          # target roles, location, comp, must-haves, dealbreakers — saved by setup
├── application-data.md     # reusable form answers (salary, citizenship, visa, stock paras)
├── shortlist.md            # ranked job postings
├── applications.csv        # the application tracker
├── network-matches.md      # warm-intro opportunities from network-scan
├── postings/
│   └── {slug}.md           # raw + parsed JD for each posting analyzed (incl. ATS + hiring path)
├── patterns/
│   └── {title}-{date}.md   # what 3-6 similar JDs all wanted
├── jobs/
│   └── {company}-{role}-{YYMM}/
│       ├── resume.docx
│       ├── cover-letter.docx
│       └── notes.md         # mapping table, ATS detection, rewriting choices, gaps
└── interview-prep/
    └── {company}-{role}.md
```

## Shared references

Three cross-cutting reference files used by multiple skills, kept in one place:

```
references/
├── agency-and-ats-detection.md   # ATS + hiring-agency lookup (used by job-search, tailor-resume, interview-prep, jd-pattern-extract)
├── fit-scoring.md                # canonical scoring rubric (used by job-search and network-scan)
└── banned-phrases.md             # phrases to never use (used by cover-letter)
```

## Job sourcing

The plugin supports three sourcing modes — it picks based on context:

1. **Browse** — Claude in Chrome (LinkedIn, Indeed, Glassdoor, Wellfound, company pages)
2. **Search** — WebSearch + WebFetch on aggregators
3. **Paste** — user provides a posting URL directly

## Network scan

`network-scan` reads the official LinkedIn data export (`Connections.csv`) — not live scraping (against LinkedIn's TOS). The user requests the export via **Settings & Privacy → Data privacy → Get a copy of your data → Connections**. The file delivers in 10–20 minutes. Drop it in the working folder and run network-scan.

## Privacy

Nothing leaves the user's machine except the web/job-board calls each skill explicitly makes. The resume, profile, tracker, application-data, network matches, tailored docs, and prep briefs all live in the local working folder. The LinkedIn CSV stays local too.

## Not legal or recruitment advice

The plugin is a productivity tool. Hiring decisions, salary negotiations, and visa/work-authorization questions should be verified with the actual employer or a qualified professional.

## Contributing

PRs welcome. Each skill is a self-contained folder under `skills/` with one `SKILL.md` and optional `references/`. Run `python3 .claude/skills/skill-creator/scripts/quick_validate.py skills/<your-skill>/` before submitting.

## License

MIT — see [LICENSE](LICENSE).
