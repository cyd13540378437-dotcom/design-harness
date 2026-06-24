# 01. 上下文检查不创建状态

## 前提

- 业务项目已经有 `docs/design/WORK_ITEMS.md`。
- 没有与只读检查相关的 active Work Item。

## 当

用户说：

```text
检查项目上下文，不要修改文件。
```

## 则

- `design_state_steward` 返回 `NO_STATE`。
- 不创建新的 `docs/design/work-items/<id>/STATE.md` 目录。
- 父级 Agent 汇报项目上下文，不进入设计 Gate。

预期返回格式：

```yaml
decision: NO_STATE
current_state: ""
new_state: ""
candidates: []
reason: "只读上下文检查没有独立验收任务。"
user_question: ""
recommended_action: "完成只读检查并向用户汇报。"
```

