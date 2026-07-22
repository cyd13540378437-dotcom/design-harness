# Business Model Index

> `BUSINESS_MODEL_INDEX.yml` 是机器可读注册表。本文件是详细资产导航；用户默认先看 [`BUSINESS_MODEL_OVERVIEW.md`](../BUSINESS_MODEL_OVERVIEW.md)。

## Current Model

- Model: 设备设施工单智能调度业务模型
- Version: `v0.1-provisional`
- Knowledge status: `provisional`
- Consistency: `passed`（0 blocking errors；5 pending decisions）

## Source-of-Truth Assets

| Knowledge | Asset |
|---|---|
| 业务语言 | `business-dictionary.yml` / `.md` |
| 对象与业务属性结构 | `schema-view.json` / `.md` |
| 对象画像 | `domain-objects/core-domain-objects.md` |
| 关系 | `relationships/relationship-map.md` |
| 动作 | `actions/action-command-catalog.md` |
| 生命周期 | `states/*.md` |
| 规则与权限 | `rules/*.md` |
| 路线与风险 | `roadmap/*`, `risks/*` |

## Derived Views

- `downstream-views/software-development-view.md`
- `downstream-views/ux-business-model-context.md`
