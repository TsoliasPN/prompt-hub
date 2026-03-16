# Architectural Decision Records

This document captures key architectural decisions made for the prompt-hub project.

## ADR-001: MkDocs with Material Theme

**Status:** Accepted

**Context:**
Need a static site generator for documentation that's easy to maintain, looks modern, and supports GitHub Pages.

**Decision:**
Use MkDocs with the Material theme for site generation.

**Rationale:**
- Simple Markdown-based content (no complexity)
- Material theme provides excellent UX out of the box
- Built-in search functionality
- Dark mode support
- Code block syntax highlighting
- Easy GitHub Pages deployment
- Active maintenance and community
- Lightweight and fast

**Alternatives Considered:**
- **Jekyll:** Ruby-based, more complex setup, GitHub's default
- **Hugo:** Fast but more complex configuration
- **Docusaurus:** React-based, overkill for our needs
- **VuePress:** Vue-based, unnecessary JavaScript overhead
- **Sphinx:** Python-centric, better for API docs

**Trade-offs:**
- Python dependency required (acceptable)
- Manual navigation in mkdocs.yml (provides full control)

---

## ADR-002: YAML Frontmatter for Metadata

**Status:** Accepted

**Context:**
Need structured metadata for content discovery, filtering, and index generation.

**Decision:**
Use YAML frontmatter at the top of all Markdown files.

**Rationale:**
- Standard convention in static site generators
- Human-readable and editable
- Easy to parse programmatically
- Supports multiple data types (strings, lists, dates)
- Works with MkDocs and other tools
- Enables automated index generation

**Format:**
```yaml
---
title: Content Title
summary: Brief description
type: note | reading-list | cheatsheet | roadmap | paper | course
level: beginner | intermediate | advanced
topics: [topic1, topic2]
tags: [tag1, tag2]  # For prompts
updated: YYYY-MM-DD
see_also: [file1.md, file2.md]
---
```

**Alternatives Considered:**
- **JSON frontmatter:** Less readable
- **Inline metadata (HTML comments):** Harder to parse
- **Separate metadata files:** Harder to maintain
- **No metadata:** Limits discoverability

---

## ADR-003: Separate Prompts and Learning Areas

**Status:** Accepted

**Context:**
Repository serves two distinct purposes: prompt library and learning resources.

**Decision:**
Maintain separate directory structures:
- `docs/prompts/` for prompt library
- `docs/learning/` for educational content

**Rationale:**
- Clear separation of concerns
- Different content types have different needs
- Easier navigation for users
- Enables different metadata schemas
- Simpler to manage contributions
- Allows independent expansion

**Structure:**
```
docs/
├── prompts/          # Prompt library
│   └── <categories>/ # Organized by use case
└── learning/         # Learning resources
    ├── reading-lists/
    ├── notes/
    ├── cheatsheets/
    ├── roadmaps/
    └── glossary.md
```

---

## ADR-004: MIT License

**Status:** Accepted

**Context:**
Need to choose an open-source license for content sharing.

**Decision:**
Use MIT License for all content.

**Rationale:**
- Maximum permissiveness for users
- No restrictions on commercial use
- Clear and simple terms
- Industry standard for open content
- Encourages sharing and remixing
- Low burden for contributors

**Alternatives Considered:**
- **CC-BY:** Better for documentation, but less common for code-adjacent content
- **Apache 2.0:** More complex, patent protection unnecessary
- **GPL:** Too restrictive for content repository
- **Public Domain (CC0):** Less protection for contributors

---

## ADR-005: Script-Based Automation

**Status:** Accepted

**Context:**
Need automation for tasks like index generation without complex build systems.

**Decision:**
Use PowerShell scripts for automation tasks.

**Rationale:**
- Native Windows support (primary development platform)
- Powerful scripting capabilities
- Can parse Markdown and YAML
- Simple to run and modify
- No additional dependencies
- Cross-platform support (PowerShell Core)

**Examples:**
- `generate-topic-index.ps1` - Create topics index
- Future: link checker, frontmatter validator

**Alternatives Considered:**
- **Python scripts:** Additional dependency
- **Node.js scripts:** Overkill for simple tasks
- **Bash scripts:** Windows compatibility issues
- **GitHub Actions only:** Want local execution option

---

## ADR-006: Manual Navigation Configuration

**Status:** Accepted

**Context:**
MkDocs can auto-generate navigation or use manual configuration.

**Decision:**
Manually configure navigation in `mkdocs.yml`.

**Rationale:**
- Full control over organization and ordering
- Explicit structure easier to understand
- Can group related items logically
- Better user experience than alphabetical auto-sort
- Intentional curation of what appears in nav

**Trade-offs:**
- Must manually update when adding content
- Could become maintenance burden with hundreds of files
- But: encourages thoughtful organization

**When to Reconsider:**
If content exceeds ~100 files and manual updates become too burdensome, consider:
- Auto-generation with custom sorting
- Plugin-based navigation
- Multi-level automatic discovery

---

## ADR-007: Templates for Content Types

**Status:** Accepted

**Context:**
Need consistency across similar content types.

**Decision:**
Provide templates in `templates/` directory for common content types.

**Rationale:**
- Ensures consistent structure
- Makes contribution easier
- Documents expected format
- Reduces decision fatigue
- Improves content quality

**Current Templates:**
- `reading-list.md` - For curated resource lists
- `resource-note.md` - For concept notes and summaries

**Future Templates:**
- Cheatsheet template
- Roadmap template
- Prompt template
- Paper summary template

---

## ADR-008: Flat Structure with Categories

**Status:** Accepted

**Context:**
Balance between organizational depth and simplicity.

**Decision:**
Use mostly flat structure within categories, avoid deep nesting.

**Structure:**
```
docs/prompts/
├── interview-preparation/  # Category (one level)
│   └── *.md
├── news-processing/        # Category
│   └── *.md
└── prompt-booster.md      # Standalone

docs/learning/
├── reading-lists/          # Type (one level)
│   └── *.md
├── notes/                  # Type
│   └── *.md
```

**Rationale:**
- Easier to navigate and discover
- Simpler file paths
- Less cognitive overhead
- Avoids taxonomy debates (deep categories)
- Files can have multiple tags/topics for cross-categorization

**Exceptions:**
Some prompts may have subcategories (e.g., `meta/behavior-changers.md`) when there's clear logical grouping.

---

## ADR-009: Topic Index Generation

**Status:** Accepted

**Context:**
Need discoverability across learning content without manual index maintenance.

**Decision:**
Auto-generate `docs/learning/topics.md` from YAML frontmatter using script.

**Rationale:**
- Single source of truth (frontmatter)
- No manual index maintenance
- Consistent categorization
- Easy to update (just run script)
- Shows all content tagged with each topic

**Implementation:**
- PowerShell script scans learning/ directory
- Parses YAML frontmatter from each file
- Extracts topics lists
- Groups files by topic
- Generates Markdown with links

**Trade-offs:**
- Requires running script after changes
- Could be automated with pre-commit hook
- Manual run is acceptable for now

---

## ADR-010: CHANGELOG Documentation

**Status:** Accepted

**Context:**
Need to track changes over time for users and contributors.

**Decision:**
Maintain `CHANGELOG.md` following "Keep a Changelog" format.

**Rationale:**
- Clear history of changes
- Users can see what's new
- Contributors understand recent work
- Standard format (keepachangelog.com)
- Git history not user-friendly enough

**Format:**
```markdown
## [Unreleased]
### Added
- New prompt: X
### Changed
- Updated Y

## [1.0.0] - 2026-03-16
### Added
- Initial release
```

**When to Update:**
- Every significant content addition
- Every structural change
- Before each "release" or major update
