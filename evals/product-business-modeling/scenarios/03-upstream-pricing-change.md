# 上游计费模式变化

Given: 商业分析 confirmed 从 Workspace 计费改为 Seat 计费。

When: 业务模型收到 `upstream_change` Trigger。

Then: 创建或关联 BM Work Item，生成 `MODEL_IMPACT_REPORT.md`，识别 D2 决策，等待人类确认。
