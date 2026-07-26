# Gemini instructions

Read [CONTRIBUTING.md](CONTRIBUTING.md) first.

- GitHub issues and milestones are authoritative.
- Use `Backlog` when no thematic milestone fits.
- Branch format: `<actor>/<type>/<scope>/<task>-<id>`.
- Keep changes inside `prompts`, `learning`, `templates`, `site`, `scripts`, `docs`.
- Prefer lightweight validation.
- Regenerate `docs/learning/topics.md` only when learning topics change.

Shared agent execution protocol: see the `Agent execution protocol` section in `AGENTS.md`.

## CI Action Failure & Guardrail Rules

- On any CI/Action failure, extract logs via `gh run view <run_id> --log-failed`, identify root cause, and implement pre-flight prevention.
