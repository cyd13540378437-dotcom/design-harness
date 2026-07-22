# Follow-up Turn Continuity / 多轮对话续接协议 v0.1.4

## 1. 回复前最小恢复集

```text
BUSINESS_ANALYSIS_WORK_ITEMS.md
STATE.md
Primary Decision Case（Choice Core + Scope Lock）
最近 DECISION_SUMMARY.md
DECISION_NOTES.md
最新 Claim-level Assurance
```

## 2. 双通道解释

每轮分别判断 `decision_signal` 与 `followup_request`，先处理决定，再处理追问。

## 3. 每轮必须回答

```text
Choice Loop 当前是 open / closed / reopened？
用户是否已经接受、拒绝、修改或暂缓？
追问是否仍在 Decision Scope 内？
是否需要 Choice Delta，还是只需概念澄清？
```

## 4. 关闭后的续接

Choice Loop 已关闭时：

```text
普通澄清 → 轻量回答，不运行模型，不新增选项；
实施细节 → 概念级边界说明，进入 completion-review；
新证据 / 新约束 → 正式 review，记录重开原因；
明确新商业问题 → new_decision_candidate。
```
