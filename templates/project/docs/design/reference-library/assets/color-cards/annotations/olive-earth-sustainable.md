---
schema_version: 1
id: olive-earth-sustainable
title: 橄榄土地可持续
status: ready
image: ../images/olive-earth-sustainable.png
palette: ../palettes/olive-earth-sustainable.yml
---

# 橄榄土地可持续

## 用户可见摘要

适合表达责任感和自然材料感。

## 色彩气质

这套色卡的主要气质是：朴素、真实、环保、耐看。它在视觉上适合建立清晰的第一印象，同时保留足够的产品可用性边界。用于正式界面时，应把颜色当作产品语义和状态层级的一部分，而不是单纯装饰。

## 适合的产品语义

- 可持续
- 农业
- 公益
- 食品溯源
- 手工品牌

## 不适合的产品语义

- 高科技 AI
- 游戏
- 强金融安全
- 不适合不做层级控制就直接铺满复杂后台；需要在品牌感和可读性之间做取舍。

## 界面落地建议

适合自然叙事、健康内容、户外/环保产品和可持续品牌；按钮和状态色要避免过于“土”而显得老旧。

建议把最深色阶用于文字、导航、主行动或视觉锚点，把中间色阶用于链接、图表和模块重点，把最浅色阶用于页面底色、卡片底色和空状态。彩色面积越大，越需要降低饱和度或提高留白比例。

## Token 转化建议

土地橄榄做主色，干草绿做自然强调，亚麻底保持朴素真实。

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

这是一套朴素、真实、环保、耐看的配色方向。适合表达责任感和自然材料感。适合：可持续、农业、公益、食品溯源、手工品牌。不适合：高科技 AI、游戏、强金融安全；实现时需要按风险等级检查文字、按钮、边界和状态反馈的对比度。
