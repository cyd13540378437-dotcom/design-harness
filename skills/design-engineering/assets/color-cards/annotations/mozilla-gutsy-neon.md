---
schema_version: 1
id: mozilla-gutsy-neon
title: 黑白霓虹宣言
status: ready
image: ../images/mozilla-gutsy-neon.png
palette: ../palettes/mozilla-gutsy-neon.yml
---

# 黑白霓虹宣言

## 用户可见摘要

黑白主体配少量霓虹色块，适合需要强烈态度和传播感的品牌页面。

## 色彩气质

大胆、直接、霓虹、宣言感。

## 适合的产品语义

- 品牌发布
- 实验项目
- 创意社区
- 活动页面

## 不适合的产品语义

- 长期工作台
- 复杂表单
- 低刺激阅读

## 界面落地建议

黑白占据主要阅读区域，深紫建立纵深，霓虹绿和柠檬黄严格限制在关键块。

主色与强调色需要按视觉优先级使用，不要把所有色阶平均铺开。

## Token 转化建议

```yaml
color.primary: primary
color.secondary: secondary
color.accent: accent
color.surface.tint: soft_background
color.background: page_background
```

## 无障碍与可读性风险

风险等级：high。

- 正式实现需检查正文、按钮、细线、标签和禁用态。
- 不得仅依靠颜色表达状态或优先级。

## 来源

Mozilla 黑白主色与霓虹辅助色原则衍生。

## visual-direction-approval 展示话术

这是一套大胆、直接、带霓虹宣言感的配色方向，适合品牌发布、实验项目、创意社区和活动页面。代价是刺激强、持续阅读压力高，不适合长期工作台、复杂表单和低刺激阅读。实现时让黑白占据主要阅读区域，深紫建立纵深，霓虹绿与柠檬黄只用于关键块。
