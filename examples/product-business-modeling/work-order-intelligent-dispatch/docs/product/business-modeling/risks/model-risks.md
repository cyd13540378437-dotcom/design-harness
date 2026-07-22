# Model Risks

| Risk ID | 风险 | 当前处理 | Status |
|---|---|---|---|
| MR-001 | `ServiceResource` 同时覆盖个人、班组、岗位和外包，未来可能过宽 | 保持 provisional，并由 BMD-002 决定是否拆分 | open |
| MR-002 | 自动派单责任边界尚未确认 | 第一阶段仅推荐 + 人工确认 | open |
| MR-003 | 仅优化利用率可能伤害 SLA、加班和应急缓冲 | 规则中保留多目标护栏 | mitigated |
| MR-004 | 冷启动没有历史证据，无法证明策略有效 | 第一阶段保留决策快照与执行反馈 | mitigated |
| MR-005 | 可维护资产的粒度可能因行业场景变化 | 当前使用 MaintainableAsset；后续按系统 / 构件演进 | open |
