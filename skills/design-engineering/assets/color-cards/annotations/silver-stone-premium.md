---
schema_version: 1
id: silver-stone-premium
title: 银石高级冷调
status: ready
image: ../images/silver-stone-premium.png
palette: ../palettes/silver-stone-premium.yml
---

# 银石高级冷调

## 用户可见摘要

适合做“精密、干净、有质感”的产品视觉。

## 色彩气质

这套色卡的主要气质是：冷静、高级、现代、留白。它在视觉上适合建立清晰的第一印象，同时保留足够的产品可用性边界。用于正式界面时，应把颜色当作产品语义和状态层级的一部分，而不是单纯装饰。

## 适合的产品语义

- 建筑
- 设计
- 硬件
- B2B 品牌站
- 高级 SaaS

## 不适合的产品语义

- 温暖生活服务
- 社区和活动页
- 不适合需要强烈品牌冲击、短时转化刺激或高度娱乐化的主视觉。

## 界面落地建议

适合大留白、强排版、少量高质感强调色；不要把金色、红棕或深色铺满复杂操作界面。

建议把最深色阶用于文字、导航、主行动或视觉锚点，把中间色阶用于链接、图表和模块重点，把最浅色阶用于页面底色、卡片底色和空状态。彩色面积越大，越需要降低饱和度或提高留白比例。

## Token 转化建议

深银灰做文字，冷石灰做边界和模块，冷白底保留高级留白。

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

这是一套冷静、高级、现代、留白的配色方向。适合做“精密、干净、有质感”的产品视觉。适合：建筑、设计、硬件、B2B 品牌站、高级 SaaS。不适合：温暖生活服务、社区和活动页；实现时需要按风险等级检查文字、按钮、边界和状态反馈的对比度。
