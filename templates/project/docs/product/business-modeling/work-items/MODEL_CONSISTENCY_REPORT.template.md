---
schema_version: 1
report_type: model_consistency_report
work_item: BM-000
status: draft
result: not_run
created_at: YYYY-MM-DDTHH:mm:ssZ
updated_at: YYYY-MM-DDTHH:mm:ssZ
---

# Model Consistency Report

## Scope

## Checks Performed

| Check ID | Contract | Result | Notes |
|---|---|---|---|
| C-01 | Canonical Work Item files and locations | pass/fail |  |
| C-02 | Frozen `STATE.md` frontmatter fields | pass/fail |  |
| C-03 | Business dictionary structure and coverage | pass/fail |  |
| C-04 | `schema-view.json` exact shape and five-question boundary | pass/fail |  |
| C-05 | Index registry completeness | pass/fail |  |
| C-06 | Object / domain / category / attribute referential integrity | pass/fail |  |
| C-07 | Relationship endpoints exist | pass/fail |  |
| C-08 | Actions have stable ID, actor, target and effects | pass/fail |  |
| C-09 | State transitions reference existing action and states | pass/fail |  |
| C-10 | One lifecycle belongs to one business object | pass/fail |  |
| C-11 | Rules and permissions bind existing IDs | pass/fail |  |
| C-12 | No data-field misuse in Core assets | pass/fail |  |
| C-13 | Context-dependent values are not intrinsic attributes | pass/fail |  |
| C-14 | Object identity is singular and unambiguous | pass/fail |  |
| C-15 | Downstream views are current and do not own Core truth | pass/fail |  |
| C-16 | `BUSINESS_MODEL_OVERVIEW.md` is current and user-complete | pass/fail |  |

## Passed Checks

## Issues Found

| Issue ID | Severity | Check ID | Asset | Description | Recommended Owner | Trigger Needed |
|---|---|---|---|---|---|---|

Severity:

```text
error   Contract violation or semantic conflict; blocks completion.
warning Important gap or stale view; must be visible in overview.
info    Non-blocking improvement.
```

## Canonical File Protocol Check

`PROPOSED_MODEL.md` and `EVIDENCE_AND_ASSUMPTIONS.md` are legacy aliases. New runs must not generate them; legacy projects may use them only as migration inputs into `MODELING_OUTPUT.md` and `SOURCE_EVIDENCE.md`. Custom artifacts require a distinct, non-overlapping purpose.

## State Schema Check

Runtime adapters must use the exact Core frontmatter fields from `STATE.template.md`. Alternative fields such as `primary_entry_mode`, `awaiting_user`, `gate`, or adapter-owned authority flags must not replace Core fields.

## Data Field Misuse Check

## Schema View Boundary and Shape Check

## Dictionary / Index / Schema Alignment

## Action / State / Rule Alignment

## Lifecycle Object Boundary

A state lifecycle must belong to exactly one business object. Recommendation or decision states must not be inserted into the lifecycle of a responsibility or assignment object merely because one action creates the other.

## Context-dependent Attribute Placement

A value that depends on multiple objects, time, origin, strategy, or evaluation context should be modeled as a relationship attribute, evaluation object, candidate result, or downstream derived value—not as an intrinsic attribute of a single object.

## Object Identity Check

A single object ID must represent one business identity. Combined labels such as `Asset / Facility` require an explicit umbrella concept or a D2 identity decision.

## Downstream View Freshness

## Business Model Overview Freshness

## Human Decisions Required

## Follow-up Triggers

## Result

- Overall: `passed | issues_found`
- Blocking errors:
- Overview may be described as confirmed complete: `yes | no`
