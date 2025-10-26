# Learning Hub

This area hosts AI learning resources: curated reading lists, concise notes, cheatsheets, roadmaps, paper notes, and course notes. Everything uses lightweight YAML front matter for tagging and indexing.

## Quick links
- Reading list: [LLM Systems](reading-lists/llm-systems.md)
- Notes: [Transformer Intuition](notes/transformers-intuition.md)
- Cheatsheet: [Retrieval + RAG Evaluation](cheatsheets/retrieval-evals-cheatsheet.md)
- Roadmap: [LLM Roadmap](roadmaps/llm-roadmap.md)
- Glossary: [Glossary](glossary.md)

## Organization
- `reading-lists/` — curated lists with short commentary
- `notes/` — concept summaries and deep dives
- `cheatsheets/` — quick, practical references
- `roadmaps/` — step-by-step pathways through topics
- `papers/` — paper summaries with key takeaways
- `courses/` — course notes and exercises
- `glossary.md` — concise definitions

## Conventions
- Every file starts with YAML front matter: `title`, `summary`, `type`, `level`, `topics`, `updated`, `see_also`.
- Use lowercase-hyphenated filenames (e.g., `agents-reading-list.md`).
- Keep curated lists focused; include 1–2 line commentary per link.
- For now, write `topics` as a single-line bracket list (e.g., `topics: [llms, evals]`) so the index script can parse it.
