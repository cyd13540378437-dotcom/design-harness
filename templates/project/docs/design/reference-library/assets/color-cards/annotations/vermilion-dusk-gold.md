---
schema_version: 1
id: vermilion-dusk-gold
title: 朱砂暮金
status: ready
image: ../images/vermilion-dusk-gold.png
palette: ../palettes/vermilion-dusk-gold.yml
---

# 朱砂暮金

## 用户可见摘要

暖纸白承载内容，朱砂像暮色从边缘渗入，黄铜金只在关键时刻抬升层级。

## 色彩气质

朱砂、暮色、黄铜、编辑。

## 适合的产品语义

- 文化科技
- 精品案例
- 品牌叙事
- 个人作品集

## 不适合的产品语义

- 高频后台
- 医疗系统
- 需要强冷静感的数据平台

## 界面落地建议

朱砂用于章节锚点和人的判断，暮金用于稀缺高光；长文区域仍保持低刺激暖纸白。

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

用户提供的 Yudi AI Lab 配色渐变升级实验稿：朱砂暮金。

## visual-direction-approval 展示话术

这是一套温暖、编辑、带朱砂暮色与黄铜高光的方向，适合文化科技、精品案例、品牌叙事和个人作品集。代价是暖色判断感较强，不适合高频后台、医疗系统和需要强冷静感的数据平台。实现时用暖纸白承载长内容，朱砂标记章节和人的判断，暮金只做低频稀缺高光。
