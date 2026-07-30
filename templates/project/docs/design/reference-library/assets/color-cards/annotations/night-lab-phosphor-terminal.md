---
schema_version: 1
id: night-lab-phosphor-terminal
title: 旧版变体：荧光终端
status: ready
image: ../images/night-lab-phosphor-terminal.png
palette: ../palettes/night-lab-phosphor-terminal.yml
---

# 旧版变体：荧光终端

## 用户可见摘要

黑与暖白构成主体，磷光黄绿带来更鲜明的个人实验室记忆。

## 色彩气质

终端、磷光、实验、锐利。

## 适合的产品语义

- 实验工具
- 终端产品
- 技术展览
- 个人作品集

## 不适合的产品语义

- 医疗健康
- 金融后台
- 低刺激长阅读

## 界面落地建议

磷光黄绿严格限制在状态、编号和主按钮，避免变成游戏 HUD。

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

风险等级：high。

- 正式实现需检查正文、按钮、细线、标签和禁用态。
- 不得仅依靠颜色表达状态或优先级。

## 来源

用户提供的旧版 Yudi AI Lab 结构衍生。

## visual-direction-approval 展示话术

这是一套锐利、实验、带荧光终端记忆的方向，适合实验工具、终端产品、技术展览和个人作品集。代价是磷光黄绿刺激度高，容易产生游戏 HUD 感，不适合医疗健康、金融后台和低刺激长阅读。实现时以黑与暖白构成主体，磷光色严格限制在状态、编号和主按钮。
