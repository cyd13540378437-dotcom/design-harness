---
schema_version: 1
id: gradient-night-aurora
title: 渐变：夜幕极光
status: ready
image: ../images/gradient-night-aurora.png
palette: ../palettes/gradient-night-aurora.yml
---

# 渐变：夜幕极光

## 用户可见摘要

近黑绿正文区域配边缘青绿和深海蓝环境光，克制但具有空间纵深。

## 色彩气质

极光、深邃、高级、克制。

## 适合的产品语义

- AI 实验室
- 研究平台
- 开发者作品集
- 技术品牌

## 不适合的产品语义

- 明亮儿童产品
- 高频交易后台
- 强促销页面

## 界面落地建议

正文区域保持近黑纯色，极光只在边缘发生，面板使用极轻玻璃渐变。

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

Yudi AI Lab 旧版夜间实验室定制多光源渐变。

## visual-direction-approval 展示话术

这是一套深邃、克制、具有极光空间感的暗色方向，适合 AI 实验室、研究平台、开发者作品集和技术品牌。代价是多光源渐变不适合高频交易后台、强促销或明亮儿童产品。实现时正文区域保持近黑纯色，极光只发生在画布边缘和低透明面板反射中。
