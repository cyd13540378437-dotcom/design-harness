# 21. Context-bound Final Review

## Given

Implementation or design artifacts and QA evidence are complete for an active Work Item.

## When

Codex prepares to enter `completion-review`.

## Then

- Codex creates `docs/design/work-items/<event-id-slug>/review.md`.
- The review cites `STATE.md`, Design Contract, Review Lens, approved decisions, reference or color summaries, Project Memory, and QA evidence.
- The review lists deviations and required fixes before completion.
- The review is not a generic aesthetic checklist.
- No new Gate enum is introduced.

