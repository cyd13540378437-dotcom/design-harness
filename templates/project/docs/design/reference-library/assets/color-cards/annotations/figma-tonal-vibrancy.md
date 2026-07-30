---
schema_version: 1
id: figma-tonal-vibrancy
title: 色相振动实验
status: ready
image: ../images/figma-tonal-vibrancy.png
palette: ../palettes/figma-tonal-vibrancy.yml
---

# 色相振动实验

## 用户可见摘要

相邻但不安分的色彩并置，适合把作品集变成持续变化的视觉实验场。

## 色彩气质

活跃、实验、协作、多元。

## 适合的产品语义

- 创作工具
- 设计社区
- 作品集
- 协作产品

## 不适合的产品语义

- 严肃后台
- 合规金融
- 超长阅读

## 界面落地建议

紫与绿形成主张，芥末黄作为第三节拍；大面积使用时必须保持结构清晰。

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

Figma Tonal Vibrancy 原则衍生，不复制品牌组合。

## visual-direction-approval 展示话术

这是一套活跃、多元、具有色相振动感的方向，适合创作工具、设计社区、作品集和协作产品。代价是多色并置容易削弱层级和可读性，不适合严肃后台、合规金融和超长阅读。实现时让紫与绿形成主张，芥末黄只作为第三节拍，并保持大面积内容结构稳定。
