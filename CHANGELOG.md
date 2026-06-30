# 变更日志

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
