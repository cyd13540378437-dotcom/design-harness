---
schema_version: 1
id: gradient-ivory-prism
title: 渐变：象牙棱镜
status: ready
image: ../images/gradient-ivory-prism.png
palette: ../palettes/gradient-ivory-prism.yml
---

# 渐变：象牙棱镜

## 用户可见摘要

象牙白叠加灰紫、玫瑰金和冷蓝微光，呈现精品出版物般的金属油墨质感。

## 色彩气质

象牙、棱镜、编辑、精品。

## 适合的产品语义

- 精品作品集
- 文化科技
- 会员品牌
- 数字出版

## 不适合的产品语义

- 重型后台
- 监控系统
- 儿童游戏

## 界面落地建议

暖白承担阅读，灰紫负责结构，玫瑰金只做局部光泽。

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

Yudi AI Lab 项目定制浅色编辑渐变。

## visual-direction-approval 展示话术

这是一套象牙底叠加克制棱镜光的精品编辑方向，适合精品作品集、文化科技、会员品牌和数字出版。代价是浅色光谱容易削弱正文边界，不适合高频后台和需要强状态区分的系统。实现时保持内容区为稳定象牙纯色，只在页面边缘使用低饱和棱镜环境光。
