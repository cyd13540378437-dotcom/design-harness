# Runtime Adapter Readiness Audit — Product Business Modeling v0.2.2

## Conclusion

The package is runtime-aware when all checks below pass.

## Checks

- [x] Core remains Agent-neutral.
- [x] Shared Agent Skill Facade exists.
- [x] Runtime Adapter Resolution Protocol exists.
- [x] Adapter Registry exists.
- [x] Codex install profile exists.
- [x] Claude Code install profile exists.
- [x] Cursor install profile exists.
- [x] Generic Agent profile exists.
- [x] Multi-runtime behavior is defined.
- [x] Runtime ambiguity requires user confirmation or explicit multi-runtime selection.
- [x] Project knowledge assets remain under `docs/product/**`.
- [x] No CLI / hook / plugin / installer / external dependency is introduced.
- [x] Existing UX / Design Engineering boundaries remain protected.

## Required hard rule for future clusters

Every Agent-neutral Core must ship with:

```text
Core
+ Shared Agent Skill Facade
+ Runtime-specific Adapters
+ Runtime Adapter Resolution Protocol
+ Project Knowledge Assets
+ Runtime readiness evals
```

A package that only includes Core and project templates is not runnable. A package that only includes one runtime adapter is not truly Agent-neutral.

## Neutral template hard check

- [x] `templates/project/` does not contain runtime-specific `.agents/`, `.codex/`, `.claude/`, or `.cursor/` directories by default.
- [x] Runtime-specific files live under `templates/project/runtime-overlays/<runtime>/` until Runtime Adapter Resolver selects a profile.
- [x] `templates/project/.designharnessagent/runtime-selection.template.yml` records unresolved runtime state without selecting a tool.

## Neutral template hard check

- [x] `templates/project/` does not contain runtime-specific `.agents/`, `.codex/`, `.claude/`, or `.cursor/` directories by default.
- [x] Runtime-specific files live under `templates/project/runtime-overlays/<runtime>/` until Runtime Adapter Resolver selects a profile.
- [x] Runtime selection metadata records unresolved runtime state without selecting a tool.
