---
title: Developing
summary: Local dev, structure, CI, and deploy flow for the docs site.
---

# Developing

This repo publishes a MkDocs + Material site from the `docs/` folder to GitHub Pages (`gh-pages` branch). This guide covers local setup, structure, CI, deploys, and conventions.

---

## Source Layout

- `docs/` — all site content and assets
  - `learning/` — reading‑lists, notes, cheatsheets, roadmaps, glossary
  - `prompts/` — prompt pages (some with tabs/accordions, copy buttons)
  - `styles/overrides.css` — site CSS overrides (copy button visibility, wrap styles)
  - `assets/wrap-toggle.js` — global “Wrap” toggle (line‑wrap for code blocks)
  - `README.md` — site home (appears as Home)
  - `CHANGELOG.md` — changelog page
- `mkdocs.yml` — site config + nav
- `scripts/generate-topic-index.ps1` — generates `docs/learning/topics.md`

---

## Local Development

Prereqs: Python 3.11+ recommended.

```
pip install mkdocs mkdocs-material
```

Run locally:

```
mkdocs serve
```

Build locally:

```
mkdocs build
```

Regenerate topics index (optional):

```
powershell -ExecutionPolicy Bypass -File scripts/generate-topic-index.ps1
```

---

## CI and Deploys

- Workflow: `.github/workflows/deploy-docs.yml`
  - On PR → `docs-checks` job runs:
    - Install deps from `requirements-docs.txt`
    - Strict build: `mkdocs build --strict`
    - Link check (Lychee) against `docs/**/*.md` with `lychee.toml`
  - On push to `main` → `docs-checks` then `deploy-docs` publishes `site/` to `gh-pages`.
  - Pip caching enabled for faster runs.

Branch protection (recommended):

- Settings → Branches → Protect `main` with required status checks:
  - “Docs Checks (build + links)” must pass
  - Optionally require branch up to date before merging

Do not edit `gh-pages` directly — it is an artifact branch and will be overwritten by deploys.

---

## Authoring Guidelines

- Front matter (YAML) at top of each page:
  - `title`, `summary`, `type`, `level`, `topics: [a, b]`, `updated`, optional `see_also`
- Links: use relative links within `docs/` when possible.
- Tabs/Accordions (Material):
  - Tabs: `=== "Tab Title"` with indented fenced content under each tab
  - Accordions: `??? note "Title"` with indented fenced blocks
- Code blocks:
  - Use fenced blocks (```) so copy buttons appear.
  - Global Wrap toggle in header controls line‑wrapping.

---

## Navigation

Edit `mkdocs.yml` → `nav:` to add pages to the sidebar. Files not in `nav` are still built (and searchable) but won’t appear in the sidebar.

---

## Troubleshooting

- Build fails in CI (strict):
  - Check `mkdocs.yml` syntax and missing files in `nav` entries
  - Fix malformed Markdown (unclosed fences, invalid tab nesting)
- Link checker (Lychee) fails:
  - See `lychee.toml` for excludes/accepted codes (e.g., LinkedIn and 429s)
  - Prefer https URLs and update moved links

