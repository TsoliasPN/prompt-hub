# Contributing to prompt-hub

Thank you for your interest in contributing! This guide will help you add prompts or learning content to the repository.

## Quick Start

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Create a branch** for your contribution
4. **Add or modify content** following the guidelines below
5. **Test locally** with `mkdocs serve`
6. **Submit a pull request**

## What to Contribute

### Prompts
- System prompts for specific use cases
- Role-based prompts (developer assistant, writing coach, etc.)
- Few-shot examples
- Prompt chains or workflows
- Specialized domain prompts

### Learning Content
- **Reading lists:** Curated resources on AI/LLM topics
- **Notes:** Concept explanations and deep dives
- **Cheatsheets:** Quick reference guides
- **Roadmaps:** Learning paths through topics
- **Paper summaries:** Key takeaways from research papers
- **Course notes:** Summaries from online courses

## Guidelines

### General Principles

- ✅ **Quality over quantity:** Well-crafted, useful content
- ✅ **Clear and concise:** Easy to understand and use
- ✅ **Properly attributed:** Credit sources and inspirations
- ✅ **Up-to-date:** Current and accurate information
- ✅ **Well-organized:** Follows existing structure and conventions

### Content Standards

#### For Prompts

**Required Elements:**
- Clear title and summary
- Context explanation (when to use it)
- The actual prompt text
- Tags for discoverability
- Updated date

**Best Practices:**
- Test the prompt before submitting
- Include variations for different scenarios
- Provide example outputs if helpful
- Explain any placeholders or customization points
- Credit the original source if adapted

**Example Structure:**
```markdown
---
title: Code Review Assistant
summary: Provides thorough, constructive code reviews
tags: [coding, review, development]
updated: 2026-03-16
---

## Context

Use this prompt when you need detailed code review feedback...

## Prompt

\`\`\`
You are an experienced code reviewer...
\`\`\`

## Variations

For security-focused reviews, add...

## Examples

Input: [code snippet]
Output: [review feedback]
```

#### For Learning Content

**Required YAML Frontmatter:**
```yaml
---
title: Content Title
summary: Brief description (1 line)
type: reading-list | note | cheatsheet | roadmap | paper | course
level: beginner | intermediate | advanced
topics: [relevant, topics, lowercase]
updated: YYYY-MM-DD
see_also: [related-file.md]  # optional
---
```

**Best Practices:**
- Follow templates in `templates/` directory
- Keep reading lists focused (10-20 items)
- Add 1-2 line commentary for each resource
- Use clear headings and structure
- Include practical value/takeaways
- Link to authoritative sources

### File Naming

- Use **lowercase** with **hyphens**: `my-prompt-name.md`
- Be **descriptive** but **concise**
- Match the content title (loosely)

**Good:**
- `code-review-assistant.md`
- `llm-evaluation-guide.md`
- `transformers-deep-dive.md`

**Avoid:**
- `MyPrompt.md` (not lowercase)
- `p1.md` (not descriptive)
- `this_is_my_super_long_filename_for_a_prompt.md` (too long)

### Directory Structure

#### Prompts
Place in appropriate category under `docs/prompts/`:

```
docs/prompts/
├── coding/           # Coding-related prompts
├── writing/          # Writing and content
├── analysis/         # Analysis and research
├── learning/         # Education and teaching
└── meta/            # Meta prompts (prompts about prompting)
```

Create a new category if needed, but check with maintainers first.

#### Learning Content
Place in appropriate type under `docs/learning/`:

```
docs/learning/
├── reading-lists/    # Curated resource lists
├── notes/           # Concept explanations
├── cheatsheets/     # Quick references
├── roadmaps/        # Learning paths
├── papers/          # Paper summaries
└── courses/         # Course notes
```

## Step-by-Step Process

### Adding a Prompt

1. **Choose location:** `docs/prompts/<category>/`
   ```bash
   # Create category directory if needed
   mkdir docs/prompts/my-category
   ```

2. **Create file:** Use template or start fresh
   ```bash
   touch docs/prompts/my-category/my-prompt.md
   ```

3. **Add frontmatter:**
   ```yaml
   ---
   title: My Prompt Title
   summary: One-line description
   tags: [tag1, tag2, use-case]
   updated: 2026-03-16
   ---
   ```

4. **Write content:** Context, prompt, variations, examples

5. **Update navigation:** Edit `mkdocs.yml`
   ```yaml
   nav:
     - Prompts:
         - My Category:
             - My Prompt: prompts/my-category/my-prompt.md
   ```

6. **Update CHANGELOG.md:**
   ```markdown
   ## [Unreleased]
   ### Added
   - New prompt: My Prompt Title (`prompts/my-category/my-prompt.md`)
   ```

7. **Test locally:**
   ```bash
   mkdocs serve
   # Visit http://127.0.0.1:8000
   ```

### Adding Learning Content

1. **Choose content type and location**
   ```bash
   # Example: adding a reading list
   touch docs/learning/reading-lists/my-topic.md
   ```

2. **Copy template:**
   ```bash
   cp templates/reading-list.md docs/learning/reading-lists/my-topic.md
   ```

3. **Fill in frontmatter:** All required fields

4. **Write content:** Follow template structure

5. **Update navigation:** Edit `mkdocs.yml`
   ```yaml
   nav:
     - Learning:
         - Reading Lists:
             - My Topic: learning/reading-lists/my-topic.md
   ```

6. **Regenerate topic index:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts/generate-topic-index.ps1
   ```

7. **Update CHANGELOG.md**

8. **Test locally:** `mkdocs serve`

### Updating Existing Content

1. **Edit the file:** Make your changes

2. **Update `updated` date:** Change to today's date in frontmatter

3. **Update navigation:** Only if title changed

4. **Regenerate topic index:** If topics changed
   ```powershell
   powershell -ExecutionPolicy Bypass -File scripts/generate-topic-index.ps1
   ```

5. **Update CHANGELOG.md:**
   ```markdown
   ## [Unreleased]
   ### Changed
   - Updated X with new information
   ```

6. **Test locally:** Verify changes

## Testing

### Local Preview

```bash
# Install dependencies (first time only)
pip install mkdocs mkdocs-material

# Start preview server
mkdocs serve

# Open http://127.0.0.1:8000 in browser
```

### Checklist Before Submitting

- [ ] YAML frontmatter is complete and correct
- [ ] File name follows conventions (lowercase-hyphenated)
- [ ] Content is well-structured and proofread
- [ ] Links work (internal and external)
- [ ] Added to navigation in mkdocs.yml
- [ ] CHANGELOG.md updated
- [ ] Topic index regenerated (for learning content)
- [ ] Tested locally with `mkdocs serve`
- [ ] No build errors

## Pull Request Process

1. **Create a descriptive PR title**
   - Good: "Add code review assistant prompt"
   - Bad: "New prompt"

2. **Fill out PR description:**
   - What: What content did you add/change?
   - Why: Why is this valuable?
   - Testing: How did you test it?

3. **Link related issues:** If applicable

4. **Request review:** Assign to maintainers

5. **Address feedback:** Respond to review comments

6. **Wait for merge:** Maintainers will merge when ready

## Style Guide

### Writing

- Use **clear, concise language**
- Write in **present tense**
- Use **active voice** when possible
- Be **specific and actionable**
- Include **examples** when helpful

### Markdown

- Use `**bold**` for emphasis
- Use `*italic*` for slight emphasis
- Use `` `code` `` for inline code, commands, file names
- Use triple backticks for code blocks with language
- Use `>` for important callouts/quotes
- Use numbered lists for sequential steps
- Use bullet lists for non-sequential items

### Links

```markdown
<!-- External -->
[Link Text](https://example.com)

<!-- Internal (relative) -->
[Other File](../path/to/file.md)

<!-- Sections -->
[Jump to Section](#section-heading)
```

## Questions?

- **Check existing content:** Look at similar files for examples
- **Read documentation:** AGENTS.md for technical details
- **Open an issue:** Ask questions on GitHub Issues
- **Start a discussion:** Use GitHub Discussions

## Code of Conduct

- Be respectful and constructive
- Welcome newcomers
- Focus on the content, not the person
- Assume good intentions
- Follow the project's values

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for helping make prompt-hub better! 🎉
