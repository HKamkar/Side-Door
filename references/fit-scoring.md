# Scoring rubric

How to assign a 0–100 fit score to a posting. Use the same rubric every time — consistency matters more than perfection.

## Dimensions and weights

| Dimension | Weight | What it measures |
| --- | --- | --- |
| Title match | 20 | Does the JD title appear in the user's "Qualified job titles"? |
| Seniority match | 15 | Does the JD's required years/seniority fall within the user's band ±1? |
| Hard skill match | 25 | % of JD must-haves the user has as `core` skills in profile |
| Domain match | 15 | Has the user shipped in this industry before? |
| Location / authorization | 15 | Is location feasible? Is the visa/authorization ask met? |
| Recency | 10 | Posted within 14 days = full, 15–30 days = half, 30+ = quarter |

Total = weighted sum, 0–100.

## How to score each dimension

### Title match (0–20)
- 20 — JD title is verbatim in the profile's `strong` list
- 14 — JD title is a close variant of a `strong` title (e.g., "Sr SWE" vs "Senior Software Engineer")
- 10 — JD title is in the `stretch` list
- 5 — JD title is adjacent but not in the profile list
- 0 — unrelated function

### Seniority match (0–15)
- 15 — JD asks for years within the user's band
- 10 — JD asks for ±1 year outside the band
- 5 — JD asks for ±2 years outside the band
- 0 — wildly off (e.g., JD wants 10+ years, user has 2)

When the gap is downward (JD wants 2 years, user has 10) — score 10 not 15. Overqualification is a real signal recruiters react to.

### Hard skill match (0–25)
Count must-haves explicitly listed in the JD. Score = 25 × (matched / total).

- Match = the skill or its very close synonym appears as `core` in the profile.
- Do not match `mentioned` skills as full points — count them as 0.5.
- Cap matched at total — don't give bonus for extras.

### Domain match (0–15)
- 15 — user has 2+ years shipped in this exact industry
- 10 — user has 1 role in this industry, or 2+ years in a closely adjacent one
- 5 — user has touched the industry as a side project / one-off engagement
- 0 — no domain overlap

### Location / authorization (0–15)
- 15 — location feasible AND no authorization issue
- 10 — remote-friendly OR location is "open to relocation" on profile
- 5 — location is a stretch but doable
- 0 — JD requires authorization the user does not have stated, OR location is impossible

If authorization is a hard blocker, the total score caps at 35 regardless of other dimensions. Surface this loudly.

### Recency (0–10)
- 10 — posted in the last 14 days
- 5 — 15–30 days old
- 2 — 31–60 days old
- 0 — older than 60 days

## Buckets

- 75–100 — Strong fit
- 50–74 — Worth a shot
- 35–49 — Stretch
- under 35 — Skip (do not surface)

## Always show the user

For each posting on the shortlist, show:
- score
- which dimension was weakest (one word: title / seniority / skills / domain / location / recency)
- whether the authorization cap was applied

That's the honest signal. Don't dress up a low score with optimism.
