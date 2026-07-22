# 已确认 Summary 不重复请求选择

## Given / 已知
user_decision_status=confirmed，choice_loop_status=closed。

## When / 当
系统生成 Decision Summary。

## Then / 则
summary_mode 必须是 `decision_confirmed` 或 `post_decision_clarification`；不得再次要求“接受 / 拒绝 / 修改 / 暂缓”同一选择。
