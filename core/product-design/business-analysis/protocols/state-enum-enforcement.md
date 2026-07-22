# State Enum Enforcement / 状态枚举强校验 v0.1.4

## 1. 允许枚举

```text
status:
active | paused | completed | cancelled

phase:
input-understanding | case-routing | choice-set | analysis |
recommendation | human-decision | post-decision-clarification |
review | completion-review | complete

gate:
none | decision-confirmation | completion-approval
```

## 2. 典型非法值

```text
simulator-design
m0_manual_simulation_design
pricing-implementation
dashboard-build
script-execution
```

业务主题、实验阶段或实施步骤不得被写成基础状态机 phase / gate。

## 3. 关键迁移

```text
用户确认方案，无后续问题
→ phase=completion-review, gate=none

用户确认方案，并询问概念
→ phase=post-decision-clarification, gate=none
→ 回答后 phase=completion-review

新证据改变决定
→ phase=review, choice_loop_status=reopened

用户批准关闭
→ status=completed, phase=complete, gate=none, sealed=true
```
