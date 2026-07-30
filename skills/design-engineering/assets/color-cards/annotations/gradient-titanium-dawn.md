---
schema_version: 1
id: gradient-titanium-dawn
title: 渐变：钛金属晨光
status: ready
image: ../images/gradient-titanium-dawn.png
palette: ../palettes/gradient-titanium-dawn.yml
---

# 渐变：钛金属晨光

## 用户可见摘要

冷银、雾蓝和极淡紫灰构成明亮金属反射，兼顾科技感与阅读清晰度。

## 色彩气质

钛金属、晨光、明亮、精密。

## 适合的产品语义

- 高级 SaaS
- 硬件品牌
- 设计系统
- 技术作品集

## 不适合的产品语义

- 强娱乐
- 复古文化
- 自然手作

## 界面落地建议

大面积近白保持内容清晰，蓝紫只模拟金属反射。

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

Yudi AI Lab 项目定制浅色金属渐变。

## visual-direction-approval 展示话术

这是一套明亮、精密、带钛金属晨光感的浅色方向，适合高级 SaaS、硬件品牌、设计系统和技术作品集。代价是冷白与金属灰容易显得疏离，浅色边界也需要额外对比验证。实现时以稳定浅色表面承载内容，金属渐变只用于环境层和低频高光。
