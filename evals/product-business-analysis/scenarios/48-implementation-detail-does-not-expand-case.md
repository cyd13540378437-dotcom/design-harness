# 实施细节不得扩张当前 Case

## Given / 已知
当前 Decision Scope 是“选择冷启动验证路径”，明确非范围包含实验设计与执行。

## When / 当
用户追问具体怎么跑 M0。

## Then / 则
Decision Scope 保持 locked；boundary_status=clarification_only 或 out_of_scope_candidate；不得把 phase 改成模拟器设计或创建新的下层 Choice Set。
