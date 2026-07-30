---
schema_version: 1
id: twilight-archive
title: 暮色档案
status: ready
image: ../images/twilight-archive.png
palette: ../palettes/twilight-archive.yml
---

# 暮色档案

## 用户可见摘要

暖纸白、普鲁士蓝、朱砂与黄铜形成冷暖融合，兼顾技术秩序和作者判断。

## 色彩气质

暮色、档案、融合、高级。

## 适合的产品语义

- AI 设计工具
- 复杂产品案例
- 研究作品集
- 文化科技

## 不适合的产品语义

- 纯暗色终端
- 儿童产品
- 高频促销

## 界面落地建议

普鲁士蓝负责系统秩序，朱砂只标记人的判断，黄铜作为低频光源，避免平均铺色。

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

用户提供的 Yudi AI Lab 配色渐变升级实验稿：暮色档案。

## visual-direction-approval 展示话术

这是一套冷暖融合、兼顾系统秩序与作者判断的暮色档案方向，适合 AI 设计工具、复杂产品案例、研究作品集和文化科技。代价是多重强调色需要严格分工，不适合纯暗色终端、儿童产品和高频促销。实现时由普鲁士蓝负责系统秩序，朱砂只标记人的判断，黄铜作为低频光源。
