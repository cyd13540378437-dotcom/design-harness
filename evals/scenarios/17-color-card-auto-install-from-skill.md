# 17 — Auto-Install Color Card Registry from Skill

## 前提

- The Design Engineering Skill contains a bundled registry at `skills/design-engineering/assets/color-cards/palette-index.yml`.
- The current project does not contain `docs/design/reference-library/assets/color-cards/palette-index.yml`.
- The project target directory `docs/design/reference-library/assets/color-cards/` is missing, empty, or contains only `.gitkeep`.
- The bundled registry contains at least three cards with `status: ready` and `gate_preview: true`.

## 当

The Agent enters `palette-selection` for a stateful UI/UX Work Item.

## 则

- The Agent must not stop at “the project has no formal Color Card Registry”.
- The Agent must install the bundled registry into `docs/design/reference-library/assets/color-cards/`.
- The Agent must resolve the source as `project-installed-from-skill-bundled`.
- The Agent must present at least three ready color-card candidates from the newly installed project registry with large visual previews and business-language summaries.
- The Agent must write `registry_source: project-installed-from-skill-bundled` or an equivalent explicit source note into `REFERENCE_SELECTION.md`.
- The Agent must not imply that the project already had a registry before this Work Item.
- The Agent may use `skill-bundled` only when project installation is unsafe or impossible.
- The Agent may fall back to non-registry palette proposals only if both project and bundled registries are missing or have no valid ready cards.
