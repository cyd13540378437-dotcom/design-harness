# Historical PRD Notice

This is the original v0.2 PRD. For Codex implementation of the complete v0.2.1 package, use:

```text
docs/PRD.product-business-modeling-v0.2.1.md
```

The content below is retained as historical baseline.

---

# DesignHarnessAgent — Business Modeling Core PRD v0.2

- **产品**：DesignHarnessAgent
- **能力集群**：业务模型能力集群（`product-business-modeling`）
- **版本**：v0.2
- **文档状态**：可执行 PRD / 可落仓 Core 规格
- **日期**：2026-07-17
- **主要语言**：简体中文；稳定 ID、枚举、文件名使用英文

---

## 1. 产品摘要

Business Modeling Core 是 DesignHarnessAgent 产品设计知识系统中的业务模型能力集群。它负责把业务世界抽象为稳定、统一、可演进的产品语义模型，并向商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 提供同一套业务语言。

本能力集群不是 Codex 专属 Skill，而是 Agent-neutral Core。Codex、Claude Code、Cursor 等运行时只通过 Adapter 消费它。

---

## 2. 背景与问题

在产品设计和实现过程中，常见问题包括：

1. 业务对象、字段、页面和接口命名互相混用；
2. 数据库字段被误认为业务事实；
3. UI/UX 或需求文档自行补充业务规则，导致与后端或 QA 冲突；
4. 上游商业分析变化后，业务模型、需求、数据库和页面没有统一影响分析；
5. 下游发现缺口时直接在本层乱补，而不是通过可审计的回填机制；
6. AI 容易把 provisional 推断写成 confirmed 结论；
7. 已确认或封存的语义可能被后续对话静默改写。

Business Modeling Core 用业务模型 source of truth、Model Trigger、Human Decision Control Plane 和 Downstream Views 解决这些问题。

---

## 3. v0.2 目标

v0.2 必须实现：

1. Agent-neutral 的业务模型 Core 规格；
2. Core / Adapter / Project Assets 三层架构；
3. 完整业务模型长期资产结构；
4. 完整任务级 Work Item 结构；
5. `schema-view.json` 极简结构视图；
6. 业务属性与数据字段的严格分离；
7. 六种入口模式；
8. 14 个子能力模块；
9. Human Decision Control Plane；
10. Passive Trigger Interface；
11. `model-triggers/MT-xxx.md` 协议；
12. `MODEL_IMPACT_REPORT.md` 协议；
13. 下游视图编译机制；
14. 项目解析和一致性校验；
15. Codex / Claude Code / Cursor Adapter 规则片段；
16. 与既有 UX / Design Engineering Harness 的兼容性说明；
17. 示例和人工评测场景。

---

## 4. 非目标

v0.2 不实现：

```text
CLI
Hook
Plugin
Marketplace
自动安装器
外部运行时依赖
自动数据库迁移
自动 API 生成
图形化控制台
云端同步
多用户并发锁
```

本版本是协议完整、模板完整、评测完整、Agent-neutral 完整的文档型 Core 包。

---

## 5. 核心原则

### 5.1 产品设计知识契约网络

商业分析、业务模型、产品表达、需求表达不是瀑布 Gate，而是通过知识契约协作的 API Mesh。

任意 Cluster 可以先启动，但必须声明消费来源、确认程度、假设、缺口、影响范围和人类决策要求。

### 5.2 业务属性不是数据字段

核心业务模型只表达业务属性。数据库字段、接口参数、持久化类型只能出现在下游派生视图中。

### 5.3 `schema-view.json` 只表达结构浏览

`schema-view.json` 只表达对象、领域、分类、业务属性和示例内容，不表达关系、动作、状态、规则、权限或技术实现。

### 5.4 Human Decision Control Plane 是横切机制

AI 可以自动生成 `draft` / `provisional`，但不能自动确认高影响语义，不能自己 sealed。

### 5.5 Passive Trigger 是事件合同

`MT-xxx.md` 不是普通请求单，而是需要完成影响分析、模型响应、校验、重编译和回写的事件合同。

---

## 6. 项目资产结构

目标项目中的业务模型资产必须放在 Agent-neutral 路径中：

```text
docs/product/
├── PRODUCT_WORK_ITEMS.md
├── model-triggers/
├── business-modeling/
└── work-items/
```

运行时入口如 `.codex/`、`.cursor/`、`CLAUDE.md` 只是 Adapter，不是业务模型知识资产。

---

## 7. 入口模式

| 模式 | ID | 说明 |
|---|---|---|
| 用户主动建模 | `direct_modeling` | 用户明确要求新增、修改、补充业务模型。 |
| 被动触发 | `passive_trigger` | 上游变化、下游缺口或横向冲突触发模型响应。 |
| 当前项目解析 | `project_extraction` | 从现有项目提取候选业务模型。 |
| 从零建模 | `greenfield_modeling` | 从模糊想法建立 provisional 初始模型。 |
| 一致性校验 | `consistency_validation` | 检查模型内部和派生视图一致性。 |
| 下游视图编译 | `downstream_compilation` | 编译产品、需求、数据库、后端、前端、QA 视图。 |

---

## 8. 子能力架构

本能力集群包含 14 个子能力，分为统筹与调度、核心生产、演进风险交接、解析与校验四类。Human Decision Control Plane 和 Passive Trigger Interface 是横切机制。

详细工作合同见 `CAPABILITY.md` 与 `references/subcapability-work-logic-v0.2.md`。

---

## 9. Source of Truth

| 资产 | 权威来源 | 说明 |
|---|---|---|
| 业务术语 | `business-dictionary.*` | 对象、属性、动作、状态、角色、分类。 |
| 结构浏览 | `schema-view.json/md` | 只含对象、领域、分类、业务属性、示例。 |
| 对象画像 | `domain-objects/*.md` | 对象身份、边界、责任、生命周期。 |
| 对象关系 | `relationships/relationship-map.md` | 业务对象之间的语义连接。 |
| 业务动作 | `actions/action-command-catalog.md` | 谁能对谁做什么。 |
| 状态生命周期 | `states/state-lifecycle-model.md` | 状态与转换。 |
| 规则权限 | `rules/*` | 业务不变量、约束和权限策略。 |
| 路线图风险 | `roadmap/*`, `risks/*` | 演进和风险。 |
| 下游视图 | `downstream-views/*` | 派生视图，不是权威源。 |
| 模型触发 | `model-triggers/MT-xxx.md` | 被动触发事件合同。 |
| 决策记录 | `work-items/BM-xxx/DECISION_NOTES.md` | 高影响业务语义决定。 |

---

## 10. Human Decision Control Plane

必须进入人类决策的情况：

```text
对象身份存在互斥判断
对象关系影响权限、流程或数据库
业务动作改变核心流程
状态流转有多个合理方案
规则涉及责任、权限、审计或合规
上游变化导致模型重构
provisional 已被下游依赖
升级到 confirmed
关闭、封存或废弃重要模型资产
```

AI 输出必须先做决策压缩：当前理解、为什么重要、可选方案、推荐方案和需要确认的具体问题。

---

## 11. Passive Trigger Interface

Trigger 类型：

```text
upstream_change
downstream_gap
cross_cluster_conflict
internal_discovery
```

生命周期：

```text
open → triaged → in_progress → awaiting_human → resolved | dismissed | superseded
```

每个 Trigger 必须支持去重、优先级、Work Item 绑定、影响报告、决策等待、关闭回写和后续 Trigger 传播。

---

## 12. 下游视图

下游视图至少包括：

```text
product-expression-view.md
requirements-view.md
database-view.md
backend-view.md
frontend-view.md
qa-view.md
ux-design-engineering-view.md
```

下游视图可以将业务属性映射为实现建议，但必须标明派生性质。发现核心模型缺口时创建 Model Trigger，不得直接补核心模型。

---

## 13. Adapter 要求

v0.2 提供 Codex、Claude Code、Cursor 三类 Adapter 规则片段。Adapter 必须：

1. 读取项目 `docs/product/` 资产；
2. 识别六种入口模式；
3. 使用 Core 模板写入任务级文件；
4. 不绕过 Human Decision Control Plane；
5. 不将运行时线程等同于 Work Item；
6. 不把数据库字段写回核心模型。

---

## 13A. 与 UX / Design Engineering Harness 的兼容性

如果目标项目已经包含 Design Engineering Harness，Business Modeling Core 不得修改、迁移或覆盖既有 `docs/design/` 资产。业务模型变化对 UX 的影响必须通过以下方式表达：

```text
MODEL_IMPACT_REPORT.md
downstream-views/ux-design-engineering-view.md
Follow-up Trigger 或 Design Engineering Successor 建议
```

业务模型能力可以说明对象、关系、动作、状态、规则和权限变化如何影响 UX 流程、页面、文案、交互状态和 QA，但不能直接写入 `docs/design/work-items/*/STATE.md`、`REFERENCE_SELECTION.md`、`reference-library/` 或 Color Card Registry。

详细协议见 `core/product-design/business-modeling/protocols/ux-design-engineering-compatibility.md`。

---

## 14. 人工评测

评测采用 Given / When / Then 格式，覆盖 14 个场景：低影响属性、对象身份歧义、上游变化、下游字段反推、横向冲突、项目解析确认边界、schema-view 边界、动作 actor、状态动作一致性、下游缺口、provisional 状态、sealed 不可改写、Trigger 去重、confirmed 冲突。

---

## 15. 实施里程碑

### Milestone 1：Core 骨架

创建 `CAPABILITY.md`、`capability.manifest.yml`、协议目录、模板目录和引用目录。

### Milestone 2：项目模板

创建 `templates/project/docs/product/` 下的业务模型资产、Trigger 和 Work Item 模板。

### Milestone 3：协议模板

完成 `MT-xxx.md`、`MODEL_IMPACT_REPORT.md`、`DECISION_NOTES.md` 等协议。

### Milestone 4：Adapter 片段

完成 Codex、Claude Code、Cursor 适配规则片段。

### Milestone 5：示例和评测

完成一个端到端示例和 14 个 Given / When / Then 评测。

---

## 16. Definition of Done

- [ ] 新用户不读长对话也能理解业务模型能力；
- [ ] 文件结构与 `CAPABILITY.md` 一致；
- [ ] 所有模板可直接复制到项目；
- [ ] `model-triggers/` 协议完整；
- [ ] `MODEL_IMPACT_REPORT.md` 协议完整；
- [ ] Human Decision Control Plane 可执行；
- [ ] `schema-view.json` 边界可测试；
- [ ] 下游视图不会反向覆盖核心模型；
- [ ] 既有 `docs/design/`、Reference Library 和 Color Card Registry 不会被业务模型静默修改；
- [ ] UX 影响通过影响报告、UX 派生视图和 Follow-up Trigger 表达；
- [ ] Adapter 不引入运行时锁定；
- [ ] 14 个评测场景齐全；
- [ ] 不包含 v0.2 非目标。

---

## v0.2.1 增量：UX Business Model Context Pack

Business Modeling Core 新增 `ux-business-model-context.md/yml`，作为面向 UX / Design Engineering 的轻量下游派生视图。

该包用于 UX Work Item 启动和关键设计判断时读取，缺失不阻断 UX 启动。它只表达 UX 需要尊重的业务对象、动作、状态、规则、权限和 open triggers，不包含数据库字段、后端接口或视觉参考。

UX 侧只识别两类候选信号：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

真正的业务模型更新仍必须通过 `model-triggers/MT-xxx.md`、Business Modeling Core 和 Human Decision Control Plane 完成。
