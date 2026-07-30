---
schema_version: 1
id: gradient-aubergine-plasma
title: 渐变：茄紫等离子
status: ready
image: ../images/gradient-aubergine-plasma.png
palette: ../palettes/gradient-aubergine-plasma.yml
---

# 渐变：茄紫等离子

## 用户可见摘要

酒红、茄紫和冷莓色形成暗色编辑感，在科技之外增加文化与作者性。

## 色彩气质

茄紫、编辑、文化、等离子。

## 适合的产品语义

- 文化科技
- 设计作品集
- 创意工具
- 数字出版

## 不适合的产品语义

- 严肃金融
- 医疗后台
- 高频操作工具

## 界面落地建议

渐变集中在画布边缘，不让紫色进入长段正文。

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

风险等级：medium。

- 正式实现需检查正文、按钮、细线、标签和禁用态。
- 不得仅依靠颜色表达状态或优先级。

## 来源

Yudi AI Lab 项目定制暗色编辑渐变。

## visual-direction-approval 展示话术

这是一套酒红、茄紫和冷莓色构成的暗色编辑方向，适合文化科技、设计作品集、创意工具和数字出版。代价是紫红渐变容易干扰高频操作和严肃信息判断，不适合金融、医疗后台和密集工具。实现时把渐变限制在画布边缘，不让紫色进入长段正文。
