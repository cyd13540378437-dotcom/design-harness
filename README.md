# Codex Design Harness

Codex Design Harness is a human-in-the-loop design engineering protocol for Codex. It turns important UI/UX work into recoverable, auditable Work Items with explicit user approval gates, and it preserves approved visual decisions in a project-level `VISUAL_DESIGN.md`.

v0.1.3-alpha is an incremental update on top of the v0.1.2-alpha Color Card Registry revision. It stays deliberately document-based, and adds Project Lifecycle Memory & Artifacts: Lifecycle Event IDs, `project-memory/`, `outputs/`, Context-bound Final Review, Fast Profile, and `PD` product-design events. It includes a small file-copy compatibility helper for Codex, Claude Code, and Cursor; it does not include a CLI product, hook, plugin package, cloud service, or runtime dependency.

v0.2.2 adds the runtime-aware Product Business Modeling Core. It keeps the business semantics layer agent-neutral under `core/product-design/business-modeling/`, adds a shared Agent Skill Facade, Codex / Claude Code / Cursor / generic / multi-runtime adapter resolution, and keeps project knowledge assets under `docs/product/**`. It remains document-based: no CLI, hook, plugin package, installer, migration tool, API generator, or external runtime dependency.

v0.1.1 adds the standalone Product Business Analysis Core. It turns ambiguous business situations into reviewable Decision Cases with preserved original input, Analysis Model Cards, counterfactual analysis, Decision Assurance, choice-style conclusions, human decision records, and Decision Network memory. It is independent from Business Modeling and every other sibling capability: no cross-capability triggers, no downstream views, no shared Work Item directory, and no external runtime dependency.

## Core Model

```text
Project AGENTS.md
        ↓
design-engineering Skill
        ↓
design_state_steward Agent
        ↓
Reference Library + Surface Resolution
        ↓
Work Item STATE.md
        ↓
Work Item REFERENCE_SELECTION.md
        ↓
Project Memory + Outputs
        ↓
Human Gates, visual workflow, implementation, QA, seal
        ↓
VISUAL_DESIGN.md
```

- A Thread is a temporary Codex conversation, not the durable task identity.
- A Work Item is an independently reviewable product or design task.
- `STATE.md` is the authoritative state snapshot for one Work Item.
- `WORK_ITEMS.md` is a navigation index; `STATE.md` wins on conflict.
- `VISUAL_DESIGN.md` is the long-lived project visual baseline.
- `reference-library/` is the long-lived product visual reference layer.
- `REFERENCE_SELECTION.md` records how one Work Item consumed the reference library and color-card registry.
- `project-memory/` stores durable cross-Work Item business, product, UX, visual, engineering, and decision context.
- `outputs/` tracks current confirmed deliverables and archived Lifecycle Event snapshots.
- Color Card Registry is the checked color-reference layer under `reference-library/assets/color-cards/`.
- New Work Items prefer Lifecycle Event IDs such as `2026-07-06-1530-UX-001`; legacy `DE-xxx` remains valid.
- Gates are points where Codex must wait for user approval.
- `completed + sealed` is read-only history; related follow-up work must create a Successor.

See [README.zh-CN.md](README.zh-CN.md) for the full Chinese guide and [docs/architecture.md](docs/architecture.md) for system structure.


## Product Business Modeling Core

`product-business-modeling` v0.2.2 models product business semantics separately from UI/UX execution. Its Core lives under `core/product-design/business-modeling/`; the shared facade lives under `adapters/shared/agent-skill-facade/product-business-modeling/`; the repo-level callable Skill lives under `skills/product-business-modeling/`. Start with [AGENT_START_HERE.md](AGENT_START_HERE.md), [CODEX_START_HERE.md](CODEX_START_HERE.md), and [docs/PRD.product-business-modeling-runtime-adapter-resolution-v0.2.2.md](docs/PRD.product-business-modeling-runtime-adapter-resolution-v0.2.2.md).

Before preparing a target project, apply Runtime Adapter Resolution with `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` and `adapters/adapter-registry.yml`. Select exactly one runtime profile by default: `codex`, `claude-code`, `cursor`, or `generic-agent`. Use `multi-runtime` only when the user explicitly asks for multiple tools. If runtime signals conflict, stop and ask.

The neutral project template contains only portable project assets and runtime-selection metadata. Runtime-specific files stay in `templates/project/runtime-overlays/<runtime>/` until a profile is selected; the default template must not include root `.agents/`, `.codex/`, `.claude/`, or `.cursor/` directories.

The business model source of truth is `docs/product/business-modeling/`. Passive triggers use `docs/product/model-triggers/MT-xxx.md`; task state lives in `docs/product/work-items/BM-xxx/`. Core model files use business attributes, not database fields. `schema-view.json` is intentionally limited to objects, domains, categories, business attributes, and example content.

Business Modeling can inform UX through derived downstream views only: `ux-design-engineering-view.md` and `ux-business-model-context.md/yml`. Existing `docs/design/`, Reference Library, Color Card Registry, `REFERENCE_SELECTION.md`, and sealed UX `STATE.md` files remain owned by Design Engineering.

## Product Business Analysis Core

`product-business-analysis` v0.1.1 is a standalone decision-support capability. Its Core lives under `core/product-design/business-analysis/`, runtime adapter fragments live under `adapters/codex/product-business-analysis/`, `adapters/claude-code/product-business-analysis/`, and `adapters/cursor/product-business-analysis/`, and project templates live under `templates/project/docs/product/business-analysis/`. Start with [docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.1-complete.md](docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.1-complete.md) and [docs/PRD.product-business-analysis-v0.1.1.md](docs/PRD.product-business-analysis-v0.1.1.md).

The Business Analysis source of truth is `docs/product/business-analysis/`. Decision Cases are authoritative only in `decision-cases/BA-DC-xxx.md`; BA Work Items live under `work-items/BA-xxx/` and link to Cases without copying `DECISION_CASE.md`. Decision Network and Evidence Ledger use YML as machine authority and Markdown as human-readable views.

Business Analysis intentionally uses five operational domains rather than the Business Modeling six-domain shape. Passive Trigger, cross-capability impact propagation, downstream view compilation, shared `docs/product/work-items/`, CLI, hooks, plugins, installers, and automatic D2/D3 human decisions are out of scope.

## Agent Compatibility

Use the full `design-harness` repository for installation. The lightweight `designharness` rules folder is only a routing-rule package and does not contain the full skill, reference library, color-card registry, or templates.

Compatibility helper:

```bash
./scripts/install-agent-compat.sh codex /path/to/project
./scripts/install-agent-compat.sh claude /path/to/project
./scripts/install-agent-compat.sh cursor /path/to/project
```

The helper copies the complete skill directory, installs the correct project entry point for the selected agent, and verifies that the nested `docs/design/` template files are present. See [docs/agent-compatibility.md](docs/agent-compatibility.md).

To inspect an existing install and see exactly which files are missing, run:

```bash
./scripts/install-agent-compat.sh doctor /path/to/project
```

## State Resolution

`design_state_steward` can return only five binding decisions:

- `CREATE`: create a new independent Work Item.
- `RESUME`: continue an unsealed active or paused Work Item.
- `SUCCESSOR`: create a new Work Item that references a sealed predecessor.
- `NO_STATE`: skip durable state for read-only or tiny one-off work.
- `AMBIGUOUS`: stop and ask the user to choose among candidates.


## Color Card Registry

When a project has:

```text
docs/design/reference-library/assets/color-cards/palette-index.yml
```

Codex must treat `palette-index.yml` as the source of truth. A valid color card is not just an image; it is:

```text
palette-index.yml entry + image + palette + annotation
```

The centralized `images/`, `palettes/`, and `annotations/` directories remain intentional for browsing. Do not convert them into per-card folders. User-facing palette confirmation may use only cards that are `status: ready`, `gate_preview: true`, and pass image / palette / annotation integrity checks.

Palette confirmation should show large color-card visuals and business semantics, not raw HEX/RGB values or tiny swatches as the primary decision surface. Selected color-card use belongs in the Work Item `REFERENCE_SELECTION.md`; `STATE.md` keeps only a compact summary and link.

## Visual Workflow

Full Mode uses concrete visual artifacts and target-surface reference selection instead of requiring abstract product-personality forms:

```text
Visual Seed
→ Surface Resolution
→ Reference Library / Color Card Registry / Reference Images / Reference Packs
→ Reference Analysis
→ Palette Proposal
→ Palette Confirmation
→ Typography Proposal
→ Typography Confirmation
→ Design Exclusions
→ Exclusions Confirmation
→ Visual Prototype
```

Palette confirmation, typography confirmation, and design-exclusion confirmation are sub-checkpoints under `visual-direction-approval`; they are not new Gate enum values. `palette-selection` must present at least three candidate palette boards with comparable mini UI samples and contrast/readability notes. `typography-selection` records font family, fallback stack, type scale, line height, weight, responsive behavior, usage mapping, licensing/loading notes, and readability risks through comparable UI samples. The user may choose a candidate or provide a custom direction; either way, the state records the original user input, final system, source, and reason. The state body records `palette-selection`, `typography-selection`, and `design-exclusions` as visual substeps.

Before reference retrieval, Codex records the target surface: `web-app`, `mobile-app`, `responsive-web`, `desktop-app`, `tablet`, or `multi-surface`. If `docs/design/reference-library/` exists, Codex filters it by surface, page type, task type, density, complexity, user maturity, industry, and visual tags. The task-level result goes into `docs/design/work-items/<ID-slug>/REFERENCE_SELECTION.md`; `STATE.md` keeps only a summary and link.

Users may provide images in `docs/design/reference-images/`. When they have no references, the Skill can also use the built-in self-made packs in `skills/design-engineering/assets/visual-reference-packs/`.

## Workflow

`design-engineering` orchestrates the design process. It must explicitly call `design_state_steward` before stateful design work, before each Gate checkpoint, after Gate replies, before task switches, before closure review, and before sealing.

Full Mode uses:

1. `visual-direction-approval`, including palette, typography, and design-exclusion substeps
2. `prototype-approval`
3. `interaction-decision`, only for high-impact UX ambiguity
4. `completion-approval`

Lightweight Mode may skip the full visual flow for local changes, but it still reads `VISUAL_DESIGN.md`. Fast Profile is the accelerated lightweight form, recorded as `mode: "lightweight"` and `execution_profile: "fast"`; it still requires Design Contract, Review Lens, evidence, and `completion-approval`. Delegated Mode lets Codex handle ordinary details, while final sealing still requires explicit user approval.

Before `completion-review`, v0.1.3 requires Context-bound Final Review. The review is based on the current `STATE.md`, Design Contract, Review Lens, approved decisions, reference/color summaries, Project Memory, and real QA evidence; it is not a generic aesthetic audit.

`domain: PD` supports product-design events such as membership systems, pricing models, permissions, feature boundaries, PRDs, and decision maps. Later `domain: UX` events can list sealed PD events in `predecessors` and inherit product constraints read-only.

## Manual Install

For the safer cross-agent path, prefer [Agent Compatibility](#agent-compatibility). Manual install remains available for Codex-only use.

1. Copy [skills/design-engineering](skills/design-engineering/) to:

   ```text
   ~/.agents/skills/design-engineering/
   ```

2. Copy [agents/design-state-steward.toml](agents/design-state-steward.toml) into the target project:

   ```text
   .codex/agents/design-state-steward.toml
   ```

3. Merge [templates/project/AGENTS.fragment.md](templates/project/AGENTS.fragment.md) into the target project `AGENTS.md`. Do not overwrite existing user rules.

4. Copy [templates/project/docs/design](templates/project/docs/design/) into the target project.

   This includes `reference-library/`, Color Card Registry placeholders, `project-memory/`, `outputs/`, and the Work Item `REFERENCE_SELECTION.template.md`.

5. Start a new Codex session and run:

   ```text
   使用 $design-engineering 检查项目上下文，不要修改文件。
   ```

   Expected result: `NO_STATE`, with no Work Item directory created.

## Example

[examples/idea-storm-lab](examples/idea-storm-lab/) demonstrates the three PRD requests:

- “检查项目上下文” returns `NO_STATE`.
- “优化前端样式” creates and seals `DE-001` after visual seed, reference analysis, palette confirmation, typography confirmation, design-exclusion confirmation, visual prototype, implementation, QA, and `VISUAL_DESIGN.md` update.
- “统一内容模块问题长度换行” creates successor `DE-002`, references sealed `DE-001`, reads `VISUAL_DESIGN.md`, records task-level reference use in `REFERENCE_SELECTION.md`, and waits at `completion-approval`.

[examples/lifecycle-memory-lab](examples/lifecycle-memory-lab/) demonstrates v0.1.3 Lifecycle Event IDs, Project Memory updates, outputs archive/current, Context-bound Final Review, a `domain: PD` membership-system event, and a later UX event inheriting the sealed PD predecessor.

## Evaluation

Manual Given / When / Then scenarios live in [evals/scenarios](evals/scenarios/) for Design Engineering, [evals/product-business-modeling](evals/product-business-modeling/) for Business Modeling, and [evals/product-business-analysis](evals/product-business-analysis/) for Business Analysis. They cover context checks, create, resume, successor, parallel Work Items, ambiguous binding, close-and-seal, the visual workflow, Reference Library and Color Card Registry behavior, lifecycle memory, business modeling source-of-truth boundaries, passive triggers, Human Decision Control Plane, schema-view limits, UX Context Pack consumption, Business Analysis Decision Case boundaries, Analysis Model Card usage, assurance checks, and sealed-state immutability.

## Limits

- No plugin package, marketplace metadata, hook, CLI product, `statectl`, cloud service, or external runtime dependency.
- No deterministic schema validator or automatic index generator.
- No Project Adoption / Adoption Baseline flow for taking over long-lived existing projects; v0.1.3 assumes project memory starts when the harness is installed.
- No multi-user write lock.
- No automatic web scraping or bundled third-party product screenshots.
- No Work Item-specific `reference-library/reference-packs/`; task-level reference choices belong in `REFERENCE_SELECTION.md`.
- No `docs/design/product-work-items/`; UX and PD events both live under `docs/design/work-items/`.
- No root-level `outputs/` directory by default; design deliverables live under `docs/design/outputs/`.
- No automatic ready color-card generation; complete color-card knowledge requires user-provided images or explicit visual descriptions.
- Browser QA is recommended, but v0.1 does not require a specific browser tool.
- Product Business Modeling v0.2.2 is runtime-aware but document-based: no CLI, hook, plugin package, installer, external runtime dependency, automatic database migration, or API generation.
- Product Business Analysis v0.1.1 is standalone and document-based: no cross-capability triggers, downstream views, shared Work Item directory, CLI, hook, plugin package, installer, external runtime dependency, or automatic D2/D3 human decision.

## License

MIT. See [LICENSE](LICENSE).
