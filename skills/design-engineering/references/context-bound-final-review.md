# Context-bound Final Review

Run Context-bound Final Review after QA and before `completion-review`.

Recommended sequence:

```text
qa -> context-bound final review -> completion-review -> completion-approval -> completed + sealed
```

This does not add a new Gate. Final closure still uses `completion-approval`.

## Required Inputs

- Current `STATE.md`.
- Design Contract.
- Review Lens.
- Acceptance criteria.
- Approved Gate decisions.
- `REFERENCE_SELECTION.md` summary.
- Approved Color Direction summary.
- Relevant `docs/design/project-memory/` baselines.
- Implementation, prototype, or product design artifacts.
- Browser, screenshot, command, or manual QA evidence.

## Output

Create:

```text
docs/design/work-items/<event-id-slug>/review.md
```

Use this structure:

```markdown
# Context-bound Final Review

## Review Inputs
## Design Contract Check
## Review Lens Check
## Approved Decisions Consistency
## Reference / Color Consistency
## UX State Coverage
## Responsive / Accessibility Evidence
## Deviations
## Required Fixes Before Completion
## Completion Recommendation
```

## Prohibited

- Do not provide a generic aesthetic audit detached from the Work Item.
- Do not override approved user decisions without marking a deviation.
- Do not modify or reinterpret a sealed predecessor.
- Do not claim browser or visual QA evidence that was not actually collected.
- Do not treat a checklist as a separate aesthetic judge.

