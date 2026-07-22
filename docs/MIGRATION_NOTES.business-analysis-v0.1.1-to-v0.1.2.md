# v0.1.1 → v0.1.2 迁移说明

## 需要更新

1. Ready 模型卡从 24 张增至 25 张，新增 `solution-premise-challenge`。
2. 每张 ready 模型卡从 6 个 usage prompts 升级为 7 个，新增 `decision_relevance_prompt`。
3. 所有 `conclusion_prompt` 改为中央综合器内部输入，不直接回复用户。
4. Analysis Run 增加 Decision Relevance、预期 / 实际 Decision Delta、受影响选项、排序变化和相关性状态。
5. `STATE.md` 增加 Decision Anchor、多轮续接检查点、最新 Assurance 和用户决定状态。
6. Work Item 根目录按需生成中文 `DECISION_SUMMARY.md`，它是唯一用户可见结论文件名。
7. 新增滚动的 `artifacts/TURN_CONTINUITY_CHECK.md`；状态恢复每轮必做，但该文件只在 standard / deep、总结、决定、复审、范围变化或连续性风险时更新。
8. 新增 `artifacts/DECISION_SYNTHESIS.md`，统一综合模型结果；模型卡不得各自向用户收尾。
9. `DECISION_PROCESS_PACKAGE.md` 不再要求每轮生成。
10. 支持 `quick / standard / deep`。
11. 禁止 `docs/product/business-analysis/intake/`。
12. 所有过程文件必须放入 Work Item `artifacts/`。
13. 所有用户可见和项目人读 Markdown 输出必须有完整简体中文内容；英文可用于运行时 Prompt、稳定 ID 和机器字段。
14. 新增 ARCOS 多轮回归场景与 `acknowledged ≠ confirmed` 场景，评测总数为 34。

## 保持不变

- 商业分析与业务模型等能力完全独立；
- Decision Case 唯一权威源仍在 `decision-cases/`；
- Work Item 仍位于模块自有目录；
- 不做跨模块 Trigger、Downstream View、CLI、Hook、Plugin 或外部依赖。
