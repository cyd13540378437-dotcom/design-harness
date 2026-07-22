---
schema_version: 1
view_type: business_model_overview
audience: product_owner
is_default_user_entry: true
is_source_of_truth: false
source_model_version: "v0.1"
source_model_status: draft
validation_status: not_run
generated_at: "YYYY-MM-DDTHH:mm:ssZ"
generated_by: downstream-view-compiler
source_work_item: "BM-000"
source_assets:
  - docs/product/business-modeling/BUSINESS_MODEL_INDEX.yml
  - docs/product/business-modeling/business-dictionary.yml
  - docs/product/business-modeling/schema-view.json
---

# 业务模型总览

> 这是业务负责人、产品负责人和非建模专业用户的唯一默认阅读入口。详细模型资产、任务文件和报告继续按原协议保留，但用户通常不需要逐一阅读。

## 1. 一句话模型

用一句话说明产品解决的业务问题，以及从业务输入到业务结果的核心闭环。

## 2. 当前状态

- 当前模型版本：
- 模型知识状态：`draft | provisional | confirmed`
- 一致性校验：`not_run | passed | issues_found`
- 最近一次建模 Work Item：
- 最近更新时间：
- 当前可用于：

## 3. 产品边界

### 当前包含

-

### 当前不包含

-

## 4. 核心业务对象

| 对象 ID | 中文名称 | 业务责任 | 当前状态 |
|---|---|---|---|

## 5. 端到端业务流程

```text
业务输入
→ 核心处理
→ 人或系统作出决定
→ 形成业务责任
→ 执行与反馈
→ 评估与演进
```

## 6. 关键业务规则与权限

-

## 7. 当前版本的软件能力

### 本期建议实现

-

### 暂缓或明确非范围

-

## 8. 已确认、暂定与待确认判断

### 已确认

-

### 暂定（Provisional）

-

### 需要你确认的产品判断

当存在 D2 / D3 决策时，在这里完整压缩为用户可直接判断的内容。用户不应为了做决定而必须打开 `DECISION_NOTES.md`。

#### BMD-000 — <决策标题>

- **当前理解**：
- **为什么重要**：
- **方案 A**：
  - 优点：
  - 代价：
- **方案 B**：
  - 优点：
  - 代价：
- **推荐**：
- **请回复**：`选 A / 选 B / 我补充一个规则`

若无待确认判断，写明“当前无需要用户确认的高影响判断”。

## 9. 主要风险与观察点

-

## 10. 最近一次模型更新

- Work Item：
- 本次新增或修改：
- 一致性校验结果：
- 下游视图更新：

## 11. 维护说明（非必读）

- 本文件由 `downstream-view-compiler` 从详细业务模型资产编译生成。
- 本文件不是 source of truth；若与详细模型冲突，以 `docs/product/business-modeling/` 下的权威资产为准，并应立即重新编译本总览。
- `BUSINESS_MODEL_INDEX.md` 面向模型维护者，不是用户默认入口。
- Work Item 文件用于状态、证据、审计和变更追踪，不要求普通用户逐一阅读。
