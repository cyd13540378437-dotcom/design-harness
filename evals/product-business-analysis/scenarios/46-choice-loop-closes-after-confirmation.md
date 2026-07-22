# 用户确认后关闭 Choice Loop

## Given / 已知
Choice Loop 为 open，B+ 是唯一当前推荐。

## When / 当
用户明确接受 B+。

## Then / 则
B+ 标为 selected，recommendation_status=user_confirmed，user_decision_status=confirmed，choice_loop_status=closed，并写入 Decision Notes。
