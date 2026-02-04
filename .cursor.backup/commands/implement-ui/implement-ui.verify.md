---
description: Verify UI implementation (visual comparison or requirements checklist)
globs:
alwaysApply: false
---

# /implement-ui.verify — Verification

Verify the implementation meets requirements.

## Prerequisites

- Implementation complete
- UI-SPEC exists with acceptance criteria

---

## Figma Mode Verification

### Step 1: Check Browser MCP Availability

Check if `cursor-ide-browser` MCP is available.

If NOT available:
```
⚠️ cursor-ide-browser MCP not found.

To enable visual verification, install it:
1. Open Cursor Settings → MCP
2. Add cursor-ide-browser server
3. Restart Cursor

Falling back to manual checklist verification.
```

### Step 2: Start Dev Server (if needed)

Ensure the component is viewable at a URL.

### Step 3: Take Screenshot

Using cursor-ide-browser:

1. `browser_navigate` to component URL
2. `browser_lock` the tab
3. `browser_snapshot` to capture
4. `browser_unlock` when done

### Step 4: Compare to Figma

Open Figma URL and visually compare:

- [ ] Layout matches
- [ ] Spacing matches
- [ ] Colors match (within WDS theme)
- [ ] Typography matches
- [ ] Interactive states correct

### Step 5: Document Differences

If differences found:
- Screenshot the difference
- Note what needs fixing
- Return to implement phase

---

## Semantic Mode Verification

### Step 1: Requirements Checklist

Go through each requirement from UI-SPEC:

- [ ] Requirement 1: <status>
- [ ] Requirement 2: <status>
- ...

### Step 2: Acceptance Criteria

Check each acceptance criterion:

- [ ] Criterion 1: <pass/fail>
- [ ] Criterion 2: <pass/fail>
- ...

---

## Technical Verification (Both Modes)

- [ ] No TypeScript errors (`tsc --noEmit`)
- [ ] No lint errors
- [ ] Component renders without runtime errors
- [ ] All WDS components used correctly (per dos/don'ts)

---

## Output: VERIFICATION-REPORT

Create `.cursor/implement-ui/<task>/VERIFICATION-REPORT.md`:

```markdown
# Verification Report: <task-name>

## Mode
<Figma | Semantic>

## Visual/Requirements Check
| Item | Status | Notes |
|------|--------|-------|
| ... | ✅/❌ | ... |

## Technical Check
- [ ] TypeScript: <pass/fail>
- [ ] Lint: <pass/fail>
- [ ] Renders: <pass/fail>

## Overall
<PASS | FAIL>

## Issues (if FAIL)
1. <issue 1>
2. <issue 2>
```

---

## Next Steps

If **PASS**: Say "Verification passed. Run `/implement-ui.publish`."

If **FAIL**: Say "Verification failed. Fix issues and re-run `/implement-ui.verify`."
