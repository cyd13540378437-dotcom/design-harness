# 变更日志

## Unreleased / product business analysis core v0.1.2

- 升级 `product-business-analysis` 到 v0.1.2，重点修复多轮对话中商业分析从 Decision Case 漂移成普通咨询回答的问题。
- 新增 Follow-up Turn Continuity、Business Problem Continuity、Final Conclusion Contract、Output Language Contract、Decision Synthesis、Analysis Depth Control、Solution Premise Challenge 等协议。
- 新增 Decision Anchor 与 Decision-relevant Question / Decision Delta Test，要求模型运行证明自己推动了当前商业决策；低相关或 discarded 运行不得进入结论。
- 新增 `solution-premise-challenge` model card，ready Analysis Model Cards 从 24 张增至 25 张；每张 ready 卡必须具备 7 个非空 usage prompts，包括 `decision_relevance_prompt`。
- 新增 `TURN_CONTINUITY_CHECK`、`DECISION_SYNTHESIS`、`DECISION_SUMMARY` 模板；过程文件统一放在 `work-items/BA-xxx/artifacts/`，不再使用 `intake/`。
- 明确用户可见输出和人读项目 Markdown 默认使用简体中文，字段名、模型 ID、路径和枚举保持英文。
- 新增 ARCOS 智能派单模拟器回归示例和评测；商业分析人工评测场景从 20 个扩展到 34 个。
- 继续保持 Business Analysis 与 Business Modeling、Design Engineering 以及所有兄弟能力完全独立；不新增跨模块 Trigger、downstream views、共享 Work Item 目录、CLI、Hook、Plugin、installer 或外部依赖。

## Unreleased / product business analysis core v0.1.1

- 新增完全独立的 `product-business-analysis` v0.1.1 文档型 Core，位于 `core/product-design/business-analysis/`。
- 新增商业分析项目模板：`templates/project/docs/product/business-analysis/`，包含 Decision Cases、Decision Network、Evidence Ledger、Reviews 和 BA Work Items。
- 新增 Codex / Claude Code / Cursor namespaced adapter 片段。
- 新增 v0.1.1 PRD、架构决策、完整 Codex 开工单、package manifest、readiness audit、迁移说明和产品总结。
- 新增 Seat invitation policy 示例：`examples/product-business-analysis/`。
- 新增 20 个商业分析人工评测场景，覆盖原始输入保留、理解前置、Case 路由、模型卡 usage prompts、NPV 误用阻断、反方分析、Decision Assurance、人类决定边界、单一权威和无兄弟能力修改。
- 保持 Business Analysis 与 Business Modeling、Design Engineering 以及所有兄弟能力完全独立；不新增跨模块 Trigger、downstream views、共享 Work Item 目录、CLI、Hook、Plugin、installer 或外部依赖。


## Unreleased / product business modeling v0.2.2 runtime-aware hotfix

- 新增 shared Agent Skill Facade：`adapters/shared/agent-skill-facade/product-business-modeling/`。
- 新增仓库级可发现 Skill：`skills/product-business-modeling/`，并保留 Core 语义由 `core/product-design/business-modeling/` 管理。
- 新增 Runtime Adapter Resolution：`core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` 与 `adapters/adapter-registry.yml`。
- 新增 Codex / Claude Code / Cursor runtime install profiles、Skill adapters、state steward / Cursor rules fallback。
- 新增 neutral project runtime metadata 与 `templates/project/runtime-overlays/<runtime>/`，默认模板不再承载根层 `.agents/.codex/.claude/.cursor`。
- 新增 v0.2.2 runtime-aware PRD、Build Brief、Readiness Audit、Package Manifest 和 runtime adapter evals。
- 明确默认不得安装所有 runtime overlay；runtime 信号冲突时必须停止并询问用户。
- 保持 `docs/product/**` 为唯一业务模型 source of truth，且不新增 CLI / Hook / Plugin / Installer / 外部依赖。


## Unreleased / product business modeling core v0.2.1

- 新增 `product-business-modeling` v0.2.1 Complete 文档型 Core，位于 `core/product-design/business-modeling/`。
- 新增业务模型目标项目模板：`templates/project/docs/product/`，覆盖 `business-modeling/`、`model-triggers/`、BM Work Items 和 downstream views。
- 新增 Codex / Claude Code / Cursor 业务建模 Adapter 片段。
- 新增 `CODEX_START_HERE.md`、v0.2.1 PRD、完整 Codex 开工单、package manifest、readiness audit 和产品总结。
- 新增 Seat-based pricing 被动触发示例：`examples/product-business-modeling/`。
- 新增 20 个业务模型人工评测场景，覆盖业务属性与数据字段边界、`schema-view.json` 五项边界、Human Decision Control Plane、Passive Trigger、UX Context Pack 和 sealed UX 保护。
- 保持既有 `docs/design/`、Reference Library、Color Card Registry、`REFERENCE_SELECTION.md` 与 sealed UX `STATE.md` 由 Design Engineering 管理；Business Modeling 只通过派生视图和 Follow-up Trigger 表达 UX 影响。

## Unreleased / agent compatibility

- 新增 `scripts/install-agent-compat.sh`，支持为 Codex、Claude Code 和 Cursor 安装完整 Design Harness 文件集。
- 新增 Claude Code adapter：`CLAUDE.fragment.md` 与 `design-state-steward` subagent。
- 新增 Cursor adapter：`.cursor/rules/design-engineering.mdc` 与主 Agent 可执行的 state steward 规则。
- 更新 Skill 与 README，明确 `design_state_steward` 在 Codex、Claude Code 和 Cursor 下的等价入口。
- 新增 `docs/agent-compatibility.md`，解释轻量规则包与完整仓库的区别，避免安装后缺少 references、assets、templates 和 color-card registry。
- 新增 `typography-selection` 视觉子检查点，将字体、字号、行高、字重、fallback、响应式调整、用途映射和可读性风险纳入 `STATE.md` 与 `VISUAL_DESIGN.md`。
- 增强兼容安装器：新增 `doctor` 检查、安装完成摘要和 Cursor adapter README，明确 `.cursor/design-harness` 与根目录 `docs/design` 的职责分离。

## v0.1.3-alpha / lifecycle-memory increment

- 新增 `docs/PRD.lifecycle-memory-v0.1.3.md` 与 `docs/product-summary.lifecycle-memory-version.md`。
- 新增 Lifecycle Event ID 规则：新 Work Item 优先使用 `yyyy-mm-dd-hhmm-UX-001` / `PD-001`，legacy `DE-xxx` 继续兼容且不自动重命名。
- 新增 `templates/project/docs/design/project-memory/`，包含 Business、Product、UX、Visual、Engineering 和 Decisions 记忆文件。
- 新增 `templates/project/docs/design/outputs/`，区分 `current/` 当前入口与 `archive/<event_id>/` 历史归档。
- 升级 `STATE.template.md` 为 schema version 2，记录 `event_id`、`domain`、`execution_profile`、Design Contract、Review Lens、outputs 和 Project Memory 更新计划。
- 升级 Skill、Steward、AGENTS fragment、Claude/Cursor adapter 规则，加入 Fast Profile、Context-bound Final Review、Project Memory、Outputs 和 PD 产品设计事件。
- 新增 lifecycle-event-id、project-memory-and-artifacts、context-bound-final-review、product-design-events reference 文档。
- 新增 `examples/lifecycle-memory-lab/`，覆盖 UX event、PD event、PD -> UX predecessor、review.md、outputs archive/current 和 Project Memory。
- 新增评测 `18-25`，覆盖 Lifecycle Event ID、legacy resume、Fast Profile、Final Review、PD、PD -> UX、Outputs 和 sealed 状态不可变更。
- 保持 v0.1 状态解析枚举、Gate、sealed 规则、v0.1.1 Reference Library 和 v0.1.2 Color Card Registry 完整兼容。

### Field validation notes

- 使用新建 `testNewPD` 项目完成一次端到端实战验证：安装兼容包、创建首个 UX Lifecycle Event、产出核心页面 demo、用户确认后封存、创建 successor、以 Fast Profile 升级首页视觉、再次封存并提升为 `outputs/current`。
- 验证 Project Memory 能沉淀压缩后的产品、UX、视觉和决策经验；后续 successor 可从 `project-memory/`、`VISUAL_DESIGN.md` 与 `outputs/index.yml` 恢复当前基线，而不需要读取完整历史聊天。
- 验证 `outputs/archive/<event_id>/` 与 `outputs/current/` 的边界成立：Work Item `artifacts/` 是工作现场，只有用户确认后的结果才进入 current 与 archive。
- 暴露一个尚未实现的功能架构缺口：老项目接手时需要 Project Adoption / Adoption Baseline 流程，用于盘点既有页面、组件、设计文档、历史决策和当前 confirmed outputs，并把事实按 `confirmed / observed / inferred` 分层写入 Project Memory。v0.1.3 尚未内置该接手基线层。
- 暴露一个工程化后续项：封存操作仍需人工同步 `STATE.md`、`WORK_ITEMS.md`、outputs、Project Memory 和 `VISUAL_DESIGN.md`；后续版本应提供确定性 state/closure 工具以降低路径和索引错误。

## v0.1.2-alpha / color-card-registry increment

- 将 `reference-library/assets/color-cards/` 从预留目录升级为 Color Card Registry。
- 新增 `palette-index.yml` 作为色卡机器权威清单，保留 `palette-index.md` 作为人读索引。
- 明确 `Color Card = index entry + image + palette + annotation`，并固定 no-orphan 完整性合同。
- 明确只有 `status: ready` 且 `gate_preview: true` 的色卡可进入 `visual-direction-approval`。
- 增加 Skill、AGENTS 和 Work Item 模板中的色卡消费与记录规则。
- 新增色卡完整性、ready-only gate 展示和业务语义配色确认评测。

## v0.1.1-alpha / reference-library increment

- 在 v0.1.0-alpha visual-workflow revision 基础上新增 Product Visual Reference Library。
- 新增 `templates/project/docs/design/reference-library/`，包含产品索引、模式索引、产品/模式条目、截图目录、schema 和色卡预留结构。
- 新增 `REFERENCE_SELECTION.template.md`，用于记录 Work Item 级参考消费结果。
- 新增 Surface Resolution，视觉方向前先明确 `web-app / mobile-app / responsive-web / desktop-app / tablet / multi-surface`。
- 更新 Skill、Steward、AGENTS 片段、PRD、README、架构说明和手动测试指南，明确 `STATE.md` 只记录参考摘要和链接。
- 新增 `reference-library-consumption.md`，说明参考库检索顺序、用户方向表达和跨终端借鉴边界。
- 新增 3 个 Reference Library 人工评测场景，总评测场景扩展为 13 个。
- 明确禁止 `reference-library/reference-packs/`、自动截图下载、自动 OCR、外部运行时依赖和第三方资产复制。

## v0.1.0-alpha / visual-workflow revision

- 保留 Work Item、`STATE.md`、Gate、Steward 和 sealed 状态架构。
- 将视觉流程改为 Visual Seed、参考图片或参考包、参考解析、配色确认、设计禁区确认和视觉原型。
- 新增 `VISUAL_DESIGN.md` 项目级视觉基线模板和示例。
- 新增 `visual-workflow.md` reference 文档。
- 新增 5 个自制视觉参考包，每个包包含 SVG 样张和说明。
- 更新 Skill、Steward、README、架构说明、模板和 AGENTS 片段。
- 更新 idea-storm-lab 示例，让 DE-001 展示新版视觉流程，DE-002 读取并遵守视觉基线。
- 人工评测场景从 7 个扩展为 10 个。
- 明确不新增 `palette-approval` 或 `anti-homogeneity` Gate，不要求用户填写产品人格或品牌气质矩阵。
- 强化 `palette-selection`：必须至少提供 3 套候选调色盘、同构 UI 样张和可读性/对比说明。
- 明确用户可以直接输入自定义颜色偏好；无论选择候选或自定义，最终配色都必须写入 `STATE.md`。

## v0.1.0-alpha

- 新增手动使用的 `design-engineering` Skill。
- 新增项目级 `design_state_steward` 自定义 Agent。
- 新增 Work Item 状态模板和索引模板。
- 新增 idea-storm-lab 示例，覆盖 `NO_STATE`、`CREATE`、`SUCCESSOR`、sealed 前任和 completion review。
- 新增七个人工评测场景。
- 新增架构说明和手动测试指南。

## 路线图

- v0.2：确定性 `statectl`、Schema 检查、自动索引生成、状态迁移和更强的冲突检测。
- v0.3：安装与初始化命令、doctor 检查、受管 `AGENTS.md` 区块、升级和卸载流程。
- v0.4：Codex Plugin 打包、Marketplace 分发、可选 Hook 支持和可选 Playwright MCP 集成。
