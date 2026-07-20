# Entry Mode Reference

## direct_modeling

User explicitly asks to create, update, or explain business model assets.

Minimum outputs:

- `MODELING_CONSUMPTION.md`
- `MODELING_OUTPUT.md`
- affected source-of-truth assets when safe
- `DECISION_NOTES.md` when human decisions are needed

## passive_trigger

A `model-triggers/MT-xxx.md` file or equivalent request indicates an upstream change, downstream gap, or cross-cluster conflict.

Minimum outputs:

- bound BM Work Item
- `MODEL_IMPACT_REPORT.md`
- trigger resolution update when done
- downstream view recompilation if model changes

## project_extraction

Extract candidate business model knowledge from existing project evidence. Results are provisional unless confirmed.

Minimum outputs:

- `MODEL_EXTRACTION_REPORT.md`
- `SOURCE_EVIDENCE.md`
- provisional model candidates

## greenfield_modeling

Build a provisional initial model from a vague idea or early product concept.

Minimum outputs:

- provisional business dictionary
- provisional schema view
- assumptions and questions
- high-impact decision requests as needed

## consistency_validation

Check business model assets for internal consistency and boundary violations.

Minimum outputs:

- `MODEL_CONSISTENCY_REPORT.md`
- list of gaps, conflicts, stale downstream views, and recommended fixes

## downstream_compilation

Compile the core model into downstream views for product expression, requirements, database, backend, frontend, QA, or UX.

Minimum outputs:

- updated `downstream-views/*`
- report any core model gaps found during compilation
