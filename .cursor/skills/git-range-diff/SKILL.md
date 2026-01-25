# SKILL: Verifying split equivalence with git range-diff

## Use case
You rewrote history (split/reworded commits) but want to ensure the *patchset* still matches what you intended.

## Typical patterns
Compare old series vs new series (examples depend on your ranges):
- `git range-diff <BASE>..<old-branch> <BASE>..<new-branch>`

Interpretation:
- shows which commits correspond and what changed between patch versions
- use it when you suspect you lost or accidentally added changes
