# Contributing to prompt-hub

This repository is content-first. Keep the workflow lightweight and treat GitHub as the source of truth for issues and milestones.

## Source of truth

- GitHub issues and milestones are authoritative.
- If a markdown file and GitHub disagree, GitHub wins.
- Use `Backlog` as the fallback milestone when no thematic milestone fits.

## Before you edit

For any non-trivial change:

1. Find or create the GitHub issue.
2. Make sure the issue has a milestone.
3. Create a branch from `main` using the canonical pattern:
   `<actor>/<type>/<scope>/<task>-<id>`
4. Keep the work inside the repo scopes: `prompts`, `learning`, `templates`, `site`, `scripts`, `docs`.

## Typical workflow

- Content changes should keep frontmatter, links, and navigation consistent.
- Learning content should regenerate `docs/learning/topics.md` only when topics change.
- Site and docs changes should be checked with `mkdocs serve` or `mkdocs build` when practical.
- Prefer lightweight validation over new guardrails.

## Pull requests

- Link the issue.
- Summarize what changed.
- Note what you verified and what you did not run.

## Good defaults

- Prefer small, reviewable content-focused changes.
- Do not edit generated output unless the generator is part of the task.
- Keep process simple unless the repo clearly needs more structure.
