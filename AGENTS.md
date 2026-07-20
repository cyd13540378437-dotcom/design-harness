# Codex Design Harness 仓库规则

本仓库定义 v0.1.x 的 Design Engineering Harness。后续修改必须保持 PRD、Skill、Steward Agent、模板、示例、评测和 README 彼此一致。

## 范围

- v0.1 保持手动、文档型交付。
- 不添加安装器、Codex Plugin 包、Marketplace 元数据、Hook、CLI、`statectl`、云服务或外部运行时依赖。
- 不自动下载、OCR、视觉识别或托管第三方截图。
- 不虚构 Codex 不支持的配置字段。
- 第三方 UI 或浏览器 Skill 只能作为可选增强被提及。


## Product Business Modeling Core

本仓库同时包含 `product-business-modeling` v0.2.2 runtime-aware 文档型 Core。修改业务模型能力时必须保持 Core、Shared Agent Skill Facade、Runtime Adapter、Project Assets、示例、评测和 docs 一致。

业务模型能力的核心边界：

- Business Modeling 是 Agent-neutral Core，不是 Codex、Claude Code、Cursor 或任一运行时的专属 Skill。
- 每个 Core 必须有 shared Agent Skill Facade；本能力的共享 facade 位于 `adapters/shared/agent-skill-facade/product-business-modeling/`，仓库级可发现 Skill 位于 `skills/product-business-modeling/`。
- 安装或 materialize 到目标项目前，必须先执行 Runtime Adapter Resolution：读取 `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` 与 `adapters/adapter-registry.yml`。
- 根据用户当前工具只选择 `codex`、`claude-code`、`cursor`、`generic-agent` 或明确的 `multi-runtime` profile；默认不得安装所有 runtime overlay。
- Runtime 信号冲突或无法判断是否多运行时时，停止并询问用户。
- 默认 `templates/project/` 必须保持 runtime-neutral，不得在根层包含 `.agents/`、`.codex/`、`.claude/` 或 `.cursor/`。
- Runtime-specific 文件只能存在于 `templates/project/runtime-overlays/<runtime>/`、`adapters/<runtime>/`，或被明确 materialize 到目标项目。
- `docs/product/**` 是唯一业务模型 source of truth；runtime adapter、Skill facade、`AGENTS.md` 和 `CLAUDE.md` 只负责路由与调用。
- 被动触发使用 `docs/product/model-triggers/`，不得创建 `model-requests/`。
- 核心业务模型只表达业务属性，不写数据库字段、接口参数、ORM 结构或实现类型。
- `schema-view.json` 只包含业务对象、业务领域、对象分类、业务属性和属性示例内容。
- D2 / D3 业务语义不能自动 confirmed，任务或决策不能自动 sealed。
- `ux-business-model-context.md/yml` 是业务模型下游派生视图，不是 UX 侧 source of truth。
- Business Modeling Core 不得直接修改既有 `docs/design/`、`REFERENCE_SELECTION.md`、Reference Library、Color Card Registry 或 sealed UX `STATE.md`。
- 不新增 CLI、Hook、Plugin、Installer、外部依赖、自动数据库迁移或 API 生成。

修改下列业务建模文件之一时，完成前必须检查对应文件是否仍一致：

- [README.md](README.md) / [README.zh-CN.md](README.zh-CN.md) / [CHANGELOG.md](CHANGELOG.md)
- [docs/architecture.md](docs/architecture.md)
- [CODEX_START_HERE.md](CODEX_START_HERE.md) / [AGENT_START_HERE.md](AGENT_START_HERE.md)
- [docs/PRD.product-business-modeling-v0.2.1.md](docs/PRD.product-business-modeling-v0.2.1.md)
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
