---
schema_version: 1
id: gradient-obsidian-spectrum
title: 渐变：黑曜光谱
status: ready
image: ../images/gradient-obsidian-spectrum.png
palette: ../palettes/gradient-obsidian-spectrum.yml
---

# 渐变：黑曜光谱

## 用户可见摘要

几乎黑白的页面，只在暗部浮现青紫油膜般的微弱色偏。

## 色彩气质

黑曜石、光谱、精密、稀缺。

## 适合的产品语义

- 精品科技
- 硬件品牌
- 高级作品集
- 研究产品

## 不适合的产品语义

- 欢乐社群
- 儿童教育
- 明亮生活服务

## 界面落地建议

第一眼接近高级黑，停留后才感受到青紫光谱。

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

Yudi AI Lab 项目定制低饱和光谱渐变。

## visual-direction-approval 展示话术

这是一套低饱和、精密、具有稀缺感的黑曜光谱方向，适合精品科技、硬件品牌、高级作品集和研究产品。代价是暗色光谱会提高层级控制与对比验证成本，不适合儿童、温暖服务和高频业务后台。实现时让黑曜底保持稳定，只在边缘使用低透明光谱作为环境光。
