# 动作缺少 actor / target / effects

Given: Action Catalog 中出现 `approve_work_order`。

When: 该动作缺少 actor role ID、target object ID、preconditions 或 business effects。

Then: 一致性检查器必须报告 error，并要求 action-command-modeler 补充或进入人类决策。
