---
schema_version: 1
id: blueprint-archive
title: 蓝晒档案
status: ready
image: ../images/blueprint-archive.png
palette: ../palettes/blueprint-archive.yml
---

# 蓝晒档案

## 用户可见摘要

暖灰纸面、普鲁士蓝和克制朱砂构成稳定对照组，具有档案、工程与编辑秩序。

## 色彩气质

档案、工程、编辑、克制。

## 适合的产品语义

- AI 设计工具
- 案例长页
- 研究档案
- 专业作品集

## 不适合的产品语义

- 夜间工作台
- 高饱和娱乐
- 儿童产品

## 界面落地建议

纸白承担长内容，普鲁士蓝建立导航与章节秩序，朱砂只用于关键判断和证据。

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

用户提供的 Yudi AI Lab 配色渐变升级实验稿：蓝晒档案。

## visual-direction-approval 展示话术

这是一套档案、工程、编辑秩序兼具的蓝晒方向，适合 AI 设计工具、案例长页、研究档案和专业作品集。代价是整体气质严肃克制，不适合夜间工作台、高饱和娱乐和儿童产品。实现时用纸白承载长内容，普鲁士蓝建立导航与章节秩序，朱砂只标记关键判断和证据。
