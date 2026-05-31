# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`side-door` is a Claude Code plugin that runs an end-to-end job-search workflow: resume profile → search → tailor → cover letter → interview prep → tracker. The README sometimes calls the host "Cowork"; treat that as a typo — this is a Claude Code plugin. Distributed as a `.plugin` zip; no build system, no tests, no CI.

## Repo layout

- `.claude-plugin/plugin.json` — minimal manifest (name, version, author, keywords). Skills auto-discover from `skills/`; do NOT list them here.
- `skills/<name>/SKILL.md` — one folder per skill. **Folder name must match the `name:` in the frontmatter** (currently true for all 10 skills; the `skill-creator` validator enforces this).
- `references/*.md` — cross-cutting lookup tables shared by multiple skills. When two skills need the same data (ATS detection, scoring rubric, banned phrases), put it here instead of duplicating.

## Design invariants — preserve when editing any skill

These shape every skill's behavior; changing a skill without honoring them breaks the product:

- **Profile-first**: every skill except `setup` and `side-door-router` reads `side-door-workspace/profile.md` as canonical truth about the user. Don't bypass it or duplicate its data.
- **Idempotent**: re-running a skill must be safe — check state first, only do what's missing.
- **No invented facts**: resumes, cover letters, and interview briefs must source every claim from the profile or the JD. Unsourceable claims get flagged as gaps for the user, never filled in.
- **ATS-aware**: `tailor-resume` branches on the detected ATS (strict parsers like Workday/Taleo need plain-bullet DOCX, no tables/columns/headers). Detection rules live in `references/agency-and-ats-detection.md`.
- **LinkedIn is user-exported, never scraped**: `network-scan` reads `Connections.csv` the user downloads from LinkedIn settings. Live scraping violates TOS.
- **Cover-letter openers must be company-specific**: generic openers ("I came across your posting") are banned. See `references/banned-phrases.md`.

## Working folder

All user state lives in `side-door-workspace/` in the user's CWD (profile, postings, tailored docs, tracker CSV, etc.). This folder is gitignored and must never be committed. Layout is documented in README.md.

## Build and validate

- Build the distributable: `zip -r side-door.plugin . -x "*.DS_Store" -x ".git/*"`
- Validate a skill before submitting: `python3 .claude/skills/skill-creator/scripts/quick_validate.py skills/<name>/` — requires the `skill-creator` plugin installed separately.
