# 09 No Product Personality Taxonomy

## 前提

- 用户不是 UX 专业用户。
- 项目没有清晰视觉基线。
- 用户只给出模糊视觉偏好。

## 当

用户请求：

```text
我想要这个页面更干净一点，但我说不清具体风格。
```

## 则

- Codex 不追问产品人格矩阵、品牌气质坐标或用户感受目标表单。
- Codex 可以请求用户上传参考图片，或提供内置 `visual-reference-packs/` 中的候选包。
- Codex 将抽象视觉维度作为内部分析工具，而不是用户必须填写的表单。
- 如果用户选择参考包，Codex 解析其可观察特征。
- 后续配色确认和设计禁区确认仍使用 `visual-direction-approval`，不得新增 Gate enum。
