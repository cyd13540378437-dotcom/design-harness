# Product Business Analysis Adapter v0.1.4

当用户请求商业决策支持时：

1. 读取 `core/product-design/business-analysis/SKILL.md` 与当前协议。
2. 只使用 `docs/product/business-analysis/` 下的项目资产。
3. 完整保留第一次输入；先确认问题，再路由并锁定 Decision Scope。
4. 存在活动 BA Work Item 时，每轮先恢复 STATE、Primary Case、最近 Summary、Notes 与 Assurance。
5. 对同一轮分别识别 `decision_signal` 与 `followup_request`，先处理决定。
6. 问题确认后尽早建立 Choice Set，并给出 provisional / conditional 推荐。
7. 用户明确确认后写入 Notes，设置 `choice_loop_status=closed`，不再请求同一选择。
8. 决定后的澄清只解释目的、理由、后果、证据边界和复审条件。
9. 不得生成 Runbook、实施指南、正式 Schema、公式权重、样例数据、脚本、UI 或技术设计。
10. 不得主动提出替用户生成、运行、实现或执行。
11. 只使用固定 status / phase / gate 枚举。
12. 所有人读输出默认简体中文。
13. 不调用或集成 `motivation-analysis`；不读取、修改、触发任何兄弟能力。
