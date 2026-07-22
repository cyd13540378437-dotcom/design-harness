# Passive Trigger Interface 协议

## 1. 定义

Passive Trigger 是来自上游商业分析变化、下游模型缺口、横向冲突或内部发现的业务模型响应入口。

## 2. Trigger 类型

```text
upstream_change
downstream_gap
cross_cluster_conflict
internal_discovery
```

## 3. 生命周期

```text
open → triaged → in_progress → awaiting_human → resolved | dismissed | superseded
```

## 4. 去重

每个 Trigger 必须有 `dedupe_key`。语义相同的 Trigger 不应重复创建，应关联到已有 Trigger 或同一 BM Work Item。

## 5. 关闭条件

Trigger 只有在以下条件满足时才能 `resolved`；若 `dismissed` 或 `superseded`，也必须写明理由和替代目标：

1. 已完成影响分析；
2. 已执行安全自动更新或记录不可自动更新原因；
3. 必要的人类决策已记录；
4. 相关核心模型已更新或明确不更新；
5. 一致性校验已执行且没有未披露 error；
6. `docs/product/BUSINESS_MODEL_OVERVIEW.md` 已重新编译并反映决策与校验状态；
7. 必要的专业下游视图已重编译；
8. Follow-up Trigger 已创建或明确无需创建；
9. Resolution 区块已回写。
