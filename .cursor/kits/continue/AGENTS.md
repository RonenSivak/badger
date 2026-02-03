# continue Kit - Agent Instructions

IMPORTANT: Prefer retrieval-led reasoning. Load session artifacts before resuming work.

## Commands
```bash
/continue                    # Orchestrator
/continue.clarify           # Identify session to resume
/continue.load              # Load memory dump artifacts
/continue.verify            # Verify context is complete
/continue.resume            # Continue from last checkpoint
/continue.publish           # Summary of resumed work
```

## Session Artifacts
```
.cursor/sessions/<session-id>/
├── MEMORY-DUMP.md          # Full context snapshot
├── TODO-STATE.md           # Todo list state
├── CHECKPOINT.md           # Last known good state
└── ARTIFACTS/              # Generated files
```

## Resume Protocol

1. **Load** — Read MEMORY-DUMP.md completely
2. **Verify** — Confirm all referenced files exist
3. **Restore** — Set todo state from TODO-STATE.md
4. **Continue** — Resume from CHECKPOINT.md

## Boundaries

### ✅ Always
- Load full context before resuming
- Verify file references are valid
- Maintain session artifact integrity

### ⚠️ Ask First
- Resuming very old sessions
- Sessions with missing artifacts
- Conflicting file states

### 🚫 Never
- Resume without loading context
- Overwrite existing work
- Skip verification step

## Verification
- [ ] MEMORY-DUMP.md loaded
- [ ] All referenced files exist
- [ ] Todo state restored
- [ ] No conflicts with current state
