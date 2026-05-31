---
name: setup
description: >
  This skill should be used for one-time onboarding into side-door — uploading the resume, capturing preferences, importing LinkedIn contacts (optional), and conducting a deep work-history interview that builds the canonical profile every other skill reads. Triggers: "set me up", "onboard me", "get started", "first time", "build my profile properly", "let's do this right", "I'm new here", "what do I do first", "setup interview" (skip to interview only), "do the interview", "redo the interview", "set up my preferences", "import my linkedin contacts". Idempotent — checks what already exists and runs only the missing phases. Picks up where you left off. If the user says "setup interview" specifically, skips the resume / preferences / linkedin phases and goes straight to the work-history interview.
metadata:
  version: "0.2.0"
---

# Setup

You are running the most important conversation in this plugin: one-time onboarding that produces the substrate every other skill reads. Done well, this turns a generic résumé profile into a real candidate profile that produces tailored, honest, high-conversion downstream work.

This skill is the **master orchestrator**. It runs four phases in order — resume, preferences, LinkedIn contacts (optional), work history interview — but only the ones that are missing. Re-running setup is safe; it picks up where you left off.

## Argument routing

Read the user's message:

- "**setup interview**" / "**do the interview**" / "**redo the interview**" → skip to Phase 4 only (still verify a resume exists first).
- "**setup**" / "**onboard me**" / "**get started**" / similar → run all four phases, skipping any that are already done.

## Step 0 — Check state

Read `side-door-workspace/` for:

1. **Resume** — `resume/` subfolder with a PDF / DOCX / MD, OR a resume file in the working folder root (`*.pdf`, `*.docx`, `Resume*`, `CV*`).
2. **Preferences** — `preferences.md`.
3. **LinkedIn contacts** — `Connections.csv` (LinkedIn's export filename).
4. **Profile with interview content** — `profile.md` containing the sections `## Stories bank`, `## Career throughline`, `## Superpower`, `## Cross-role patterns`. Profile without these = interview hasn't been done yet.

If `side-door-workspace/` does not exist, create it.

If all four exist, tell the user "you're already set up" and surface the available next moves (job-search, network-scan, tailor-resume, interview-prep, application-tracker). Offer "redo the interview" or "update preferences" if they want to refresh.

Otherwise, run only the missing phases — in the order below.

## Phase 1 — Resume

If a resume is already present, skim it to confirm it's the right person and the right document (check most-recent role date is within ~5 years; if older, ask the user if it's current). Mention name + most-recent role + number of roles in one line. Move on.

If no resume is present, ask the user to:

- Drop a file into the working folder (PDF, DOCX, or MD), or
- Paste the text directly (you'll save it as `side-door-workspace/resume/resume.md`).

After saving, confirm in one line: "Got your resume — {Name}, most recent role {Title} at {Company}, {N} roles total."

## Phase 2 — Preferences

If `preferences.md` exists and has real content (not just a template), skim and confirm. Move on.

Otherwise, ask the user in ONE natural question:

> "What kind of jobs are you looking for next? Target roles, location, remote/hybrid/on-site, salary expectations, anything you want to filter out — tell me what you've got."

From the answer, save `side-door-workspace/preferences.md` using this structure:

```markdown
# Job Preferences

_Last updated: {YYYY-MM-DD}._

## Target roles
- {parsed}

## Location
- **Cities / regions:** {parsed}
- **Remote / hybrid / on-site:** {parsed}
- **Relocation:** {parsed}

## Compensation
- **Salary floor (below which not worth conversation):** {parsed or "not stated yet — will capture in interview"}
- **Salary expectation range:** {parsed or "not stated yet"}
- **Currency basis:** {parsed}

## Must-haves
- {parsed}

## Dealbreakers
- {parsed — each must be a CONCRETE thing the user said}

## Nice-to-haves
- {parsed}
```

If they didn't mention something, leave it blank or note "not stated yet". Don't invent. The interview in Phase 4 will fill the rest.

## Phase 3 — LinkedIn contacts (optional)

If `Connections.csv` already exists in the working folder, confirm count ("Found {N} LinkedIn contacts") and move on.

Otherwise, ask:

> "Want to import your LinkedIn contacts so the plugin can flag warm-intro opportunities when you have a connection at a hiring company? Skippable — you can add this later."

If yes, give the export instructions from `../../skills/network-scan/references/linkedin-export-howto.md` (Settings → Data Privacy → Get a copy of your data → Connections → download CSV).

If they skip, move on. This is optional.

## Phase 4 — Work-history interview

This is the deep phase. Read `references/interview-guide.md` for the full structure — 7 dimensions per role, technique guidance, and "connect-the-dots" patterns to capture across roles.

**Before starting**, set expectations with the user:

> "I'm going to walk through each role on your resume from most recent backwards. For each, I'll ask about company context, what you were really doing, team and leadership, accomplishments with specifics, technical depth, hard parts, and why you moved on. Takes 20–35 minutes. We can pause anytime. The more specific the better — the answers shape every tailored resume and interview prep this plugin produces."

Then ask: "Ready now, or block 30 minutes later?"

If now, proceed.

### How to run the interview

- **Most recent role first.** Spend more time on recent / impactful roles, less on older ones.
- **One area at a time.** Don't dump the whole 7-question structure on the user at once. Ask one area, get the answer, probe if shallow, move to the next.
- **Push for specifics.** Use the technique prompts in `references/interview-guide.md`. "Improved performance" → "by what percentage, measured how?"
- **Connect the dots between roles.** Note when you see a pattern (always scaling teams; always turnaround situations; always greenfield). Surface these to the user toward the end so they can confirm or push back.
- **After each role**, summarize what you heard in 2–3 sentences and ask "did I get that right?" before moving on.

### After all roles are covered, ask cross-cutting:

1. "What's your salary floor — below this is not worth the conversation?"
2. "What's the role you'd take in a heartbeat if it appeared tomorrow?"
3. "What story do you want to be telling in 3 years?"
4. "What are you NOT good at, that you've learned to live with?"
5. "What would you say is your superpower — the thing you do better than most people?"

Use the technique prompts from `references/interview-guide.md` to push back on vague answers.

### Write to profile.md

Augment `side-door-workspace/profile.md` per `references/interview-schema.md`. Add these sections:

- `## Candidate overview` — name + core expertise + career throughline (the narrative arc across roles).
- `## Per-role detail` — for each role: company context, your mandate, team & leadership, accomplishments (S-A-O with metrics), technical/strategic depth, challenges, transition.
- `## Stories bank` — promoted from per-role accomplishments — each tagged with which behavioral interview question it answers, which skills it proves, and which job to lift it from.
- `## Cross-role patterns` — what's repeated across roles (the patterns the user themselves might not see).
- `## Superpower` — the user's stated superpower, backed by evidence from the interview.
- `## Salary history` — table per role with base / variable / equity (mark "not stated" if user declined).
- `## Salary floor` — single number.
- `## Aspirational anchor` — heartbeat role + 3-year narrative.
- `## Honest gaps` — what the user is not good at and has learned to live with.

Do NOT remove anything `resume-profile` wrote (if it had run earlier). This skill augments and overwrites the candidate-overview/interview sections; it leaves identity, hard skills, education alone.

## Phase 5 — Summary and what's next

After whichever phases ran, surface a one-screen summary:

```
You're set up. Here's what we have:

- Resume: {filename} (saved in resume/)
- Preferences: {target roles + key criteria one-liner}
- LinkedIn contacts: {N} imported (or "skipped — add later")
- Work history profile: {N} roles covered, {M} stories captured, salary floor {amount}

Available now:
- "find me jobs" → job-search
- "who do I know at <company>?" → network-scan
- "compare these JDs" → jd-pattern-extract
- "tailor my resume for <URL>" → tailor-resume
- "write the cover letter for that one" → cover-letter
- "prep me for my interview at <company>" → interview-prep
- "log this as applied" → application-tracker
```

If anything is still missing (skipped phases), say what's missing and how to come back to it.

## What this skill never does

- Never re-runs a phase that's already done unless the user explicitly asks.
- Never dumps the full interview structure on the user in one message. One area at a time, with probing follow-ups.
- Never accepts "team player" or "results-driven" as an answer to anything. Push for the specific instance.
- Never moves on from a role until at least one accomplishment has been captured with a concrete metric (or the user explicitly says they don't remember).
- Never writes a dealbreaker the user didn't actually state. "Avoid toxic culture" is not a dealbreaker; "no on-call rotations" is.
- Never stores or surfaces information that's not relevant to job hunting (health, family, beliefs). If the user volunteers something off-topic, acknowledge briefly and steer back.
- Never claims a "superpower" the user did not stake out themselves and have evidence for.
