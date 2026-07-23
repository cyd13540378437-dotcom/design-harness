---
schema_version: 1
id: low-noise-beige-gray
title: 低噪米灰
status: ready
image: ../images/low-noise-beige-gray.png
palette: ../palettes/low-noise-beige-gray.yml
---

# 低噪米灰

## 用户可见摘要

适合大多数长期使用的产品基础视觉。

## 色彩气质

这套色卡的主要气质是：克制、自然、稳定、柔和。它在视觉上适合建立清晰的第一印象，同时保留足够的产品可用性边界。用于正式界面时，应把颜色当作产品语义和状态层级的一部分，而不是单纯装饰。

## 适合的产品语义

- 管理后台
- 日程
- CRM
- 内部工具
- 运营工作台

## 不适合的产品语义

- 年轻社交
- 娱乐
- 强品牌营销
- 不适合需要强烈品牌冲击、短时转化刺激或高度娱乐化的主视觉。

## 界面落地建议

适合文档、知识库、设置页和长期工作台；需要通过字号、间距、边界和状态色补足层级。

建议把最深色阶用于文字、导航、主行动或视觉锚点，把中间色阶用于链接、图表和模块重点，把最浅色阶用于页面底色、卡片底色和空状态。彩色面积越大，越需要降低饱和度或提高留白比例。

## Token 转化建议

米灰深字做正文，沙米强调做轻行动，浅米底适合长期运营工作台。

可优先映射为：

```yaml
color.primary: primary
color.secondary: secondary
color.accent: accent
color.surface.tint: soft_background
color.background: page_background
```

## 无障碍与可读性风险

风险等级：低。

- 整体对比风险较低，但浅底上的次级文字仍需检查 WCAG 对比度。
- 大面积浅色背景应搭配足够深的正文色，避免低饱和灰字过淡。

## visual-direction-approval 展示话术

这是一套克制、自然、稳定、柔和的配色方向。适合大多数长期使用的产品基础视觉。适合：管理后台、日程、CRM、内部工具、运营工作台。不适合：年轻社交、娱乐、强品牌营销；实现时需要按风险等级检查文字、按钮、边界和状态反馈的对比度。
