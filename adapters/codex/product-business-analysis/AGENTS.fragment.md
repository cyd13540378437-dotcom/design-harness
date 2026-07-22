# Product Business Analysis Adapter v0.1.2

当用户请求商业决策支持时：

1. 读取 `core/product-design/business-analysis/SKILL.md` 及其协议。
2. 只使用 `docs/product/business-analysis/` 下的项目资产。
3. 完整保留用户第一次输入，输入理解确认前不得路由或推荐具体解法。
4. 若存在相关 BA Work Item，每轮回复前先读取 `STATE.md`、Primary Decision Case、最新 Assurance、Decision Notes 和最近结论。
5. 恢复并维护 Decision Anchor；不允许多轮对话退化成普通无状态建议。
6. 用户带着具体解法进入时，先比较不做、更小验证、用户方案和更重方案。
7. 所有过程文件写入 `work-items/BA-xxx/artifacts/`；不得创建独立 `intake/` 目录。
8. Decision Case 只在 `decision-cases/` 保留一份权威文件。
9. 使用 Analysis Model Cards 前执行 `decision_relevance_prompt`；每个 Analysis Run 记录 Decision Delta。
10. 模型卡的 `conclusion_prompt` 只供统一决策综合器内部使用，不能由各模型直接回复用户。
11. 输出前执行反方分析和 Decision Assurance；最终结论必须绑定 Case、Work Item、Assurance 和用户决定状态。
12. 所有用户回复和项目级人读 Markdown 输出默认使用简体中文。
13. 将 “acknowledged” 与 “confirmed” 严格区分；D2 / D3 用户决定写入 `DECISION_NOTES.md`。
14. 不读取、修改、触发或创建任何兄弟能力资产。
15. 不创建共享 Work Item 目录、跨能力 Trigger 或 Downstream View。
