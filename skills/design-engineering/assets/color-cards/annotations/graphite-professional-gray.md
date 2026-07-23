---
schema_version: 1
id: graphite-professional-gray
title: 石墨专业灰
status: ready
image: ../images/graphite-professional-gray.png
palette: ../palettes/graphite-professional-gray.yml
---

# 石墨专业灰

## 用户可见摘要

适合信息密度高、需要降低视觉噪音的工具。

## 色彩气质

这套色卡的主要气质是：克制、理性、专业、低噪。它在视觉上适合建立清晰的第一印象，同时保留足够的产品可用性边界。用于正式界面时，应把颜色当作产品语义和状态层级的一部分，而不是单纯装饰。

## 适合的产品语义

- 开发者工具
- 企业后台
- 复杂配置
- 文档系统

## 不适合的产品语义

- 需要强情绪记忆点的新消费品牌
- 不适合不做层级控制就直接铺满复杂后台；需要在品牌感和可读性之间做取舍。

## 界面落地建议

适合把导航、主行动和关键状态做得清楚稳定；页面结构应克制，避免大量装饰抢走任务信息。

建议把最深色阶用于文字、导航、主行动或视觉锚点，把中间色阶用于链接、图表和模块重点，把最浅色阶用于页面底色、卡片底色和空状态。彩色面积越大，越需要降低饱和度或提高留白比例。

## Token 转化建议

石墨灰做文字和导航，中灰蓝做层级，冷白灰做工具型页面底。

可优先映射为：

```yaml
color.primary: primary
color.secondary: secondary
color.accent: accent
color.surface.tint: soft_background
color.background: page_background
```

## 无障碍与可读性风险

风险等级：中。

- 中等风险：浅色底上的彩色小字、细线和禁用态需要单独验证对比度。
- 主 CTA 建议优先使用最深色阶或高饱和强调色，避免只用浅色承担关键行动。

## visual-direction-approval 展示话术

这是一套克制、理性、专业、低噪的配色方向。适合信息密度高、需要降低视觉噪音的工具。适合：开发者工具、企业后台、复杂配置、文档系统。不适合：需要强情绪记忆点的新消费品牌；实现时需要按风险等级检查文字、按钮、边界和状态反馈的对比度。
