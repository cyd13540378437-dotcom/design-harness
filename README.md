# Codex Design Harness

Codex Design Harness is a human-in-the-loop design engineering protocol for Codex. It turns important UI/UX work into recoverable, auditable Work Items with explicit user approval gates, and it preserves approved visual decisions in a project-level `VISUAL_DESIGN.md`.

v0.1.2-alpha is an incremental update on top of the v0.1.1-alpha Reference Library revision. It stays deliberately document-based, and upgrades `assets/color-cards/` into a Color Card Registry so agents can use complete visual color-card objects during palette confirmation. It includes a small file-copy compatibility helper for Codex, Claude Code, and Cursor; it does not include a CLI product, hook, plugin package, cloud service, or runtime dependency.

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
- Color Card Registry is the checked color-reference layer under `reference-library/assets/color-cards/`.
- Gates are points where Codex must wait for user approval.
- `completed + sealed` is read-only history; related follow-up work must create a Successor.

See [README.zh-CN.md](README.zh-CN.md) for the full Chinese guide and [docs/architecture.md](docs/architecture.md) for system structure.

## Agent Compatibility

Use the full `design-harness` repository for installation. The lightweight `designharness` rules folder is only a routing-rule package and does not contain the full skill, reference library, color-card registry, or templates.

Compatibility helper:

```bash
./scripts/install-agent-compat.sh codex /path/to/project
./scripts/install-agent-compat.sh claude /path/to/project
./scripts/install-agent-compat.sh cursor /path/to/project
```

The helper copies the complete skill directory, installs the correct project entry point for the selected agent, and verifies that the nested `docs/design/` template files are present. See [docs/agent-compatibility.md](docs/agent-compatibility.md).

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

Lightweight Mode may skip the full visual flow for local changes, but it still reads `VISUAL_DESIGN.md`. Delegated Mode lets Codex handle ordinary details, while final sealing still requires explicit user approval.

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

   This includes `reference-library/`, Color Card Registry placeholders, and the Work Item `REFERENCE_SELECTION.template.md`.

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

## Evaluation

Manual Given / When / Then scenarios live in [evals/scenarios](evals/scenarios/). They cover context checks, create, resume, successor, parallel Work Items, ambiguous binding, close-and-seal, the visual workflow, avoiding product-personality taxonomy, `VISUAL_DESIGN.md` creation, Reference Library surface selection, Color Card Registry integrity / ready-only / business-language confirmation, and typography-selection recording.

## Limits

- No plugin package, marketplace metadata, hook, CLI product, `statectl`, cloud service, or external runtime dependency.
- No deterministic schema validator or automatic index generator.
- No multi-user write lock.
- No automatic web scraping or bundled third-party product screenshots.
- No Work Item-specific `reference-library/reference-packs/`; task-level reference choices belong in `REFERENCE_SELECTION.md`.
- No automatic ready color-card generation; complete color-card knowledge requires user-provided images or explicit visual descriptions.
- Browser QA is recommended, but v0.1 does not require a specific browser tool.

## License

MIT. See [LICENSE](LICENSE).
