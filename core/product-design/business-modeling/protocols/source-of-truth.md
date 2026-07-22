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

## 3. 机器索引与维护索引

```text
BUSINESS_MODEL_INDEX.yml = 机器索引
BUSINESS_MODEL_INDEX.md  = 模型维护者导航
```

两者不替代核心资产，也不是普通用户入口。

## 4. 用户默认编译视图

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

它是面向 product owner 的派生视图：

```text
is_default_user_entry: true
is_source_of_truth: false
```

它由 `downstream-view-compiler` 维护。冲突时以核心资产为准，并重新编译总览。

## 5. 下游派生资产

`business-modeling/downstream-views/*` 是面向产品表达、需求、数据库、后端、前端、QA 和 UX 的派生视图，不是权威源。

## 6. 任务级权威记录

```text
STATE.md                  当前任务恢复快照
MODELING_CONSUMPTION.md   本次消费来源、假设和缺口
MODELING_OUTPUT.md        本次发生的模型变化
DECISION_NOTES.md         D2 / D3 决策审计记录
artifacts/*               证据、影响、解析和一致性报告
```

任务级文件不替代长期模型资产。

## 7. 禁止反向覆盖

数据库、后端、前端、QA 或用户总览中的字段、接口、实现结构和摘要不得直接反推为 confirmed 核心模型。

## 8. 禁止替代文件协议

`PROPOSED_MODEL.md`、`EVIDENCE_AND_ASSUMPTIONS.md` 视为 legacy aliases：新运行不得生成，也不得用它们替代标准的 `MODELING_OUTPUT.md` 与 `SOURCE_EVIDENCE.md`。读取旧项目时可以将其作为迁移输入；确有不同职责的自定义 artifact 必须使用不与 canonical 文件重叠的名称和目的。
