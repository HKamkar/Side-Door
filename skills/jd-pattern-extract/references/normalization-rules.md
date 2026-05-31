# Normalization rules

When tabulating requirements across multiple JDs, the same skill is named differently. Apply these merges before counting. The list is not exhaustive — extend as needed for the role family you're patterning.

## General rules

- **Case-insensitive matching.** "Python" = "python" = "PYTHON".
- **Version-strip.** "Python 3" = "Python 3.10" = "Python". Versions become a separate "modern <X>" row only if multiple JDs specify a recent version.
- **Plural collapse.** "APIs" = "API". "Databases" = "database experience" only when generic.
- **Synonym collapse.** Always merge these:
  - `Postgres` / `PostgreSQL` → `PostgreSQL`
  - `JS` / `JavaScript` → `JavaScript`
  - `TS` / `TypeScript` → `TypeScript`
  - `K8s` / `Kubernetes` → `Kubernetes`
  - `GCP` / `Google Cloud` / `Google Cloud Platform` → `GCP`
  - `AWS` / `Amazon Web Services` → `AWS`
  - `Azure` / `Microsoft Azure` → `Azure`
  - `CI/CD` / `continuous integration` / `continuous deployment` → `CI/CD`
  - `IaC` / `infrastructure as code` / `Terraform` (when generic) → keep `Terraform` if named, else `IaC`
  - `LLM` / `large language model` → `LLM`
  - `ML` / `machine learning` → `machine learning`
  - `gen AI` / `generative AI` / `genAI` → `generative AI`
  - `B2B SaaS` / `enterprise SaaS` → `B2B SaaS`
  - `OKRs` / `objectives and key results` → `OKRs`
  - `A/B testing` / `experimentation` → `experimentation`
  - `KPI` / `key performance indicators` → `KPIs`

## Skill abstraction rules

When a JD mentions one tool but the requirement is really the category:

- "AWS, GCP, or Azure" → row: `any major cloud`. Specific cloud rows still exist if a JD requires a specific one.
- "React, Vue, or Angular" → row: `modern frontend framework`. Specific framework rows still exist.
- "Postgres or MySQL" → row: `relational database experience`. Postgres / MySQL rows still exist.
- "Python, Go, or Java" → row: `backend language proficiency`. Specific language rows still exist.

A user who has "Postgres core" matches both `PostgreSQL` and `relational database experience` rows.

## Soft-skill normalization

These get noisy. Merge to a small canonical list:

- `communication skills` / `excellent communicator` / `strong written and verbal` → `strong written + verbal communication`
- `team player` / `collaborative` / `cross-functional` → `cross-functional collaboration`
- `self-starter` / `proactive` / `bias for action` → `bias for action`
- `analytical thinking` / `data-driven` / `metrics-oriented` → `data-driven thinking`
- `ownership` / `accountable` / `takes ownership` → `ownership`

Soft skills with no evidence in the JD beyond the phrase itself are still counted (they tell you what the JD writer values), but flagged as "vibes" in the matrix.

## What NOT to normalize

- Don't merge `Senior` and `Staff` titles. Those are different bands.
- Don't merge specific named frameworks unless explicitly listed as "or" alternatives in the same JD.
- Don't merge industry terms across very different segments ("fintech" ≠ "financial services" if the JDs say different things — keep separate and let the count speak).

## When in doubt

Keep two rows, not one. False merges hide signal; honest splits reveal it. The matrix can have 40 rows — the reader scans the Count column anyway.
