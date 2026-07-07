# 25. No Sealed State Mutation for Memory

## Given

A sealed legacy Work Item lacks `event_id` or Project Memory update fields.

## When

Codex performs v0.1.3 lifecycle-memory work in the project.

## Then

- Codex does not edit the sealed `STATE.md` to add missing fields.
- Codex may create a Successor or append a new `DECISIONS.md` entry that references the sealed state.
- The state-resolution enum remains `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`.
- Historical approved decisions are not silently rewritten.

