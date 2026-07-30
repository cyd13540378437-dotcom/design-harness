---
schema_version: 1
id: ibm-luminous-blue
title: 工业蓝灰秩序
status: ready
image: ../images/ibm-luminous-blue.png
palette: ../palettes/ibm-luminous-blue.yml
---

# 工业蓝灰秩序

## 用户可见摘要

灰阶统治内容层级，核心蓝只承担行动与结构，形成硬朗的工程纪律。

## 色彩气质

工程、清晰、秩序、可信。

## 适合的产品语义

- 开发者工具
- 企业系统
- 技术文档
- 数据平台

## 不适合的产品语义

- 生活方式品牌
- 儿童产品
- 强情绪消费

## 界面落地建议

中性灰承担大多数界面，核心蓝作为主行动，亮蓝只用于局部信息提示。

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

IBM Design Language 的灰阶主导与核心蓝原则衍生。

## visual-direction-approval 展示话术

这是一套工程、清晰、可信的工业蓝灰方向，适合开发者工具、企业系统、技术文档和数据平台。代价是表达偏理性和制度化，不适合需要温暖生活感或强情绪记忆的产品。实现时由中性灰承担大多数层级，核心蓝用于主行动，亮蓝只做局部信息提示。
