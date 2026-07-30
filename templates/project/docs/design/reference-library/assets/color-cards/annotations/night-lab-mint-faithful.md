---
schema_version: 1
id: night-lab-mint-faithful
title: 旧版复原：夜间实验室
status: ready
image: ../images/night-lab-mint-faithful.png
palette: ../palettes/night-lab-mint-faithful.yml
---

# 旧版复原：夜间实验室

## 用户可见摘要

近黑绿、奶白、灰褐和低亮薄荷绿共同形成克制的编辑器实验室。

## 色彩气质

夜间、编辑器、实验室、克制。

## 适合的产品语义

- AI 实验室
- 开发者作品集
- 研究工具
- 技术叙事

## 不适合的产品语义

- 高饱和营销
- 儿童产品
- 明亮生活服务

## 界面落地建议

近黑绿承担画布，奶白用于标题，薄荷绿只表示运行、索引和主行动。

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

风险等级：low。

- 正式实现需检查正文、按钮、细线、标签和禁用态。
- 不得仅依靠颜色表达状态或优先级。

## 来源

用户提供的旧版 Yudi AI Lab 截图提取。

## visual-direction-approval 展示话术

这是一套夜间、克制、具有编辑器实验室感的方向，适合 AI 实验室、开发者作品集、研究工具和技术叙事。代价是暗色环境和低亮薄荷绿不适合明亮生活服务、儿童产品或高饱和营销。实现时由近黑绿承担画布，奶白用于标题，薄荷绿只表示运行、索引和主行动。
