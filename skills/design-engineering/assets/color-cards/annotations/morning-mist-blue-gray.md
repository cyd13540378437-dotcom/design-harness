---
schema_version: 1
id: morning-mist-blue-gray
title: 晨雾蓝灰
status: ready
image: ../images/morning-mist-blue-gray.png
palette: ../palettes/morning-mist-blue-gray.yml
---

# 晨雾蓝灰

## 用户可见摘要

适合做干净、可信、不打扰的产品界面。

## 色彩气质

这套色卡的主要气质是：清晨、安静、可信、轻盈。它在视觉上适合建立清晰的第一印象，同时保留足够的产品可用性边界。用于正式界面时，应把颜色当作产品语义和状态层级的一部分，而不是单纯装饰。

## 适合的产品语义

- 健康
- 天气
- 记录
- 阅读
- 轻量工作台

## 不适合的产品语义

- 需要强烈品牌记忆和冲动转化的页面
- 不适合需要强烈品牌冲击、短时转化刺激或高度娱乐化的主视觉。

## 界面落地建议

适合通过浅底、柔和分区和低饱和状态色降低压力；关键行动仍需保留足够明确的主色。

建议把最深色阶用于文字、导航、主行动或视觉锚点，把中间色阶用于链接、图表和模块重点，把最浅色阶用于页面底色、卡片底色和空状态。彩色面积越大，越需要降低饱和度或提高留白比例。

## Token 转化建议

蓝灰做文字和导航，晴空蓝做行动，薄雾蓝做卡片/阅读区底。

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

这是一套清晨、安静、可信、轻盈的配色方向。适合做干净、可信、不打扰的产品界面。适合：健康、天气、记录、阅读、轻量工作台。不适合：需要强烈品牌记忆和冲动转化的页面；实现时需要按风险等级检查文字、按钮、边界和状态反馈的对比度。
