---
schema_version: 1
id: clay-terracotta-community
title: 陶土社群暖色
status: ready
image: ../images/clay-terracotta-community.png
palette: ../palettes/clay-terracotta-community.yml
---

# 陶土社群暖色

## 用户可见摘要

适合强调真实、手作和人际连接的产品。

## 色彩气质

这套色卡的主要气质是：质朴、温暖、社群、手作感。它在视觉上适合建立清晰的第一印象，同时保留足够的产品可用性边界。用于正式界面时，应把颜色当作产品语义和状态层级的一部分，而不是单纯装饰。

## 适合的产品语义

- 社区
- 手工艺
- 餐饮
- 线下活动
- 创作者品牌

## 不适合的产品语义

- 高冷科技
- 高级金融
- 医疗严肃场景
- 不适合不做层级控制就直接铺满复杂后台；需要在品牌感和可读性之间做取舍。

## 界面落地建议

适合在欢迎区、服务入口、社区卡片和空状态中使用暖色，行动按钮保持明确但不过度销售化。

建议把最深色阶用于文字、导航、主行动或视觉锚点，把中间色阶用于链接、图表和模块重点，把最浅色阶用于页面底色、卡片底色和空状态。彩色面积越大，越需要降低饱和度或提高留白比例。

## Token 转化建议

陶土色做品牌锚点，砖橘做行动和标签，沙陶浅底承接社区内容。

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

这是一套质朴、温暖、社群、手作感的配色方向。适合强调真实、手作和人际连接的产品。适合：社区、手工艺、餐饮、线下活动、创作者品牌。不适合：高冷科技、高级金融、医疗严肃场景；实现时需要按风险等级检查文字、按钮、边界和状态反馈的对比度。
