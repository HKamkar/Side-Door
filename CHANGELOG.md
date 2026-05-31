# Changelog

All notable changes to Side Door. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning: [SemVer](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.1] — 2026-05-31

- `tailor-resume`: new steps for narrative pitch (3.5), self-critique pass before saving (6.5), and profile feedback loop on user corrections (9).
- New references: `level-calibration.md` (per-band emphasis: executive / director / senior IC / mid / junior) and `anti-ai-writing.md` (bullet formula, kill list, 7-second scan test, quality checklist).
- `notes.md` now captures the narrative pitch and the seniority-band gap so `cover-letter` and `interview-prep` read the same framing.

## [0.4.0] — 2026-05-31

- **Renamed** `career-copilot` → `side-door` across plugin manifest, workspace folder, router, all paths; new tagline: *"Get hired through the side door — warm intros, honest tailoring."*
- `setup` restructured as a master orchestrator (resume → preferences → LinkedIn → 7-dimension work-history interview); profile now captures career throughline, superpower, cross-role patterns, and honest gaps.
- Public-release prep: MIT LICENSE, `.gitignore`, and validator fixes (removed `license` manifest field, angle brackets → curly braces in descriptions, `shared/references/` → top-level `references/`).

## [0.3.0] — 2026-05-31

- New skills: `setup-interview` (work-history interview), `network-scan` (LinkedIn `Connections.csv` → warm-intro matches), and `cover-letter` (split off from `tailor-application`, which became `tailor-resume`).
- `application-tracker` extended with `application-data.md` — reusable answers to common form fields (salary expectation, citizenship, visa, stock paragraphs).
- Unified job folder convention `jobs/{company}-{role}-{YYMM}/` with `resume.docx`, `cover-letter.docx`, `notes.md` — same ID format as tracker rows.

## [0.2.0] — 2026-05-31

- New skill: `jd-pattern-extract` — ingests 3–6 JDs, outputs a requirements matrix (M/N/·), universal-must list, recurring verbs and tools, comp + location + ATS meta-signals, and a reconciliation against the profile.
- ATS + hiring-agency detection wired through `job-search`, `tailor-application`, and `interview-prep` (16 ATSes by URL pattern, 13 named agencies by domain).
- `tailor-application` gained the ATS keyword diff and the metric-interrogation loop.

## [0.1.0] — 2026-05-31

- Initial scaffold: 6 skills — `career-copilot-router`, `resume-profile`, `job-search`, `tailor-application`, `interview-prep`, `application-tracker`.
- Profile-first architecture: `resume-profile` writes `profile.md`; every other skill reads from it.
- Truth guards baked in from day one: no fabricated experience, banned-phrases list, JD-to-resume mapping table required before tailoring.
