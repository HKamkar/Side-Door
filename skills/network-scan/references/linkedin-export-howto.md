# How to export your LinkedIn connections

The plugin reads the official LinkedIn data export. Scraping is against LinkedIn's TOS; the data download is supported and free.

## Steps

1. Open LinkedIn in a browser (logged in).
2. Go to **Settings & Privacy** (top right under your avatar).
3. Click **Data privacy** in the left sidebar.
4. Under **How LinkedIn uses your data**, click **Get a copy of your data**.
5. Select **Want something in particular?** → tick **Connections** (this is the only one the plugin needs).
6. Click **Request archive**.
7. LinkedIn emails the file in 10–20 minutes (sometimes immediately).
8. Download the ZIP, extract it — the file you want is `Connections.csv`.
9. Move `Connections.csv` into the working folder (or anywhere under `side-door-workspace/`).

## What the file contains

- Names, current company, current position, profile URL, connection date.
- Email addresses for connections who set their email to visible (usually a minority).
- That's it — no messages, no posts, no relationship strength.

## What the file does NOT contain

- People you follow but aren't connected to.
- People who follow you but you don't follow back.
- Connections' work history beyond their current role.
- How recently you interacted with them.
- "Mutual connections" data.

This is why `network-scan` cannot infer tie strength beyond connection-date. The user's own judgement of "is this someone I can actually message" is the deciding factor.

## Privacy note

The CSV stays on the user's machine. The plugin reads it but does not upload it, share it, or store anything beyond what's needed for the current `network-matches.md` output. If the user wants the data gone, delete `Connections.csv` and `network-matches.md` — that's the full footprint.
