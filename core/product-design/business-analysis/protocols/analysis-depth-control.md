# Analysis Depth Control / 分析深度控制 v0.1.4

## quick

对话优先。低影响问题可只生成 Choice Set 与推荐；需要持久化时更新 Case / Summary。

## standard

适用于多轮问题。默认核心文件：

```text
STATE.md
Decision Case
ANALYSIS_WORKSPACE.md（按需）
DECISION_SUMMARY.md
DECISION_NOTES.md（按需）
```

## deep

重大投资、战略、合规、不可逆或多人决策时，才生成完整审计材料。

## 决定确认后

无论之前使用何种深度，Choice Loop 关闭后都切换为轻量续接：仅更新 Case、State、Notes 和必要 Summary。不得因为原先是 `deep` 就继续创建实施性产物。

## 禁止

输出物数量不能替代分析质量，也不能成为跨越 Decision Scope 的理由。
