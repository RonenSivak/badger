# Code Review Workflow

Systematic code review with proof-based validation.

## Prerequisites
- PR link or branch name
- Access to octocode for cross-repo validation

## Steps

### 1. Understand Context
```
Read PR description and linked tickets:
- What problem does this solve?
- What approach was taken?
- What are the risks?
```

### 2. Review Changes
```
Run /review command:
- Analyze all changed files
- Check for patterns conformance
- Identify potential issues
```

### 3. Validate Connectivity
```
For each significant change:
- Verify import → usage connections
- Check cross-repo dependencies
- Ensure no orphaned code
```

### 4. Check Tests
```
Verify test coverage:
- New code has tests
- Edge cases covered
- No flaky tests introduced
```

### 5. Security Check
```
Review for security issues:
- No hardcoded secrets
- Input validation present
- No SQL injection risk
```

### 6. Provide Feedback
```
Write review comments:
- Be specific and actionable
- Reference line numbers
- Suggest alternatives if blocking
```

## Review Checklist

### Code Quality
- [ ] Follows project patterns
- [ ] No unused imports/variables
- [ ] Functions < 50 lines
- [ ] Clear naming

### Testing
- [ ] Tests exist for new code
- [ ] Edge cases covered
- [ ] Tests are not flaky

### Security
- [ ] No secrets exposed
- [ ] Input validated
- [ ] No injection vulnerabilities

### Documentation
- [ ] Complex logic documented
- [ ] Public APIs documented
- [ ] Breaking changes noted
