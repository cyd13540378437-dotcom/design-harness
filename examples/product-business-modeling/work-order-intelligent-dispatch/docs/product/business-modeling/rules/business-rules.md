# Business Rules

> Bound IDs exist in the business dictionary, action catalog or lifecycle files.

| Rule ID | Rule | Bound Object IDs | Bound Action IDs | Bound State IDs | Impact | Status |
|---|---|---|---|---|---|---|
| `BR-001` | 只有满足全部硬性要求的资源才能进入可推荐候选。 | `work_requirement`, `dispatch_candidate` | `ACT-002` | — | critical | provisional |
| `BR-002` | SLA 与安全约束是护栏，不得仅作为低权重排序项。 | `dispatch_policy`, `dispatch_candidate` | `ACT-002` | — | critical | provisional |
| `BR-003` | 人工覆盖系统推荐必须记录结构化原因。 | `dispatch_decision` | `ACT-005` | `dispatch_decision.overridden` | high | provisional |
| `BR-004` | 已 committed 的决策不能直接改写；重派应形成新决策与新责任。 | `dispatch_decision`, `assignment` | `ACT-014` | `dispatch_decision.committed`, `assignment.reassignment_requested` | critical | provisional |
| `BR-005` | 执行记录不得替代派工决策或 Assignment。 | `execution_record`, `dispatch_decision`, `assignment` | `ACT-013` | `assignment.finished` | high | provisional |
| `BR-006` | 策略评估必须同时观察 SLA、加班、应急缓冲、重派和返工。 | `dispatch_evaluation_snapshot` | `ACT-013`, `ACT-016` | — | high | provisional |
| `BR-007` | 候选排除原因必须可解释。 | `dispatch_candidate` | `ACT-002` | — | high | provisional |
| `BR-008` | 决策快照必须保留当时候选、排序、最终选择和执行结果。 | `dispatch_evaluation_snapshot`, `dispatch_decision` | `ACT-007` | `dispatch_decision.committed` | high | provisional |

## Invariants

- 决策对象与责任对象不可合并生命周期。
- 已形成的历史责任和决策证据不得被重派操作覆盖。

## Human Decisions Required

- `BMD-004`：护栏与优化目标的正式优先级。
- `BMD-005`：第一期是否保存完整决策快照。
