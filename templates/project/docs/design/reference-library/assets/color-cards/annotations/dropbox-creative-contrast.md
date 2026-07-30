---
schema_version: 1
id: dropbox-creative-contrast
title: 创意强对比
status: ready
image: ../images/dropbox-creative-contrast.png
palette: ../palettes/dropbox-creative-contrast.yml
---

# 创意强对比

## 用户可见摘要

高纯度蓝与意外暖色并置，适合需要鲜明品牌记忆的创意型产品。

## 色彩气质

鲜明、创意、编辑、高对比。

## 适合的产品语义

- 创意工具
- 个人作品集
- 内容品牌
- 协作产品

## 不适合的产品语义

- 严肃金融
- 医疗后台
- 长时间密集操作

## 界面落地建议

石墨与椰白建立阅读底盘，高纯度蓝负责结构，粉色和亮黄只承担记忆点。

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

风险等级：medium。

- 正式实现需检查正文、按钮、细线、标签和禁用态。
- 不得仅依靠颜色表达状态或优先级。

## 来源

Dropbox Brand Color 关系衍生，不复制具体页面。

## visual-direction-approval 展示话术

这是一套鲜明、创意、高对比的配色方向，适合创意工具、个人作品集、内容品牌和协作产品。代价是高纯度蓝、粉色与亮黄容易争夺注意力，不适合严肃金融、医疗后台和长时间密集操作。实现时以石墨与椰白建立阅读底盘，高纯度蓝负责结构，粉色和亮黄只承担低频记忆点。
