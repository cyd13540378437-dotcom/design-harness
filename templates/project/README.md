# Product Business Modeling Project Template

This default template contains portable project knowledge assets and runtime-selection metadata.

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
