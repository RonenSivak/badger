---
name: generating-docs
description: "Generate markdown documentation that adapts to existing project patterns. Use when creating documentation, adding docs for new features, or when user asks to document code/APIs/components."
---

# Generating Docs

Generate markdown documentation that automatically adapts to existing project documentation patterns.

## Quick Start

```
/generating-docs <what to document>
```

## Workflow

1. **Discover** → Find existing docs (`README.md`, `docs/`, `*.md`)
2. **Analyze** → Extract patterns → `DOC-PATTERNS.md`
3. **Plan** → Map what to create → `DOC-PLAN.md`
4. **Generate** → Create markdown following patterns
5. **Verify** → Check consistency, links → `VERIFICATION.md`

## Workflow Checklist

```
- [ ] Discovered existing documentation
- [ ] Analyzed patterns (or using defaults)
- [ ] Planned documentation structure
- [ ] Generated markdown files
- [ ] Verified consistency and links
```

## Discovery Locations

Search for existing docs in order:
1. `README.md` (root)
2. `docs/` or `documentation/` directory
3. `*.md` files in root
4. Package-level README files (monorepos)

## Pattern Extraction

When existing docs found, extract:

| Pattern | Example |
|---------|---------|
| Section structure | Overview → Usage → API → Contributing |
| Heading levels | `#` vs `##` for main sections |
| Code block style | ` ```typescript ` vs ` ```ts ` |
| Badge usage | CI status, version badges |
| Table style | Props tables, API tables |
| Admonitions | `> **Note:**` vs `:::note` |

See [generating-docs-patterns guide](/.cursor/guides/generating-docs-patterns.md) for details.

## Adaptive Behavior

| Scenario | Behavior |
|----------|----------|
| Existing docs found | Copy structure, style, conventions |
| No docs found | Use standard defaults |

## Quality Gates

- [ ] New docs follow existing structure (if any)
- [ ] Code examples are valid
- [ ] Internal links resolve
- [ ] Consistent heading hierarchy

## Examples

**Document a module:**
```
/generating-docs Document the authentication module in src/auth/
```

**Create README:**
```
/generating-docs Create a README for this package
```

**Document API:**
```
/generating-docs Document the REST API endpoints
```

## Files Generated

```
.cursor/generating-docs/<task>/
├── DOC-PATTERNS.md    # Extracted patterns
├── DOC-PLAN.md        # Documentation plan
└── VERIFICATION.md    # Pass/fail report
```

## Fallback Defaults

When no existing docs:
- Structure: Overview, Installation, Usage, API, Contributing, License
- Headings: `##` for main sections
- Code blocks: Language-tagged
- Links: Relative for internal
