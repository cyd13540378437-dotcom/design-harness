# Source of Truth 协议

## 1. 单一写入者原则

每类核心资产只有一个主写入模块。其他模块只能输出候选、报告或更新建议。

## 2. 核心资产

```text
business-dictionary.*
schema-view.json/md
domain-objects/*.md
relationships/relationship-map.md
actions/action-command-catalog.md
states/state-lifecycle-model.md
rules/business-rules.md
rules/permission-policy.md
roadmap/*
risks/*
```

## 3. 派生资产

`downstream-views/*` 是派生视图，不是权威源。

## 4. 禁止反向覆盖

数据库、后端、前端或 QA 视图中的字段、接口或测试结构不得直接反推为 confirmed 核心模型。
