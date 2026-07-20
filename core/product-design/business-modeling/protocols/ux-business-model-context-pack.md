# UX 业务模型上下文包协议（`ux-business-model-context`）

## 1. 目的

`UX Business Model Context Pack` 是业务模型能力集群面向 UX / Design Engineering 的轻量下游派生视图。

它解决两个问题：

```text
1. UX 启动设计时不应全量读取业务模型 source of truth；
2. UX 又需要知道当前稳定的业务对象、动作、状态、规则和权限边界，避免静默发明或违反核心业务语义。
```

因此，本协议定义一个可被 UX 低成本读取的上下文包。

该上下文包不是新的 source of truth。它由业务模型下游视图编译器从核心模型资产编译而来，供 UX 启动、关键交互设计和完成封存前检查使用。

---

## 2. 标准路径

业务模型 Core 应提供两个同源文件：

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

建议同时保留：

```text
docs/product/business-modeling/downstream-views/ux-design-engineering-view.md
```

二者区别：

| 文件 | 用途 | 典型读取时机 |
|---|---|---|
| `ux-business-model-context.*` | UX 启动和设计过程中轻量读取的稳定语义输入 | Work Item 启动、关键交互设计、完成封存前 |
| `ux-design-engineering-view.md` | 业务模型变化后对 UX 的影响分析视图 | 被动触发、模型变更、影响分析完成后 |

---

## 3. 输入来源

上下文包只能由以下业务模型资产编译：

```text
BUSINESS_MODEL_INDEX.*
business-dictionary.*
schema-view.*
domain-objects/*
relationships/*
actions/*
states/*
rules/*
model-triggers/MT-xxx.md
```

它不得从 UX `STATE.md`、`REFERENCE_SELECTION.md`、前端代码、数据库字段或后端接口中直接生成 confirmed 业务语义。

如果编译器需要引用这些下游材料，只能作为 evidence 或 gap signal，并必须保持 `draft` / `provisional` / `candidate` 状态。

---

## 4. 内容边界

上下文包应该只包含 UX 需要轻量消费的内容：

```text
业务对象摘要
UX 相关业务动作
UX 相关对象状态
会影响可见性 / 可操作性 / 错误态 / 责任 / 审计的规则与权限
当前 open 的模型触发
UX 何时应创建模型触发
UX 何时不应创建模型触发
```

上下文包不得包含：

```text
数据库字段
接口参数
ORM 模型
具体页面布局
视觉参考选择
色卡选择
完整对象画像长文
完整规则推导过程
完整聊天记录
```

---

## 5. 消费策略

UX / Design Engineering 侧消费该包时必须遵守：

```text
1. 如果 Context Pack 存在，UX 启动 Work Item 时应轻量读取；
2. 如果 Context Pack 不存在或不完整，不阻断 UX 启动；
3. UX 不负责确认业务模型；
4. UX 只提示两类候选问题：business_model_gap_candidate 与 business_model_conflict_candidate；
5. UX 不执行复杂语义差异分层；
6. 纯视觉、布局、终端参考、色卡、局部 UI 控制不触发业务模型；
7. 未解决的高影响业务模型缺口或 confirmed 冲突不得被 sealed 为 confirmed UX 行为。
```

---

## 6. 两类候选问题

### 6.1 `business_model_gap_candidate`

当 UX 方案需要某个业务对象、业务动作、状态、规则、权限、责任或审计语义，但上下文包没有提供时，UX 可以标记：

```text
business_model_gap_candidate
```

如果该缺口影响核心流程、生产实现、验收标准或完成封存，UX 应创建：

```yaml
trigger_type: downstream_gap
source_cluster: design-engineering
target_cluster: business-modeling
```

### 6.2 `business_model_conflict_candidate`

当 UX 方案明显违反上下文包中的 confirmed 业务语义时，UX 可以标记：

```text
business_model_conflict_candidate
```

如果冲突影响对象、动作、状态、权限、责任、审计或核心流程，UX 应创建：

```yaml
trigger_type: cross_cluster_conflict
source_cluster: design-engineering
target_cluster: business-modeling
```

---

## 7. 不创建 Trigger 的情况

以下通常不是业务模型问题：

```text
间距、色彩、字体、圆角、图标风格
布局密度、响应式断点、视觉层级
Reference Library 选择
Color Card 选择
Tab 切换、展开 / 收起、排序、筛选、复制链接
确认弹窗中的通用“确定”按钮
纯展示文案优化，且不改变用户对业务结果的理解
```

这些情况由 Design Engineering Harness 自己处理，不创建 `MT-xxx.md`。

---

## 8. 完成封存规则

UX Work Item 在 `completion-approval` 前必须检查：

```text
1. 是否存在 unresolved business_model_gap_candidate；
2. 是否存在 unresolved business_model_conflict_candidate；
3. 是否存在与本 Work Item 绑定的 open / awaiting_human Model Trigger；
4. 是否把未确认业务能力作为 confirmed 产品行为实现；
5. 是否会改变权限、状态、责任、审计或核心流程。
```

如果存在 D2 / D3 级别问题，UX 可以继续低保真探索或暂停相关范围，但不得 `completed + sealed`。

---

## 9. 编译责任

`downstream-view-compiler` 负责生成该上下文包。

编译器必须：

```text
- 标注每条内容的 status；
- 标注来源文件；
- 区分 confirmed 与 provisional；
- 保留 open model triggers；
- 不把下游 UX 结论反向写为 confirmed 业务模型；
- 当核心模型缺失导致上下文包无法完整生成时，在 Open Gaps 中说明。
```

---

## 10. 与 Human Decision Control Plane 的关系

上下文包可以暴露缺口和冲突，但不能代替人类做高影响业务判断。

以下情况仍必须进入 Human Decision Control Plane：

```text
业务对象身份互斥
业务动作是否存在
状态生命周期多方案
权限、责任、审计、合规规则
将 provisional 模型升级为 confirmed
允许 UX 将未确认业务能力进入生产实现或封存
```

---

## 11. 最小评测要求

### 11.1 Context Pack 是派生视图

Given: 业务模型存在 confirmed 对象和动作。  
When: 编译 `ux-business-model-context.*`。  
Then: 输出内容带 status 和来源路径；不得成为 source of truth。

### 11.2 UX 启动不被缺失上下文阻断

Given: 项目没有 `ux-business-model-context.*`。  
When: UX Work Item 启动。  
Then: UX 记录 context absent 并继续，不强行中断。

### 11.3 UX 发现缺口只创建候选

Given: UX 需要“申请延期”，Context Pack 没有对应动作。  
When: 该入口影响状态或审批。  
Then: 创建 `downstream_gap` Trigger，标记为 candidate，不直接确认业务动作。

### 11.4 UX 发现 confirmed 冲突

Given: Context Pack 中 confirmed 规则为“审批人不能审批自己提交的工单”。  
When: UX 允许提交人自审。  
Then: 创建 `cross_cluster_conflict` Trigger，并阻断该交互进入 sealed。
