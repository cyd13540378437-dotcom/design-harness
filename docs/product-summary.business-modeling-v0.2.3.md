# Product Business Modeling v0.2.3 产品总结

## 1. 产品定位

`product-business-modeling` 负责把业务世界抽象成统一、稳定、可演进的产品语义模型，让产品、UX、前端、后端、数据库和 QA 在同一套业务语言下协作。

它不是数据库建模工具，也不是 PRD 生成器。它沉淀的是业务对象、业务属性、关系、动作、生命周期、规则、权限、风险和可供下游编译的产品知识。

## 2. v0.2.3 的核心体验

业务负责人和产品负责人默认只需要看：

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

这份总览回答：

- 这个产品解决什么问题；
- 当前产品边界是什么；
- 核心业务对象和端到端流程是什么；
- 第一期应实现哪些能力；
- 哪些判断已经确认，哪些仍是 `provisional`；
- 当前需要用户决定什么；
- 主要业务风险和模型风险是什么；
- 需要深入时应进入哪一份专业文件。

正常交付时，Agent 不再向用户抛出一长串技术文件。用户从总览完成理解和决策，维护者和下游专业角色再按需进入详细资产。

## 3. 为什么详细文件继续保留

v0.2.3 没有把全部内容粗暴合并成一个大文件，因为：

- 不同模型资产的变化频率不同；
- 下游角色只需要加载与自己相关的上下文；
- stable ID、引用关系和一致性校验需要结构化资产；
- 业务事实、任务状态、证据和派生视图不能混成同一权威源；
- Git 审阅、影响分析和被动触发需要明确知识边界。

因此采用：

```text
模块化权威资产
+ 单一用户编译视图
```

`BUSINESS_MODEL_OVERVIEW.md` 是派生视图，不是新的 source of truth。底层模型发生变化后，必须先通过一致性校验，再重新编译总览。

## 4. v0.2.3 的强制闭环

```text
业务建模
→ Human Decision Compression
→ 更新 Source of Truth
→ Consistency Validation
→ 编译 Business Model Overview
→ 编译适用的专业下游视图
```

任何持久化的 Core 模型写入都不能绕过这个闭环。存在阻塞性一致性错误时，不得把总览伪装成已经完成的稳定模型。

## 5. 本次修复的协议问题

### 5.1 Canonical Work Item

每个 BM Work Item 固定使用：

```text
STATE.md
MODELING_CONSUMPTION.md
MODELING_OUTPUT.md
DECISION_NOTES.md
artifacts/SOURCE_EVIDENCE.md
artifacts/MODEL_EXTRACTION_REPORT.md
artifacts/MODEL_CONSISTENCY_REPORT.md
artifacts/MODEL_IMPACT_REPORT.md
```

`PROPOSED_MODEL.md`、`EVIDENCE_AND_ASSUMPTIONS.md` 等旧名称只能作为迁移输入，新运行不得用它们替代标准文件。

### 5.2 冻结 State Schema

Core、项目模板、Codex、Claude Code、Cursor 和各自 Steward 共享完全一致的 18 个顶层字段。运行时信息只能进入 `extensions` 或正文，Adapter 不再自由发明权威字段。

### 5.3 机器可消费的模型合同

- `business-dictionary.yml` 完整登记业务领域、对象分类、对象、业务属性、动作、状态、角色和禁用术语；
- `BUSINESS_MODEL_INDEX.yml` 登记模型资产和引用关系，并声明默认用户视图；
- `schema-view.json` 只有一种允许结构，只回答对象、领域、分类、业务属性和示例内容五类问题；
- Markdown 视图是人读编译结果，不与 YAML / JSON 形成两份互相竞争的事实。

### 5.4 稳定引用与语义所有权

Action、State、Rule 使用 stable ID 和明确引用；一个生命周期只属于一个业务对象。跨对象产生新的业务责任时，要通过动作效果或对象物化表达，不能把两个对象的阶段混在同一生命周期里。

### 5.5 上下文属性与对象身份

- “到达成本”这类依赖资源、位置、时间和候选窗口的值，不再作为位置固有属性，而属于候选或评估上下文；
- `Asset / Facility` 这类斜杠合并身份会触发 D2 决策或一致性错误，不能在未确认时伪装成稳定对象。

### 5.6 Human Decision Package

高影响判断统一使用 `BMD-xxx`，并先压缩成：

```text
当前理解
→ 为什么重要
→ 方案与取舍
→ Agent 推荐
→ 用户可直接回复的确认格式
```

需要用户决策的内容可以直接在总览中完成，不必先理解 Work Item 文件树。

## 6. 真实 Greenfield 回归样本

主示例位于：

```text
examples/product-business-modeling/work-order-intelligent-dispatch/
```

它来自“设备设施工单智能调度”实验，并已按 v0.2.3 重构。示例保留 13 个核心业务对象，形成：

```text
工单需求
→ 资源能力与可用性
→ 候选生成与排除
→ 策略排序
→ 派工决策
→ 执行责任
→ 执行记录
→ 调度评估快照
```

示例同时展示：

- 单一用户总览；
- Canonical Work Item；
- Dictionary / Index / Schema 交叉一致；
- Dispatch Decision 与 Assignment 生命周期分离；
- `MaintainableAsset` 对对象身份歧义的收敛；
- 到达成本的上下文归属；
- 五个完整的 `BMD-xxx` 决策包；
- 写入后的模型一致性报告。

另有一个紧凑的 Seat Pricing Change 示例，用于验证被动触发、影响报告和 provisional 模型更新。

## 7. 评测与校验

v0.2.3 包含 41 个连续编号的 Given / When / Then 场景：

- `01`–`28` 保留 v0.2、v0.2.1、v0.2.2 回归覆盖；
- `29`–`41` 验证单一总览、文件协议、State Schema、结构化注册表、稳定引用、生命周期归属、上下文属性、复合对象身份、写后校验、总览新鲜度和干净发布包。

发布审计结果：

```text
281 个文件
247 个 Markdown
16 个 YAML
4 个 JSON
2 个 TOML
41 个评测场景
0 个警告
0 个错误
```

同时确认所有相对链接和清单路径有效、运行时 overlay 与源 Adapter 同步、两个示例的 Dictionary / Index / Schema 引用完整，并且发布包不包含 macOS 元数据、CLI、脚本或外部依赖。

## 8. 最终产品判断

v0.2.3 解决的不是“再增加一份文档”，而是把阅读体验和知识架构分层：

```text
用户只面对一个清晰入口；
专业知识仍保留可维护、可校验、可编译的结构。
```

这使 Business Modeling Core 既能继续作为严谨的产品语义基础设施，又不会把底层复杂度转嫁给业务用户。
