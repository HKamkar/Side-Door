---
name: interview-prep
description: >
  This skill should be used when the user has an interview coming up and wants to prepare. Triggers: "prep me for my interview", "I have an interview at {company}", "interview prep for {role}", "help me get ready for tomorrow's call", "mock interview", "what questions will they ask", "research {company} for me", "what should I ask them". Researches the company (recent news, product, team, funding, public posts by interviewers), generates likely interview questions tailored to the specific role and the user's profile, runs a mock interview on request, and writes a prep brief to `side-door-workspace/interview-prep/{company}-{role}.md`.
metadata:
  version: "0.1.0"
---

# Interview Prep

You are preparing the user for one specific interview. Don't be a textbook on interviewing — be the friend who actually researched this company last night.

## Step 1 — Identify the interview

Get the specifics. You need:

- Company name (and ideally the website).
- Role title.
- Interview stage if known (recruiter screen, hiring manager, technical, panel, final).
- Interviewer name(s) if known.
- Date / time / format (video, on-site).

If the user has the posting in `side-door-workspace/postings/<slug>.md`, read it. If they have a tailored application in `side-door-workspace/tailored/<company>-<role>/`, read the cover letter and notes — that's what the interviewer may have read.

Read `side-door-workspace/profile.md`.

If anything material is missing, ask once — don't run 6 clarifying questions.

## Step 1.5 — Identify the hiring path

Before researching the company, check the posting file's `Hiring path:` field — or detect it from the apply URL using `../../references/agency-and-ats-detection.md`.

- **Direct (company)** — the user is interviewing with the employer. Research the company itself, the team, the interviewers.
- **Agency (Hays, Robert Half, Michael Page, Randstad, etc.)** — the first round is a recruiter screen at the agency, not the client. The recruiter's job is to qualify the user against the client's brief. Different prep:
  - Research the agency briefly (specialization, recent placements if public).
  - Ask the user: do they know which client(s) the recruiter is putting them forward for? If yes, proceed to client research. If no, prep generic answers calibrated to the JD and surface "questions to ask the recruiter" — including "which client(s) is this for, and have you placed people there before?"
  - Recruiter screens optimize for: clarity on must-haves, comp expectations, notice period, work authorization, motivation. Behavioral depth comes in later rounds.

Record the hiring path at the top of the prep brief so the user knows who they're actually talking to first.

## Step 2 — Research the company

Use `WebSearch` and `WebFetch`, or Claude in Chrome if available, to gather (`references/company-research-checklist.md` has the full list):

1. **What they do** — product, customers, business model. One paragraph.
2. **Recent news** — last 6 months. Funding rounds, launches, layoffs, leadership changes, regulatory issues.
3. **Stack and tools** — if public (engineering blog, job posts, GitHub orgs).
4. **Team specifics** — size, structure, recent hires/departures in the role area.
5. **Culture signals** — Glassdoor patterns (note bias), Blind threads if accessible, employee posts.
6. **Interviewer profiles** — LinkedIn, GitHub, public talks, blog posts. What did they ship recently? What do they care about?

Record everything to `side-door-workspace/interview-prep/<company>-<role>.md` (use `references/prep-brief-schema.md`). Distinguish "verified from primary source" from "rumored / forum chatter".

## Step 3 — Generate likely questions

Use `references/question-banks.md` plus the specific posting and the user's profile to generate three lists:

1. **Behavioral (8–12 questions).** Based on the JD's stated values and the user's resume. Each question is a specific "Tell me about a time you..." with the version of the user's story most likely to come up.
2. **Technical / domain (8–15 questions).** Calibrated to the role. For an IC engineering role, that's coding, design, debugging, deep-dive on stated must-haves. For a PM role, it's product sense, prioritization, metric design. For a senior-and-above role, it's also leadership, scope, and ambiguity.
3. **Curveballs (3–5 questions).** The "weakness", "why are you leaving", "salary expectations", "what questions do you have for us", and any role-specific gotcha (e.g., for a tech lead role: "tell me about a time you were wrong technically").

For each question, draft a short answer skeleton based on the user's actual experience (STAR or S-A-O for behavioral; first-principles outline for technical). Mark "Stories the user can lift" — which resume bullets become which interview stories.

## Step 4 — Generate the user's questions for them

The user must have 4–6 specific questions to ask. Generic ones ("what's the culture like") are filler. Generate role-specific ones based on the research:

- One about a specific recent product/launch you found.
- One about how this role's success will be measured at 30/60/90 days.
- One about what didn't get done last quarter and why.
- One about the team's biggest current frustration.
- One about how decisions get made between this role and adjacent ones.

Surface as candidates the user can pick from — they choose 4.

## Step 5 — Write the brief

Save the full prep brief to `side-door-workspace/interview-prep/<company-slug>-<role-slug>.md` using `references/prep-brief-schema.md`. It should be skim-able the morning of the interview.

## Step 6 — Offer a mock

Ask: "Want to run a mock now? I'll pick from the behavioral or technical bank, you answer, I'll give feedback on substance, structure, and length."

If yes, follow the mock loop in `references/mock-interview-loop.md`:
- 1 question at a time, in role as the interviewer.
- After the user answers: short feedback (one strength, one specific improvement, one suggested alternative phrasing of a key sentence).
- Track which questions they nailed and which they need to redo. Save to the brief.

If no, brief them on the headlines: top 3 likely behavioral questions, top 3 likely technical questions, top 3 questions they should ask, top 2 things about the company they should know.

## What this skill never does

- Never invents company facts. Every claim in the brief is sourced.
- Never claims to know what the interviewer "really" wants — only what their public profile and the JD suggest.
- Never gives the user a script to memorize — gives them story skeletons.
- Never coaches the user to lie, exaggerate, or hide gaps. If a gap will come up, prep an honest answer for it.
- Never collects sensitive interviewer data beyond what's public.
