# shortlist.md schema

Canonical format for `side-door-workspace/shortlist.md`.

```markdown
# Shortlist — {YYYY-MM-DD}

_Last refreshed: {YYYY-MM-DD HH:MM}. Source mode: {browse | search | paste}._

## Search parameters

- **Titles searched:** {title}, {title}, {title}
- **Geography:** {value}
- **Industry filter:** {value or "none"}
- **Company size:** {value or "any"}
- **Postings fetched:** {N}
- **Postings scored:** {N} (others failed to load — see "Fetch failures" below)

## Strong fits (score 75+)

| # | Company | Title | Score | Weakest dim | Link | Posting file |
| - | --- | --- | --- | --- | --- | --- |
| 1 | {Company} | {Title} | 84 | recency | [link]({url}) | [postings/{slug}.md](postings/{slug}.md) |

## Worth a shot (50–74)

| # | Company | Title | Score | Weakest dim | Link | Posting file |
| - | --- | --- | --- | --- | --- | --- |

## Stretch (35–49)

| # | Company | Title | Score | Weakest dim | Link | Posting file |
| - | --- | --- | --- | --- | --- | --- |

## Fetch failures

| URL | Reason |
| --- | --- |
| {url} | login wall / 404 / JS-rendered empty / etc. |

## Authorization-capped postings

Any posting whose score was capped at 35 because the JD requires authorization not on the profile.

| Company | Title | Authorization asked | Link |
| --- | --- | --- | --- |
```

Rules:

- Sort by score within each bucket, descending.
- "Weakest dim" is the single dimension that pulled the score down the most. One word.
- Never include a row without a real URL.
- A posting marked `applied` or `interviewing` in the tracker stays on the shortlist but its row gets a `🟢 applied` or `🟡 interviewing` prefix in the # column.
