# pattern-brief schema

Canonical format for `side-door-workspace/patterns/<title-slug>-<YYYYMMDD>.md`.

```markdown
# Pattern brief — {Role family} ({N} postings)

_Generated {YYYY-MM-DD}. Postings analyzed: {list of company+title pairs}._

## 1 — If you do nothing else

**Top 5 universal musts (in {80%+} of postings):**

1. {requirement} — in {N}/{total} postings
2. {requirement} — in {N}/{total}
3. ...

**Top 5 recurring verbs (the action vocabulary the market uses):**

`{verb}` ({count}), `{verb}` ({count}), `{verb}` ({count}), `{verb}` ({count}), `{verb}` ({count})

**Recommended summary line for your resume / LinkedIn headline:**

> {one-sentence summary built from the intersection. Honest, not aspirational.}

## 2 — Full requirements matrix

| Requirement | {Co. 1} | {Co. 2} | {Co. 3} | {Co. 4} | {Co. 5} | Count | Bucket |
| --- | --- | --- | --- | --- | --- | --- | --- |
| {requirement} | M | M | M | M | N | 4M+1N | Universal must |
| {requirement} | M | · | M | M | · | 3M | Common must |
| ... | ... | ... | ... | ... | ... | ... | ... |

Legend: M = must-have, N = nice-to-have, · = not mentioned.

## 3 — Vocabulary

### Verbs used (top 10 by frequency)
| Verb | Count |
| --- | --- |
| {verb} | {N} |

### Tools / platforms named (top 10 by frequency)
| Tool | Count |
| --- | --- |
| {tool} | {N} |

### Domain phrases
| Phrase | Count |
| --- | --- |
| {phrase} | {N} |

### Seniority signals present
- {phrase} ({count})
- {phrase} ({count})

## 4 — Meta-signals

| Signal | Value |
| --- | --- |
| Comp band (where disclosed) | {range with currency, median} |
| Comp disclosure rate | {N}/{total} ({pct}) |
| Stated years required (avg / range) | {avg} ({min}-{max}) |
| Location mix | {N} remote / {N} hybrid / {N} on-site |
| Hiring path | {N} direct / {N} agency ({named agencies}) |
| ATSes detected | {ATS} ({N}), {ATS} ({N}) |

## 5 — Your action list (vs the profile)

### Already shown on your profile
- {universal must} — solid; keep it where it is.

### Buried — promote to lead skill
- {universal must} — currently in your `mentioned` list / only one bullet. Move to `core` and add a second proof.

### Gap — flag honestly
- {universal must} — not on your profile. Options:
  - Reframe: {existing experience that is adjacent} — could be honestly described as {universal must} if {condition}.
  - Close: {course / side project / certification that would close the gap}.
  - Widen: this requirement may be more typical of {sub-segment of role family}; searching {other sub-segment} avoids the gap.

## Files this brief reads / writes

- Reads: `postings/{slug}.md` for each analyzed posting; `profile.md` for reconciliation.
- Writes: this file.
- Used by: `resume-profile` (when refreshing targeting), `tailor-application` (as the baseline), `job-search` (when re-running search with sharper queries).
```

Rules:

- Every "universal must" must be traceable to specific M cells in the matrix.
- Never include a row in the matrix that came from only one posting unless it has at least one M.
- Order the matrix by Count descending — most-common requirements first.
- The reconciliation in Section 5 must use the exact wording from the profile's `core` and `mentioned` lists so the user can verify.
