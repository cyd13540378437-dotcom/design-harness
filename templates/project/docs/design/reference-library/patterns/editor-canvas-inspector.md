---
id: PAT-015
slug: editor-canvas-inspector
name_zh: 编辑器画布 + 属性面板
name_en: Editor canvas and inspector
suitable_surfaces:
- web-app
- desktop-app
- tablet
risky_surfaces:
- mobile-app
not_suitable_for:
- 简单内容发布表单
reference_products:
- Figma
- Canva
- Webflow
- Framer
- Retool
- Miro
---

# 编辑器画布 + 属性面板

## 何时适用

产品需要用户在可视化画布上创建、排列、配置或预览复杂对象。

## 可借鉴

- 画布居中，工具/图层/属性面板分区
- 对象选中后属性面板随上下文变化
- 发布/导出入口保持明确

## 不应借鉴

- 不要让面板抢占画布核心空间
- 移动端只能提供轻量编辑或预览

## QA 检查点

- 选中/未选中状态清楚
- 小屏幕有降级策略
- 撤销、保存、发布反馈明确
