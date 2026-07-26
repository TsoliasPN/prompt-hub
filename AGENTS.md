# AGENTS.md

Read [CONTRIBUTING.md](CONTRIBUTING.md) first. This repo uses a lightweight, content-focused workflow.

## Quick facts

- GitHub issues and milestones are the live source of truth.
- Use `Backlog` when no thematic milestone fits.
- Branches follow `<actor>/<type>/<scope>/<task>-<id>`.
- Keep work scoped to `prompts`, `learning`, `templates`, `site`, `scripts`, `docs`.

## Repo map

- `docs/prompts/` and `docs/learning/`: primary content source
- `templates/`: reusable content templates
- `prompts/`: supplemental prompt assets
- `site/`: generated output
- `scripts/`: repo automation
- `docs/`: MkDocs source, navigation, and site pages

## Before non-trivial edits

1. Find or create the GitHub issue.
2. Confirm the milestone.
3. Branch from `main`.
4. Keep validation lightweight: `mkdocs serve`, `mkdocs build`, or the relevant script if needed.

## Working rules

- Preserve frontmatter and navigation consistency.
- Regenerate `docs/learning/topics.md` only when learning topics change.
- Do not add heavyweight CI or policy gates unless the repo already warrants them.

## Agent execution protocol

Agent-managed issues on the owner-scope GitHub Project #3 ("Portfolio Workspace and
Site Readiness") follow the shared **agent execution protocol**: the `Agent State`
lifecycle (`Agent Todo → Agent Working → Agent Needs Input | Agent Review | Agent Done`),
idempotent receipt comments (`AGENT CLAIMED` / `AGENT BLOCKED` / `AGENT DONE`), and the
`needs-input` hard stop. Drive state with the receipt scripts, not ad-hoc project edits.

Canonical spec and tooling live in `koletsos-portfolio`:
- Protocol: https://github.com/pcoletsos/koletsos-portfolio/blob/main/docs/agent-execution-protocol.md
- Scripts: https://github.com/pcoletsos/koletsos-portfolio/tree/main/scripts
  (`github-agent-receipt.ps1`, `github-agent-needs-input.ps1`, `github-agent-queue.ps1`)

## CI Action Failure & Guardrail Rules

- On any CI/Action failure, extract logs via `gh run view <run_id> --log-failed`, identify root cause, and implement pre-flight prevention.
