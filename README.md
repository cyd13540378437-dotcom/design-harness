# Codex Design Harness

Codex Design Harness is a human-in-the-loop design engineering protocol for Codex. It turns important UI/UX work into recoverable, auditable Work Items with explicit user approval gates, and it preserves approved visual decisions in a project-level `VISUAL_DESIGN.md`.

v0.1.0-alpha stays deliberately manual and document-based. It includes a Skill, a narrow state Steward Agent, templates, visual reference packs, examples, and manual evaluation scenarios. It does not include an installer, CLI, hook, plugin package, cloud service, or runtime dependency.

## Core Model

```text
Project AGENTS.md
        ↓
design-engineering Skill
        ↓
design_state_steward Agent
        ↓
Work Item STATE.md
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
- Gates are points where Codex must wait for user approval.
- `completed + sealed` is read-only history; related follow-up work must create a Successor.

See [README.zh-CN.md](README.zh-CN.md) for the full Chinese guide and [docs/architecture.md](docs/architecture.md) for system structure.

## State Resolution

`design_state_steward` can return only five binding decisions:

- `CREATE`: create a new independent Work Item.
- `RESUME`: continue an unsealed active or paused Work Item.
- `SUCCESSOR`: create a new Work Item that references a sealed predecessor.
- `NO_STATE`: skip durable state for read-only or tiny one-off work.
- `AMBIGUOUS`: stop and ask the user to choose among candidates.

## Visual Workflow

Full Mode uses concrete visual artifacts instead of requiring abstract product-personality forms:

```text
Visual Seed
→ Reference Images / Reference Packs
→ Reference Analysis
→ Palette Proposal
→ Palette Confirmation
→ Design Exclusions
→ Exclusions Confirmation
→ Visual Prototype
```

Palette confirmation and design-exclusion confirmation are sub-checkpoints under `visual-direction-approval`; they are not new Gate enum values. `palette-selection` must present at least three candidate palette boards with comparable mini UI samples and contrast/readability notes. The user may choose a candidate or provide a custom color direction; either way, the state records the original user input, final palette, source, and reason. The state body records `palette-selection` and `design-exclusions` as visual substeps.

Users may provide images in `docs/design/reference-images/`. When they have no references, the Skill can use the built-in self-made packs in `skills/design-engineering/assets/visual-reference-packs/`.

## Workflow

`design-engineering` orchestrates the design process. It must explicitly call `design_state_steward` before stateful design work, before each Gate checkpoint, after Gate replies, before task switches, before closure review, and before sealing.

Full Mode uses:

1. `visual-direction-approval`, including palette and design-exclusion substeps
2. `prototype-approval`
3. `interaction-decision`, only for high-impact UX ambiguity
4. `completion-approval`

Lightweight Mode may skip the full visual flow for local changes, but it still reads `VISUAL_DESIGN.md`. Delegated Mode lets Codex handle ordinary details, while final sealing still requires explicit user approval.

## Manual Install

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

5. Start a new Codex session and run:

   ```text
   使用 $design-engineering 检查项目上下文，不要修改文件。
   ```

   Expected result: `NO_STATE`, with no Work Item directory created.

## Example

[examples/idea-storm-lab](examples/idea-storm-lab/) demonstrates the three PRD requests:

- “检查项目上下文” returns `NO_STATE`.
- “优化前端样式” creates and seals `DE-001` after visual seed, reference analysis, palette confirmation, design-exclusion confirmation, visual prototype, implementation, QA, and `VISUAL_DESIGN.md` update.
- “统一内容模块问题长度换行” creates successor `DE-002`, references sealed `DE-001`, reads `VISUAL_DESIGN.md`, and waits at `completion-approval`.

## Evaluation

Manual Given / When / Then scenarios live in [evals/scenarios](evals/scenarios/). They cover context checks, create, resume, successor, parallel Work Items, ambiguous binding, close-and-seal, the new visual workflow, avoiding product-personality taxonomy, and `VISUAL_DESIGN.md` creation.

## Limits

- No installer, plugin package, marketplace metadata, hook, CLI, `statectl`, cloud service, or external runtime dependency.
- No deterministic schema validator or automatic index generator.
- No multi-user write lock.
- No automatic web scraping or bundled third-party product screenshots.
- Browser QA is recommended, but v0.1 does not require a specific browser tool.

## License

MIT. See [LICENSE](LICENSE).
