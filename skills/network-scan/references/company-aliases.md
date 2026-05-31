# Company name aliases

A small alias list to catch obvious matches. Extend as needed. Not exhaustive — the goal is to catch the common collisions, not every variant.

| Canonical | Aliases |
| --- | --- |
| Alphabet | Google, Google LLC, Google Inc., YouTube, Waymo |
| Meta | Facebook, Facebook Inc., Instagram, WhatsApp |
| Microsoft | Microsoft Corp., MSFT, GitHub, LinkedIn |
| Amazon | Amazon.com, AWS, Amazon Web Services, Audible |
| Apple | Apple Inc., Apple Computer |
| Stripe | Stripe Inc., Stripe Payments |
| Shopify | Shopify Inc., Shopify Plus |
| Booking | Booking.com, Booking Holdings, Priceline Group |
| Adyen | Adyen NV, Adyen B.V. |
| Bunq | Bunq B.V. |
| ASML | ASML Holding |
| Philips | Royal Philips, Koninklijke Philips |

## Matching rules

- Case-insensitive.
- Strip suffixes: `Inc.`, `LLC`, `Ltd.`, `B.V.`, `GmbH`, `S.A.`, `S.r.l.`, `Co.`, `Corp.`, `Holdings`, `Group`, `International`.
- Strip trailing `.com`, `.io`, `.ai` when the rest is clearly the company name.
- Strip `&` vs `and` — match either form.
- Do NOT alias unrelated companies that share a word (e.g., "Apple" the music label vs "Apple" the tech company — disambiguate with industry signal from the contact's position).

## When in doubt

Show both as separate rows with a note "possible alias of X — confirm". Don't silently merge.
