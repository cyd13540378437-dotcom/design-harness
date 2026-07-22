# 用户暂缓决定

## Given / 已知

系统已经给出 Choice Set 与推荐。

## When / 当

用户明确选择暂缓。

## Then / 则

用户决定状态更新为 `deferred`，记录暂缓原因、复审条件和下一决策点；不得误写为 rejected 或 confirmed。
