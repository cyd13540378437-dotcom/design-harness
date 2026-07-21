# Entry Modes and Routing

入口模式和路由结果是两个不同维度。

## 1. 入口模式

```text
direct_decision_support       用户提出新的业务问题或选择
case_continuation             用户继续已有 Case
 evidence_intake               用户主要补充材料、数据或附件
 decision_review               用户复盘、挑战或重开旧决定
project_decision_extraction   从现有项目材料恢复候选决策
assurance_validation          对既有分析执行质量检查
```

入口模式决定本次工作的主要目标。

## 2. 路由结果

输入理解确认后，路由只能为：

```text
create_new_case
continue_existing_case
add_evidence_to_case
reopen_existing_decision
conflict_with_existing_decision
impact_existing_decision
no_case_needed
```

路由描述当前输入与已有 Decision Case 的关系。

## 3. 顺序约束

```text
保留原始输入
→ Input Understanding
→ 用户确认或明确 provisional 假设
→ 读取本模块 Decision Case Index
→ Routing
```

不得在输入理解阶段读取其他能力资产来路由。

## 4. no_case_needed

适用于：

- 纯解释；
- 一次性低风险脑暴且用户不需要持久记录；
- 只读查看本模块资产；
- 没有决策价值的零散信息。

不得为了流程完整而强制创建 Case。
