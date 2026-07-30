---
schema_version: 1
id: blueprint-mist
title: 蓝晒雾光
status: ready
image: ../images/blueprint-mist.png
palette: ../palettes/blueprint-mist.yml
---

# 蓝晒雾光

## 用户可见摘要

在蓝晒档案的秩序上加入雾蓝、纸白与黄铜环境光，空间更柔和但仍然克制。

## 色彩气质

雾光、档案、理性、空间感。

## 适合的产品语义

- AI 设计工具
- 产品案例
- 知识系统
- 专业作品集

## 不适合的产品语义

- 纯暗色终端
- 强促销页面
- 高饱和社群

## 界面落地建议

渐变只制造章节呼吸和边缘光，内容卡片继续使用稳定纸面，黄铜光不得承担正文层级。

渐变仅用于画布环境光和低透明面板反射，正文区域、表单、按钮与长内容必须保留稳定纯色底。

## Token 转化建议

```yaml
color.primary: primary
color.secondary: secondary
color.accent: accent
color.surface.tint: soft_background
color.background: page_background
```

## 无障碍与可读性风险

风险等级：low。

- 正式实现需检查正文、按钮、细线、标签和禁用态。
- 不得仅依靠颜色表达状态或优先级。

## 来源

用户提供的 Yudi AI Lab 配色渐变升级实验稿：蓝晒雾光。

## visual-direction-approval 展示话术

这是一套理性、克制、带雾光空间感的档案方向，适合 AI 设计工具、产品案例、知识系统和专业作品集。代价是环境光和黄铜高光不适合纯暗色终端、强促销和高饱和社群。实现时让渐变只制造章节呼吸和边缘光，内容卡片保持稳定纸面，黄铜光不承担正文层级。
