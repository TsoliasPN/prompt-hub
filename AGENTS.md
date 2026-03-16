# AGENTS.md

Guidelines for AI coding assistants working on the prompt-hub project.

## Project Overview

**prompt-hub** is a documentation repository and static site hosting curated LLM prompts and AI learning resources. It uses MkDocs with Material theme to generate a searchable, browsable website from Markdown files.

**Key characteristics:**
- Documentation site (MkDocs + Material theme)
- MIT-licensed, open-source content
- Two main content areas: prompts and learning resources
- YAML frontmatter for metadata
- Static site generation for GitHub Pages
- Script-based automation (PowerShell)

## Architecture

### Technology Stack
- **Static Site Generator:** MkDocs with Material theme
- **Content Format:** Markdown (.md files)
- **Metadata:** YAML frontmatter
- **Scripts:** PowerShell (.ps1)
- **Hosting:** GitHub Pages (optional)
- **Config:** mkdocs.yml

### Directory Structure

```
prompt-hub/
├── docs/                    # All content source files
│   ├── prompts/            # Prompt library
│   │   ├── interview-preparation/
│   │   ├── meta/
│   │   ├── news-processing/
│   │   ├── templates/
│   │   └── prompt-booster.md
│   ├── learning/           # Learning resources
│   │   ├── reading-lists/
│   │   ├── notes/
│   │   ├── cheatsheets/
│   │   ├── roadmaps/
│   │   ├── glossary.md
│   │   ├── topics.md       # Generated index
│   │   └── README.md
│   └── README.md           # Site homepage
├── templates/              # Content templates
│   ├── reading-list.md
│   └── resource-note.md
├── scripts/                # Automation scripts
│   └── generate-topic-index.ps1
├── site/                   # Generated static site (gitignored)
├── archive/                # Old content
├── mkdocs.yml             # MkDocs configuration
├── CHANGELOG.md           # Version history
└── requirements-docs.txt  # Python dependencies
```

## Content Standards

### YAML Frontmatter

All content files should include YAML frontmatter at the top:

#### For Prompts
```yaml
---
title: Prompt Title
summary: One-line description of what this prompt does
tags: [category1, category2, use-case]
updated: 2026-03-16
---
```

#### For Learning Content
```yaml
---
title: Topic Name
summary: Brief description of the content
type: reading-list | note | cheatsheet | roadmap | paper | course
level: beginner | intermediate | advanced
topics: [llms, evals, agents]
updated: 2026-03-16
see_also: [related-file.md, other-file.md]
---
```

### File Naming Conventions

- Use lowercase with hyphens: `my-prompt-name.md`
- Be descriptive but concise
- Group related prompts in subdirectories
- Match filename to title (loosely)

**Examples:**
- `prompt-booster.md`
- `llm-systems.md`
- `transformers-intuition.md`

### Content Structure

#### Prompts
```markdown
---
title: My Prompt
summary: What it does
tags: [coding, assistant]
updated: 2026-03-16
---

## Context

Brief explanation of when to use this prompt.

## Prompt

```
The actual prompt text goes here.
Use appropriate formatting.
```

## Variations

Alternative versions or modifications.

## Examples

Sample usage and outputs.
```

#### Learning Content
```markdown
---
title: Topic Guide
summary: Overview of topic
type: reading-list
level: intermediate
topics: [llms, evaluation]
updated: 2026-03-16
---

## Overview

Brief introduction to the topic.

## Resources

### Resource Name

**Link:** [URL](https://...)  
**Commentary:** 1-2 lines about why this is valuable.

### Another Resource

**Link:** [URL](https://...)  
**Commentary:** Key takeaways or context.
```

## Common Tasks

### Adding a New Prompt

1. **Choose location:** `docs/prompts/<category>/`
2. **Create file:** Use lowercase-hyphenated naming
3. **Add frontmatter:** Include title, summary, tags, updated
4. **Write content:** Context, prompt text, variations, examples
5. **Update nav:** Add to `mkdocs.yml` if it should appear in navigation
6. **Update CHANGELOG.md:** Document the addition

### Adding Learning Content

1. **Choose type:** reading-list, note, cheatsheet, roadmap, paper, course
2. **Start from template:** Copy from `templates/` if available
3. **Create file:** In appropriate `docs/learning/<type>/` directory
4. **Add frontmatter:** All required fields (title, summary, type, level, topics, updated)
5. **Write content:** Follow template structure
6. **Update nav:** Add to `mkdocs.yml`
7. **Regenerate topics index:** Run `scripts/generate-topic-index.ps1`
8. **Update CHANGELOG.md:** Document the addition

### Modifying Existing Content

1. **Edit the file:** Make changes to content
2. **Update frontmatter:** Change `updated` date to today
3. **Update nav if needed:** If title changed, update `mkdocs.yml`
4. **Regenerate topics:** If topics changed, run index script
5. **Update CHANGELOG.md:** Document the change

### Testing Changes Locally

```powershell
# Install dependencies (first time only)
pip install mkdocs mkdocs-material

# Start local preview server
mkdocs serve

# Open browser to http://127.0.0.1:8000

# Build static site (optional)
mkdocs build
```

### Regenerating Topic Index

```powershell
# From repository root
powershell -ExecutionPolicy Bypass -File scripts/generate-topic-index.ps1

# Outputs to docs/learning/topics.md
```

## MkDocs Configuration

### mkdocs.yml Structure

- **site_name, site_description:** Site metadata
- **docs_dir:** Source directory for content (docs/)
- **theme:** Material theme with features
- **markdown_extensions:** Enable advanced Markdown
- **nav:** Manual navigation structure

### Adding to Navigation

Edit `mkdocs.yml` nav section:

```yaml
nav:
  - Home: README.md
  - Prompts:
      - New Category:
          - My Prompt: prompts/new-category/my-prompt.md
  - Learning:
      - Reading Lists:
          - New List: learning/reading-lists/new-list.md
```

## Content Guidelines

### Writing Style

- **Clear and concise:** Get to the point quickly
- **Actionable:** Provide practical value
- **Well-structured:** Use headings, lists, code blocks
- **Accurate:** Verify information and links
- **Updated:** Keep content current

### Prompts
- Explain the context and use case
- Provide the full prompt text in code blocks
- Include variations for different scenarios
- Add examples of usage/output when helpful
- Credit sources if adapted from elsewhere

### Learning Resources
- Curate quality over quantity
- Add 1-2 lines of commentary per resource
- Explain why it's valuable or what it covers
- Keep lists focused and organized
- Update broken links promptly

### Tags and Topics

**For prompts (tags):**
- Use lowercase
- Be specific: `coding`, `documentation`, `debugging`
- Include use cases: `interview`, `learning`, `analysis`
- Include format: `system-prompt`, `few-shot`, `chain-of-thought`

**For learning (topics):**
- Match established topics in other files
- Common topics: `llms`, `agents`, `evals`, `rag`, `fine-tuning`
- Keep list focused (3-5 topics per file)

## Scripts and Automation

### generate-topic-index.ps1

**Purpose:** Creates `docs/learning/topics.md` by scanning all learning content for topics.

**How it works:**
1. Scans `docs/learning/` for .md files
2. Parses YAML frontmatter
3. Extracts topics array
4. Groups files by topic
5. Generates index with links

**When to run:**
- After adding new learning content
- After changing topics in frontmatter
- Before committing significant changes

## Design Principles

1. **MIT Licensed:** All content is freely usable
2. **Quality over quantity:** Curate valuable content
3. **Organized:** Clear categorization and navigation
4. **Searchable:** Good metadata and structure
5. **Accessible:** Simple Markdown, no barriers
6. **Up-to-date:** Regular maintenance of links and content
7. **Community-friendly:** Easy to contribute

## Important Notes

- **YAML frontmatter:** Required for all content files
- **topics.md:** Auto-generated, don't edit manually
- **CHANGELOG.md:** Document all significant changes
- **Navigation:** Must manually update mkdocs.yml
- **Date format:** YYYY-MM-DD (ISO format)
- **Line length:** No hard limit, but keep reasonable for readability
- **Links:** Use relative links for internal, absolute for external
- **Code blocks:** Use triple backticks with language identifier

## When Suggesting Changes

- Maintain existing format and structure conventions
- Update all related files (CHANGELOG.md, mkdocs.yml, topics index)
- Check that links work
- Follow YAML frontmatter requirements
- Preserve MIT license for all new content
- Keep the flat, simple structure (avoid deep nesting)
- Test with `mkdocs serve` before committing
