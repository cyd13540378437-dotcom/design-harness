# Codex Design Harness 仓库规则

本仓库定义 v0.1.x 的 Design Engineering Harness。后续修改必须保持 PRD、Skill、Steward Agent、模板、示例、评测和 README 彼此一致。

## 范围

- v0.1 保持手动、文档型交付。
- 不添加安装器、Codex Plugin 包、Marketplace 元数据、Hook、CLI、`statectl`、云服务或外部运行时依赖。
- 不自动下载、OCR、视觉识别或托管第三方截图。
- 不虚构 Codex 不支持的配置字段。
- 第三方 UI 或浏览器 Skill 只能作为可选增强被提及。


## Product Business Modeling Core

本仓库同时包含 `product-business-modeling` v0.2.3 runtime-aware 文档型 Core。修改业务模型能力时必须保持 Core、Shared Agent Skill Facade、Runtime Adapter、Project Assets、示例、评测和 docs 一致。

业务模型能力的核心边界：

- Business Modeling 是 Agent-neutral Core，不是 Codex、Claude Code、Cursor 或任一运行时的专属 Skill。
- 每个 Core 必须有 shared Agent Skill Facade；本能力的共享 facade 位于 `adapters/shared/agent-skill-facade/product-business-modeling/`，仓库级可发现 Skill 位于 `skills/product-business-modeling/`。
- 安装或 materialize 到目标项目前，必须先执行 Runtime Adapter Resolution：读取 `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` 与 `adapters/adapter-registry.yml`。
- 根据用户当前工具只选择 `codex`、`claude-code`、`cursor`、`generic-agent` 或明确的 `multi-runtime` profile；默认不得安装所有 runtime overlay。
- Runtime 信号冲突或无法判断是否多运行时时，停止并询问用户。
- 默认 `templates/project/` 必须保持 runtime-neutral，不得在根层包含 `.agents/`、`.codex/`、`.claude/` 或 `.cursor/`。
- Runtime-specific 文件只能存在于 `templates/project/runtime-overlays/<runtime>/`、`adapters/<runtime>/`，或被明确 materialize 到目标项目。
- `docs/product/**` 是唯一业务模型 source of truth；runtime adapter、Skill facade、`AGENTS.md` 和 `CLAUDE.md` 只负责路由与调用。
- `docs/product/BUSINESS_MODEL_OVERVIEW.md` 是唯一默认用户总览；它是 consistency validation 后编译出的派生视图，不是 source of truth。
- BM Work Item 根层必须使用 canonical 文件：`STATE.md`、`MODELING_CONSUMPTION.md`、`MODELING_OUTPUT.md` 和 `DECISION_NOTES.md`；旧 `PROPOSED_MODEL.md`、`EVIDENCE_AND_ASSUMPTIONS.md` 只能作为迁移输入，不能替代新输出。
- `STATE.md` 必须使用 Core 冻结字段；runtime-specific metadata 只能进入 `extensions` 或正文说明，不得新增替代性顶层 schema。
- 被动触发使用 `docs/product/model-triggers/`，不得创建 `model-requests/`。
- 核心业务模型只表达业务属性，不写数据库字段、接口参数、ORM 结构或实现类型。
- `schema-view.json` 只包含业务对象、业务领域、对象分类、业务属性和属性示例内容，且必须使用 v0.2.3 的精确结构。
- Dictionary、Business Model Index、Schema、Action、State、Rule 和 Permission 必须使用 stable IDs 并保持交叉引用一致。
- 一个 lifecycle 只属于一个业务对象；跨对象责任生成必须显式建模；上下文相关值不得伪装成单一对象固有属性。
- D2 / D3 业务语义必须使用 `BMD-xxx` Human Decision 记录，不能自动 confirmed，任务或决策不能自动 sealed。
- 每次 Core source-of-truth 写入后，必须执行 consistency validation，随后编译 `BUSINESS_MODEL_OVERVIEW.md` 和必要 downstream views。
- `ux-business-model-context.md/yml` 是业务模型下游派生视图，不是 UX 侧 source of truth。
- Business Modeling Core 不得直接修改既有 `docs/design/`、`REFERENCE_SELECTION.md`、Reference Library、Color Card Registry 或 sealed UX `STATE.md`。
- 不新增 CLI、Hook、Plugin、Installer、外部依赖、自动数据库迁移或 API 生成。

修改下列业务建模文件之一时，完成前必须检查对应文件是否仍一致：

- [README.md](README.md) / [README.zh-CN.md](README.zh-CN.md) / [CHANGELOG.md](CHANGELOG.md)
- [docs/architecture.md](docs/architecture.md)
- [CODEX_START_HERE.md](CODEX_START_HERE.md) / [AGENT_START_HERE.md](AGENT_START_HERE.md)
- [docs/PRD.product-business-modeling-v0.2.1.md](docs/PRD.product-business-modeling-v0.2.1.md)
- [docs/PRD.product-business-modeling-v0.2.3.md](docs/PRD.product-business-modeling-v0.2.3.md)
- [docs/CODEX_BUILD_BRIEF.product-business-modeling-v0.2.3.md](docs/CODEX_BUILD_BRIEF.product-business-modeling-v0.2.3.md)
- [docs/READINESS_AUDIT.product-business-modeling-v0.2.3.md](docs/READINESS_AUDIT.product-business-modeling-v0.2.3.md)
- [docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.3.md](docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.3.md)
- [docs/PRD.product-business-modeling-codex-skill-adapter-v0.2.2.md](docs/PRD.product-business-modeling-codex-skill-adapter-v0.2.2.md)
- [docs/PRD.product-business-modeling-runtime-adapter-resolution-v0.2.2.md](docs/PRD.product-business-modeling-runtime-adapter-resolution-v0.2.2.md)
- [docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.1-complete.md](docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.1-complete.md)
- [docs/CODEX_BUILD_BRIEF.product-business-modeling-runtime-adapter-resolution-v0.2.2.md](docs/CODEX_BUILD_BRIEF.product-business-modeling-runtime-adapter-resolution-v0.2.2.md)
- [docs/RUNTIME_ADAPTER_READINESS_AUDIT.product-business-modeling-v0.2.2.md](docs/RUNTIME_ADAPTER_READINESS_AUDIT.product-business-modeling-v0.2.2.md)
- [docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.2-runtime-aware.md](docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.2-runtime-aware.md)
- [core/product-design/business-modeling/CAPABILITY.md](core/product-design/business-modeling/CAPABILITY.md)
- [core/product-design/business-modeling/capability.manifest.yml](core/product-design/business-modeling/capability.manifest.yml)
- [core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md](core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md)
- [adapters/shared/agent-skill-facade/product-business-modeling](adapters/shared/agent-skill-facade/product-business-modeling/)
- [skills/product-business-modeling](skills/product-business-modeling/)
- [adapters/adapter-registry.yml](adapters/adapter-registry.yml)
- [adapters/codex](adapters/codex/) / [adapters/claude-code](adapters/claude-code/) / [adapters/cursor](adapters/cursor/)
- [templates/project/docs/product](templates/project/docs/product/)
- [templates/project/runtime-overlays](templates/project/runtime-overlays/)
- [examples/product-business-modeling](examples/product-business-modeling/)
- [evals/product-business-modeling/scenarios](evals/product-business-modeling/scenarios/)

## Product Business Analysis Core

本仓库同时包含 `product-business-analysis` v0.1.4 独立文档型 Core。修改商业分析能力时必须保持 Core、Adapter、Project Assets、示例、评测和 docs 一致。

商业分析能力的核心边界：

- Business Analysis 是 Agent-neutral、standalone 的商业决策支持能力，不是业务建模、设计工程或任一兄弟能力的上游、下游、Gate、回填器或触发器。
- Core 位于 `core/product-design/business-analysis/`。
- Runtime adapter 片段必须使用 namespaced 路径：`adapters/codex/product-business-analysis/`、`adapters/claude-code/product-business-analysis/`、`adapters/cursor/product-business-analysis/`。
- 项目模板必须只使用 `templates/project/docs/product/business-analysis/` 下的模块自有结构。
- 目标项目里的商业分析 source of truth 必须是 `docs/product/business-analysis/`。
- Decision Case 的唯一权威文件位于 `decision-cases/BA-DC-xxx.md`。
- BA Work Item 位于 `work-items/BA-xxx/`，只链接 Case，不得包含 `DECISION_CASE.md`。
- BA Work Item 的过程文件必须位于 `work-items/BA-xxx/artifacts/`；不得创建 `intake/`，也不得把过程文件放在 Work Item 根目录。
- Decision Network 与 Evidence Ledger 的 YML 是机器权威源，Markdown 是人读视图。
- 第一次用户输入必须原文保留；Routing 必须发生在 Input Understanding 之后。
- 后续对话必须先执行 Follow-up Turn Continuity，读取最小恢复集，恢复当前 BA Work Item、Decision Case、最新 Decision Summary、Decision Notes 和 Assurance 后再回答；不得无状态续答。
- Choice Core 必须在 `STATE.md` 和 Decision Case 顶部保持可见，至少覆盖当前决策问题、Choice Set、当前推荐、推荐状态、接受代价、证据边界、改变推荐条件、用户决定状态和 Claim-level Assurance 摘要。
- 问题确认后必须尽早形成 provisional Choice Set；不得等所有证据齐全后才允许形成选项或推荐。
- 阶段性结论必须给出当前最佳推荐，推荐状态只能是 `provisional | conditional | user_confirmed`；系统推荐永远不等于用户决定。
- Assurance 必须使用整体 `pass | warn | partial` 与声明级 `supported | provisional | conditional | blocked`；不得再用 Case 级全局 `block` 作为新输出结尾。
- No Dead-End Rule 必须生效：信息不足时仍要比较现实路径并推荐一个，不得只要求用户补材料。
- 每轮必须分别判断 `decision_signal` 和 `followup_request`；同一轮可以同时包含 confirmed 与 implementation_detail。
- 用户明确确认后必须关闭原 Choice Loop，设置 `choice_loop_status=closed`，将推荐转为 `user_confirmed`，写入 `DECISION_NOTES.md`，不得再次请求同一选择。
- 每个 Case 必须维护 Decision Scope Lock：`decision_scope_id`、`decision_scope_type`、`decision_scope_statement`、`decision_scope_status` 和 `explicit_non_scope`。
- 决定后的澄清只能解释目的、理由、后果、证据边界、进入 / 升级 / 停止 / 复审条件；不得下沉为实施设计。
- 创建任何非核心文件前必须执行 Artifact Boundary Gate，不得创建实施 Runbook、手工指南、数据 Schema、样例数据、脚本、UI / 技术规格、算法实现说明或执行结果。
- 不得主动提出生成样例、写脚本、运行模拟、搭建工具或实现产品；用户明确请求实施时，只能记录为当前 Case 之外的新任务候选，不自动触发任何兄弟能力。
- State 只能使用固定枚举：`status=active|paused|completed|cancelled`，`phase=input-understanding|case-routing|choice-set|analysis|recommendation|human-decision|post-decision-clarification|review|completion-review|complete`，`gate=none|decision-confirmation|completion-approval`；不得创造业务专属 phase / gate。
- 26 张 ready Analysis Model Cards 必须保持 `schema_version: 1`，且每张卡具备 `runtime_role`、Choice Delta、Choice Loop Closure Guard、Decision Scope Lock、实施边界守卫和七个非空 usage prompts：`decision_relevance_prompt`、`routing_prompt`、`user_input_prompt`、`execution_prompt`、`analysis_run_prompt`、`conclusion_prompt`、`misuse_guard_prompt`。
- Core Controls 默认不单独创建 Analysis Run；专业分析结果优先写入 `ANALYSIS_WORKSPACE.md`。
- 用户可见结论必须来自统一中央综合和 `DECISION_SUMMARY.md`，不得把单个 model card 的 `conclusion_prompt` 直接当最终建议。
- Decision Closure 必须让用户接受、拒绝、修改或暂缓一个业务选择，并记录下一次重新决策的触发条件。
- 用户可见和人类可读项目 Markdown 默认使用简体中文；模型 ID、字段名、路径和枚举保持英文。
- 用户表示“理解”“知道了”“OK”只能记录为 acknowledged，不得当成 D2 / D3 confirmed decision。
- 数值模型输入不足时必须阻止伪精确，不得伪造 NPV、IRR 或其他财务结论。
- D2 / D3 人类决定必须明确记录，系统建议不得冒充用户决定。
- 不得读取、触发、依赖或集成 `motivation-analysis`。
- 不得创建跨模块 Trigger、downstream views、共享 `docs/product/work-items/`、CLI、Hook、Plugin、installer 或外部依赖。
- 不得修改任何兄弟能力的 Core、Adapter、template、example、eval 或 project asset。

修改下列商业分析文件之一时，完成前必须检查对应文件是否仍一致：

- [README.md](README.md) / [README.zh-CN.md](README.zh-CN.md) / [CHANGELOG.md](CHANGELOG.md)
- [CODEX_START_HERE.md](CODEX_START_HERE.md) / [AGENT_START_HERE.md](AGENT_START_HERE.md)
- [docs/PRD.product-business-analysis-v0.1.4.md](docs/PRD.product-business-analysis-v0.1.4.md)
- [docs/ARCHITECTURE_DECISION.decision-boundary-and-choice-closure-v0.1.4.md](docs/ARCHITECTURE_DECISION.decision-boundary-and-choice-closure-v0.1.4.md)
- [docs/ARCHITECTURE_DECISION.choice-first-business-analysis-v0.1.3.md](docs/ARCHITECTURE_DECISION.choice-first-business-analysis-v0.1.3.md)
- [docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.2.md](docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.2.md)
- [docs/ARCHITECTURE_DECISION.business-problem-continuity-v0.1.2.md](docs/ARCHITECTURE_DECISION.business-problem-continuity-v0.1.2.md)
- [docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.4-complete.md](docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.4-complete.md)
- [docs/CODEX_READINESS_AUDIT.product-business-analysis-core-v0.1.4-complete.md](docs/CODEX_READINESS_AUDIT.product-business-analysis-core-v0.1.4-complete.md)
- [docs/PACKAGE_MANIFEST.product-business-analysis-v0.1.4.md](docs/PACKAGE_MANIFEST.product-business-analysis-v0.1.4.md)
- [docs/MIGRATION_NOTES.business-analysis-v0.1.3-to-v0.1.4.md](docs/MIGRATION_NOTES.business-analysis-v0.1.3-to-v0.1.4.md)
- [docs/MIGRATION_NOTES.business-analysis-v0.1.2-to-v0.1.3.md](docs/MIGRATION_NOTES.business-analysis-v0.1.2-to-v0.1.3.md)
- [docs/MIGRATION_NOTES.business-analysis-v0.1.1-to-v0.1.2.md](docs/MIGRATION_NOTES.business-analysis-v0.1.1-to-v0.1.2.md)
- [core/product-design/business-analysis](core/product-design/business-analysis/)
- [adapters/codex/product-business-analysis](adapters/codex/product-business-analysis/)
- [adapters/claude-code/product-business-analysis](adapters/claude-code/product-business-analysis/)
- [adapters/cursor/product-business-analysis](adapters/cursor/product-business-analysis/)
- [templates/project/docs/product/business-analysis](templates/project/docs/product/business-analysis/)
- [templates/project/fragments/product-business-analysis.AGENTS.fragment.md](templates/project/fragments/product-business-analysis.AGENTS.fragment.md)
- [examples/product-business-analysis](examples/product-business-analysis/)
- [evals/product-business-analysis/scenarios](evals/product-business-analysis/scenarios/)

## 核心概念

- Thread 是临时 Codex 对话，不是 Work Item。
- Work Item 是持久任务身份。
- 每个独立 Work Item 最多只有一个权威 `STATE.md`。
- `WORK_ITEMS.md` 只是索引；若与 `STATE.md` 冲突，以 `STATE.md` 为准。
- `reference-library/` 是长期视觉参考资料层，不保存 Work Item 专属选择。
- `REFERENCE_SELECTION.md` 是 Work Item 级参考消费结果。
- `STATE.md` 只记录 Reference Selection 链接和摘要，不吞完整参考分析。
- `project-memory/` 是跨 Work Item 的长期项目记忆，不保存完整聊天记录、完整参考分析或完整色卡知识。
- `outputs/` 是设计交付物系统，区分当前确认入口和历史事件归档。
- 新 Work Item 优先使用 Lifecycle Event ID；legacy `DE-xxx` 不得自动重命名。
- `completed + sealed` 状态只读，不得恢复，也不得用于新的实现修改。
- 不创建 `reference-library/reference-packs/`。
- 不创建 `docs/design/product-work-items/`。
- 不默认创建项目根目录 `outputs/`。

## 必须保持的枚举

状态解析决定只能是：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

`status` 只能是：

```text
active / paused / completed / cancelled
```

`phase` 只能是：

```text
intake / discovery / visual-direction / prototype / ux-flow / implementation / qa / completion-review / complete
```

`gate` 只能是：

```text
none / work-item-binding / visual-direction-approval / prototype-approval / interaction-decision / completion-approval
```

## 跨文件检查

修改下列文件之一时，完成前必须检查对应文件是否仍一致：

- [docs/PRD.md](docs/PRD.md)
- [skills/design-engineering/SKILL.md](skills/design-engineering/SKILL.md)
- [agents/design-state-steward.toml](agents/design-state-steward.toml)
- [skills/design-engineering/assets/STATE.template.md](skills/design-engineering/assets/STATE.template.md)
- [skills/design-engineering/assets/WORK_ITEMS.template.md](skills/design-engineering/assets/WORK_ITEMS.template.md)
- [skills/design-engineering/assets/REFERENCE_SELECTION.template.md](skills/design-engineering/assets/REFERENCE_SELECTION.template.md)
- [skills/design-engineering/references/lifecycle-event-id.md](skills/design-engineering/references/lifecycle-event-id.md)
- [skills/design-engineering/references/project-memory-and-artifacts.md](skills/design-engineering/references/project-memory-and-artifacts.md)
- [skills/design-engineering/references/context-bound-final-review.md](skills/design-engineering/references/context-bound-final-review.md)
- [skills/design-engineering/references/product-design-events.md](skills/design-engineering/references/product-design-events.md)
- [skills/design-engineering/references/reference-library-consumption.md](skills/design-engineering/references/reference-library-consumption.md)
- [templates/project/docs/design/reference-library](templates/project/docs/design/reference-library/)
- [examples/idea-storm-lab/docs/design/WORK_ITEMS.md](examples/idea-storm-lab/docs/design/WORK_ITEMS.md)
- [evals/scenarios](evals/scenarios/)

示例必须继续使用 idea-storm-lab 的三个请求：

1. 检查项目上下文
2. 优化前端样式
3. 统一内容模块问题长度换行
