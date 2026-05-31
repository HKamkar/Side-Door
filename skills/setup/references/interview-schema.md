# Interview output schema

What to append to `side-door-workspace/profile.md` after the interview. Augments — does not replace — what `resume-profile` already wrote (identity, hard skills, education stay; the candidate-overview and interview sections below are added).

```markdown
## Candidate overview

_Captured {YYYY-MM-DD} via setup._

- **Name:** {Full name}
- **Core expertise (2-3 sentences):** {the headline of what this person does — distilled from the interview, in their own words where possible}
- **Career throughline:** {the narrative arc across all roles — one paragraph, the story that connects role 1 to role N}

## Per-role detail

### {Title} at {Company} ({Start} – {End})

**Company context:** {what the company did, stage at the time, approximate size, market position}

**Your mandate:** {what the user was hired to do; what state things were in on arrival; reporting line; how the role evolved}

**Team & leadership:** {direct + indirect reports if any; built vs. inherited; key hires and why; cross-functional dynamics}

#### Key accomplishments

1. **{Short headline}** — {S-A-O with specific metric. Verbatim user quote in italics if it's a strong line.}
2. **{Headline}** — {S-A-O with metric}
3. **{Headline}** — {S-A-O with metric}

**Technical / strategic depth:** {tools, frameworks, methodologies, decisions driven, alternatives considered, what was built from scratch vs. inherited}

**Challenges & failures:** {what was hard; what didn't work; pivots / course corrections; organizational dynamics — captured without naming names}

**Transition:** {why they left; what they consider their legacy; what they'd do differently}

_(repeat the block above per role, most recent first, more detail for recent/impactful roles)_

## Stories bank

_Distilled from per-role accomplishments. These are what `interview-prep` lifts into mock answers and `tailor-resume` lifts into JD-aligned bullets._

### Story 1 — "{short title}"
- **Job:** {Company, role, year-range}
- **Situation:** {1-2 sentences}
- **Action:** {first person — what the user specifically did, not "we"}
- **Outcome:** {the metric or change — specific}
- **Skills proven:** {comma-separated tags — Python, distributed systems, mentoring, etc.}
- **Behavioral categories it answers:** {comma-separated — leadership, failure, ambiguity, cross-functional, scale, conflict, etc.}

_(6–12 stories typically — at least one per recent role, more for senior+)_

## Cross-role patterns

_What's repeated across the user's roles — patterns the user themselves might not see. Confirmed with the user during interview synthesis._

- **{Pattern title}** — {description, with which roles it appears in}
- **{Pattern title}** — {description}

Example patterns: "always greenfield, never maintenance" / "always scaled teams 5 → 20" / "always paired with technical co-founders" / "always picked late-stage companies in distress" / "always shipped within the first 90 days".

## Superpower

_The thing this user does better than most. User-stated, backed by evidence from the interview._

- **{One-sentence superpower}** — {in user's own words if possible}
- **Evidence:** {3-5 concrete moments from the per-role detail that prove it}

## Honest gaps

_The things the user is NOT good at and has learned to live with. Surfaced so `tailor-resume` doesn't claim them and `interview-prep` preps honest framings for them._

- **{Gap}** — {how the user phrased their relationship with it}
- **{Gap}** — {phrasing}

## Aspirational anchor

- **The role I'd take in a heartbeat if it appeared tomorrow:** {user's quote, lightly edited}
- **The 3-year narrative:** {user's quote of the story they want to be telling}

## Salary history

| Role | Company | Year | Base | Variable | Equity | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| {role} | {company} | {year} | {amount + currency} | {bonus/RSU/none} | {none/options/RSUs/value if known} | {raise, promo, etc., or "not stated"} |

Mark "not stated" for any cell the user declined to share.

## Salary floor

- **Below this number it's not worth the conversation:** {amount + currency + base or total comp basis}
- **Captured:** {YYYY-MM-DD}
```

## Rules

- **Append, don't replace.** `resume-profile` wrote the identity / hard-skills / education sections. Don't touch those. The interview augments.
- **Verbatim quotes welcome.** In Per-role detail and Stories bank, lifting the user's exact phrasing is a feature — it's the language `tailor-resume` and `cover-letter` will mirror.
- **No invented metrics.** If the user couldn't pin down a number, write "not measured / not remembered" rather than inventing.
- **Cross-role patterns are observations, not pronouncements.** They were confirmed by the user during interview synthesis. If the user pushed back on a pattern you saw, don't include it.
- **Superpower must have evidence.** A claim without 3+ concrete moments backing it doesn't go in the file.
- **Dealbreakers, target roles, and preferences live in `preferences.md`** — not in profile.md. The Setup Phase 2 captures those.
- **Stories must have a concrete outcome.** If the interview couldn't extract one, do not write the story; surface to the user "we couldn't pin down an outcome for X; want to try again?".
