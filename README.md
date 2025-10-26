# prompt-hub

An MIT-licensed hub for high-quality LLM prompts and AI learning resources.

## Structure

- `docs/prompts/` - live prompts by category
- `docs/learning/` - reading lists, notes, cheatsheets, roadmaps, glossary
- `templates/` - shared templates for learning content
- `CHANGELOG.md` - history of changes
- `LICENSE` - MIT license

## Getting started
- Prompts: browse `docs/prompts/` (e.g., `docs/prompts/prompt-booster.md`).
- Learning: start at `docs/learning/README.md` — jump to the [LLM Systems reading list](docs/learning/reading-lists/llm-systems.md) or the [LLM Roadmap](docs/learning/roadmaps/llm-roadmap.md).

## Index generation
- Build topic index: `powershell -ExecutionPolicy Bypass -File scripts/generate-topic-index.ps1`
- Output file: `docs/learning/topics.md`

## Docs site
- Preview locally: `pip install mkdocs mkdocs-material` then `mkdocs serve` (opens http://127.0.0.1:8000)
- Build static site: `mkdocs build` (outputs to `site/`)
- Optional deploy to GitHub Pages: `mkdocs gh-deploy`
- Config file: `mkdocs.yml` (sources are under `docs/`)

## Contributing

Prompts
1. Add or update a `.md` in `prompts/<category>/`.
2. Keep titles clear and include tags.
3. Update `CHANGELOG.md`.

Learning content
1. Choose a type: `learning/(reading-lists|notes|cheatsheets|roadmaps|papers|courses)`.
2. Start from a template in `templates/` and include YAML front matter (`title`, `summary`, `type`, `level`, `topics`, `updated`).
3. Prefer concise commentary over raw link dumps.
4. Update `learning/README.md` if you add a new major topic.
