# 最终结论契约（Final Conclusion Contract）

当用户请求“最终结论”“总结建议”“把分析结论发我”，或本轮形成阶段性建议时，必须生成或更新 Case-bound 的中文 `DECISION_SUMMARY.md`。

## 必需元数据

```yaml
language: zh-CN
work_item_id: BA-xxx
primary_case_id: BA-DC-xxx
assurance_result: pass | warn | block
conclusion_status: draft | provisional | confirmed
user_decision_status: not_requested | pending | acknowledged | confirmed | rejected | revised
```

## 必需内容

```text
当前确认的商业问题
比较过的真实业务选择
当前建议与成立条件
主要反方意见
能证明什么
不能证明什么
证据边界
验证和复审条件
来源 Case / Work Item / Assurance / Central Synthesis
用户当前需要确认的业务选择
```

## 生成前置

1. 读取活动 `STATE.md`、Primary Case 和最新 Assurance。
2. 读取 `artifacts/DECISION_SYNTHESIS.md`；若不存在，先完成中央综合。
3. 确认用户表达是 `acknowledged` 还是 `confirmed`。
4. 若 Assurance 为 `block`，不得输出最终方案推荐，只能输出下一步决策选择。

## 结尾规则

最后一段必须回到用户的业务选择，而不是以 Case、模型、文件或流程管理收尾。

例如：

> 现在需要确认的是：是否接受“第一阶段只验证相对策略稳健性，不证明真实业务效果”这一证据边界，并选择先做轻量合成场景策略实验台。
