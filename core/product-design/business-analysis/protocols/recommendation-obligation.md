# Recommendation Obligation / 推荐义务 v0.1.4

## 1. Choice Loop 打开时

阶段性结论必须给出当前最佳推荐。证据不完整时可以是 `provisional` 或 `conditional`。

## 2. Choice Loop 关闭时

推荐义务变为“忠实保存已确认决定”，不得继续提出同层或更低层的新推荐。

## 3. 推荐必须包含

```text
recommended_option
recommendation_status
rationale
accepted_tradeoffs
evidence_boundary
change_conditions
```

## 4. 不合法行为

- 证据不足时不推荐任何路径；
- 用户已经确认后又继续问同一选择；
- 把实施细节包装成新的商业推荐。
