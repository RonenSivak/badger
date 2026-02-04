# Documentation Pattern Extraction Guide

Reference for extracting documentation patterns from existing project docs.

## Pattern Categories

### 1. Section Structure

Look at the top-level sections in existing docs:

**Common Patterns:**
```
# Project Name
## Overview / Introduction / About
## Installation / Getting Started / Setup
## Usage / Quick Start / Examples
## API / Reference / Documentation
## Configuration / Options
## Contributing / Development
## License
```

**Extract:** The order and naming of sections.

### 2. Heading Hierarchy

Check how headings are used:

| Style | Example |
|-------|---------|
| `#` for title only | `# Project` then `## Sections` |
| `##` for all sections | No `#` used except title |
| Mixed | `#` for major, `###` for subsections |

### 3. Code Block Style

Look for code block conventions:

```markdown
<!-- Full language name -->
```typescript

<!-- Short form -->
```ts

<!-- With filename -->
```typescript title="example.ts"

<!-- With line numbers -->
```typescript {1-3}
```

### 4. Badge Conventions

Check README header for badges:

```markdown
<!-- Inline badges -->
![CI](url) ![Version](url) ![License](url)

<!-- Table badges -->
| CI | Version | License |
|---|---|---|

<!-- No badges -->
(clean header)
```

### 5. Table Style

Look for table conventions:

**Props/API Tables:**
```markdown
| Prop | Type | Default | Description |
|------|------|---------|-------------|
```

**Feature comparison:**
```markdown
| Feature | Supported |
|---------|-----------|
| X | ✅ |
| Y | ❌ |
```

### 6. Admonition Style

Check how notes/warnings are formatted:

```markdown
<!-- Blockquote style -->
> **Note:** Important information

<!-- Bold prefix -->
**Warning:** Something to watch out for

<!-- Docusaurus/MDX style -->
:::note
Information here
:::

<!-- HTML style -->
<details>
<summary>More info</summary>
Content here
</details>
```

### 7. Link Conventions

Check link patterns:

```markdown
<!-- Relative links -->
[Guide](./docs/guide.md)
[API](../api/README.md)

<!-- Absolute links -->
[Guide](/docs/guide.md)

<!-- Reference-style -->
[Guide][guide-link]
[guide-link]: ./docs/guide.md
```

### 8. List Style

Check list formatting:

```markdown
<!-- Dashes -->
- Item one
- Item two

<!-- Asterisks -->
* Item one
* Item two

<!-- Numbered -->
1. First
2. Second
```

## Pattern Extraction Process

1. **Glob for markdown files:**
   ```
   README.md, docs/**/*.md, *.md
   ```

2. **Read 2-3 representative docs**

3. **For each pattern category:**
   - Note the convention used
   - Mark as "consistent" or "mixed"

4. **Output to DOC-PATTERNS.md:**
   ```markdown
   ## Extracted Patterns

   | Category | Pattern | Confidence |
   |----------|---------|------------|
   | Sections | Overview → Usage → API | High |
   | Headings | ## for main sections | High |
   | Code blocks | ```typescript (full) | Medium |
   | Badges | None | High |
   | Admonitions | > **Note:** style | Medium |
   ```

## Defaults (No Existing Docs)

When no documentation exists:

```markdown
## Default Patterns

| Category | Default |
|----------|---------|
| Sections | Overview, Installation, Usage, API, Contributing |
| Headings | ## for main sections |
| Code blocks | Full language name with tags |
| Badges | None (add if CI exists) |
| Admonitions | > **Note:** blockquote style |
| Links | Relative |
| Lists | Dashes (-) |
```
