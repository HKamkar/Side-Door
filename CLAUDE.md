# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`side-door` is a plugin for **Cowork** (Anthropic's desktop app built on Claude Code) that runs an end-to-end job-search workflow: setup interview → resume profile → search → tailor → cover letter → network scan → interview prep → tracker. The plugin format (`.claude-plugin/`, `skills/`, `references/`) is shared between Cowork and Claude Code, so it also works in Claude Code. Distributed as a `.plugin` zip; no build system, no tests, no CI.

## Repo layout

- `.claude-plugin/plugin.json` — minimal manifest (name, version, author, keywords). Skills auto-discover from `skills/`; do NOT list them here. The validator rejects unknown top-level fields like `license`, so keep the manifest tight.
- `skills/<name>/SKILL.md` — one folder per skill. **Folder name must match the `name:` in the frontmatter** (the `skill-creator` validator enforces this). Frontmatter descriptions must not contain `<` or `>` — use `{placeholder}` instead.
- `references/*.md` — cross-cutting lookup tables shared by multiple skills (ATS detection, fit scoring, banned phrases). Don't duplicate this content inside individual skills.

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

- **Install the pre-commit hook once** after cloning: `./scripts/install-hooks.sh`. The hook (at `scripts/git-hooks/pre-commit`) validates `plugin.json` + every `SKILL.md` + scans for leftover pre-rename references on every commit, and **rebuilds `side-door.plugin` automatically when the version in `plugin.json` changes** (so the bundled artifact never drifts from source). The hook excludes `scripts/`, `.git/`, `.idea/`, `.DS_Store` and the prior `side-door.plugin` itself from the zip.
- **Manual rebuild** (if you skip the hook): `zip -r side-door.plugin . -x "*.DS_Store" -x ".git/*" -x ".idea/*" -x "scripts/*" -x "side-door.plugin"`.
- **External validator** (deeper checks): if you have the `skill-creator` plugin installed, `python3 <path-to-skill-creator>/scripts/quick_validate.py skills/<name>/` does the same frontmatter / dir-match / `<>`-rejection checks plus body-length limits.
