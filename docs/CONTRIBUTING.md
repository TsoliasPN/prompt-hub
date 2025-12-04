---
title: Contributing
summary: What contributors need to know to add or update content.
---

## Contributing

Thanks for improving Prompt-Hub! This guide lists the essentials for contributing content.

---

## Quick Checklist

- Edit files under `docs/` only — never `gh-pages`.
- Keep pages short, clear, and useful; avoid link dumps.
- Add YAML front matter at the top:

```yaml
---
title: "Page Title"
summary: "One-line why it matters"
type: reading-list|note|cheatsheet|roadmap
level: beginner|intermediate|advanced
topics: [llms, evals]
updated: YYYY-MM-DD
see_also:
  - ./relative/link.md
---
```

- Use relative links (e.g., `reading-lists/llm-systems.md`).
- Use fenced code blocks (```) so copy buttons appear.
- For tabs/accordions, follow Material syntax (see Developing).

---

## Add a New Page

1. Create the file under `docs/`

1. Add front matter (see above)

1. (Optional) Add to sidebar nav: edit `mkdocs.yml` → `nav:`

1. (Optional) Update topics index:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/generate-topic-index.ps1
```

1. Preview locally:

```bash
mkdocs serve
```

---

## Submitting a Change

- Open a Pull Request to `main`.
- CI checks must pass:
  - Strict MkDocs build
  - Link check on Markdown sources
- After merge to `main`, the site is deployed automatically to GitHub Pages.

---

## Style Notes

- Prefer concise bullets and short paragraphs.
- Use meaningful section headers.
- Prefer en/em dashes (–/—) over hyphen spam where appropriate.
- Keep link text descriptive (not "here").
