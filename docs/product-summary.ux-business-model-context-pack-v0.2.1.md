# 产品总结：UX Business Model Context Pack v0.2.1

本增量把“轻量业务模型上下文包”正式放入 Business Modeling Core。

它的作用不是让 UX 变成业务模型校验器，而是让 UX 在设计页面对象、CTA、状态反馈、权限提示和错误态时，有一个稳定、轻量的业务语义输入。

## 核心新增

```text
ux-business-model-context.md
ux-business-model-context.yml
```

二者位于：

```text
docs/product/business-modeling/downstream-views/
```

## 与 `ux-design-engineering-view.md` 的区别

```text
ux-business-model-context.*
= UX 启动和设计过程中读取的轻量语义输入。

ux-design-engineering-view.md
= 业务模型变化后，告诉 UX 哪些页面、流程、状态、权限可能受影响。
```

## UX 侧最小责任

UX 不确认业务模型，只发现两类候选问题：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

缺口映射为 `downstream_gap`，冲突映射为 `cross_cluster_conflict`。

## 为什么这版不做复杂语义差异分层

当前阶段产品还不是成熟多人业务团队的持续协作系统。过早引入 copy variant、presentation alias、ambiguous expression 等分层会增加 Agent 负担和用户理解成本。

本增量只保留最小闭环：

```text
轻量读取
发现缺口
发现 confirmed 冲突
不阻断探索
不允许未确认业务行为封存
```
