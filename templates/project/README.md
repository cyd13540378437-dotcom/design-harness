# Product Business Modeling Project Template v0.2.3

This default template contains portable project knowledge assets and runtime-selection metadata.

The Business Modeling module's default user-facing file is:

```text
docs/product/business-modeling/BUSINESS_MODEL_OVERVIEW.md
```

Other module delivery exports in this template:

```text
docs/product/business-analysis/BUSINESS_DECISION_OVERVIEW.md
docs/design/DESIGN_OVERVIEW.md
```

Future project-level delivery should consume module exports instead of hard-coding internal Work Item files.

Detailed source-of-truth, Work Item, evidence and downstream files remain available for maintainers and agents under `docs/product/**`.

Portable assets:

```text
docs/product/**
.designharness/adapter-resolution.yml
.designharnessagent/runtime-selection.template.yml
```

Runtime-specific files are not installed by default. Apply exactly one selected overlay from:

```text
templates/project/runtime-overlays/codex/
templates/project/runtime-overlays/claude-code/
templates/project/runtime-overlays/cursor/
```

Apply multiple overlays only when the user explicitly requests multi-runtime support.
