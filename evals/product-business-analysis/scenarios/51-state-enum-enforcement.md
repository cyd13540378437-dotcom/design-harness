# State 枚举强校验

## Given / 已知
用户确认验证路线并追问 M0。

## When / 当
系统更新 State。

## Then / 则
只允许合法 phase / gate。不得出现 `simulator-design`、`m0_manual_simulation_design` 等自定义值。澄清完成后应为 `completion-review + none`。
