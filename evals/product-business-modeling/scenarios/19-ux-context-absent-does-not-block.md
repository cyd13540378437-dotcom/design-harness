# 19. Missing UX Context Pack Does Not Block Design Startup

## Given

A project has Design Engineering Harness installed, but Business Modeling has not yet compiled:

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

or the context pack is still draft / partial.

## When

A UX / Design Engineering Work Item starts.

## Then

- Design startup is not blocked;
- The UX state summary may record `business_model_context: absent | partial`;
- UX must not fabricate confirmed business model semantics;
- High-impact model assumptions remain provisional;
- If a missing object/action/state/rule/permission later affects implementation or seal, create or recommend a `downstream_gap` Model Trigger.
