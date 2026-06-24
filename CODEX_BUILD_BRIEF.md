# Codex 开工单：创建 `codex-design-harness` v0.1.0-alpha

请在当前 Git 仓库中实现 `docs/PRD.md` 定义的 **Codex Design Harness v0.1.0-alpha**。

## 工作方式

1. 先完整阅读 `docs/PRD.md`，再检查当前仓库内容。
2. 先输出一个简短实施计划，但不要向我重复 PRD。
3. 除非存在真正阻塞且 PRD 未定义的问题，否则直接开始实现。
4. 按 PRD 的 Milestone 顺序工作。
5. 每完成一个 Milestone，交叉检查术语、状态枚举、文件路径和示例是否一致。
6. 最终对照 PRD 的 Definition of Done 逐项自检。

## 严格范围

本次必须创建完整的文档型 v0.1 仓库，但不要实现：

- 自动安装器；
- Codex Plugin；
- Marketplace；
- Hook；
- CLI；
- `statectl`；
- 云端服务；
- 外部运行时依赖。

## 关键约束

- Thread 不等于 Work Item。
- 每个独立 Work Item 最多有一个权威 `STATE.md`。
- `WORK_ITEMS.md` 只是索引，冲突时以 `STATE.md` 为准。
- 状态解析只能是：`CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`。
- `completed + sealed` 不得恢复或修改，只能只读引用并创建 Successor。
- `design-engineering` 必须显式要求调用 `design_state_steward`。
- Steward 只管理状态，不实现业务代码或代替用户批准。
- 完成封存必须经过 `completion-approval` Gate。
- 示例必须使用 idea-storm-lab 的三个请求：
  - 检查项目上下文；
  - 优化前端样式；
  - 统一内容模块问题长度换行。
- 第三方 UI Skill 和浏览器工具只作为可选增强。
- 不要虚构 Codex 配置字段。

## 质量要求

- 中英文 README 均可独立理解；
- 中文内容自然，不是生硬翻译；
- YAML、TOML、Markdown 语法有效；
- 相对链接有效；
- 示例索引和状态彼此一致；
- 不保留空泛 TODO；
- 仓库结构与 PRD 完全一致，合理差异必须在最终说明中解释。

## 最终回复

请说明：

1. 创建或修改了哪些核心文件；
2. 状态模型和 Agent/Skill 如何协作；
3. 七个评测场景是否全部满足；
4. 对照 Definition of Done 的结果；
5. 当前明确未实现的 v0.2+ 能力。
