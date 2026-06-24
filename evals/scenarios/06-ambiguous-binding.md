# 06. 模糊绑定

## 前提

- `DE-002` active，负责内容模块文本换行。
- `DE-003` active，负责标签管理面板。
- 两者都包含可见界面修改。

## 当

用户说：

```text
继续之前的界面改动。
```

## 则

- `design_state_steward` 返回 `AMBIGUOUS`。
- 列出 `DE-002` 和 `DE-003` 作为候选项。
- 只有在有证据时才推荐最可能的候选项。
- 向用户提问并等待选择。
- 不创建或修改任何 `STATE.md`。
- 不更新 `WORK_ITEMS.md`。

预期决定：

```yaml
decision: AMBIGUOUS
current_state: ""
new_state: ""
candidates:
  - "DE-002"
  - "DE-003"
reason: "用户请求缺少足够任务身份信息，两个 active Work Item 都可能匹配。"
user_question: "你想继续 DE-002 的内容模块换行，还是 DE-003 的标签管理面板？"
recommended_action: "等待用户选择后再恢复对应状态。"
```

