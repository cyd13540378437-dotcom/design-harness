# Source Evidence

## Evidence Summary

本任务是 Greenfield Modeling。用户目标是 confirmed input；早期实验资产和冷启动判断只作为 provisional / legacy evidence。

## Confirmed Sources

| Source | Type | Location | Relevant Excerpt | Confidence |
|---|---|---|---|---|
| 用户需求 | direct input | conversation | 准备开发设备设施工单智能调度产品 | high |

## Provisional Sources

| Source | Type | Location | Relevant Excerpt | Confidence |
|---|---|---|---|---|
| 既有业务分析 | contextual evidence | legacy BA artifact | 冷启动缺少历史数据，不能证明策略有效 | medium |
| 早期业务模型实验 | legacy model input | prior `docs.zip` | 已提出候选、决策、责任与评估快照链 | medium |

## Conflicts

- 早期实验把 `Asset / Facility` 合并为一个身份；v0.2.3 将其修正为 `MaintainableAsset` 与 `ServiceLocation`。
- 早期 Assignment 生命周期包含决策前状态；v0.2.3 将 Dispatch Decision 与 Assignment 生命周期分离。

## Open Questions

`BMD-001`–`BMD-005`。
