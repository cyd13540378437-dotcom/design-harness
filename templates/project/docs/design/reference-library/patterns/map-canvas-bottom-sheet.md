---
id: PAT-002
slug: map-canvas-bottom-sheet
name_zh: 地图画布 + 底部抽屉
name_en: Map canvas with bottom sheet
suitable_surfaces:
- mobile-app
- responsive-web
risky_surfaces:
- web-app
- desktop-app
not_suitable_for:
- 无空间关系的列表型产品
- 需要复杂表格对比的后台
reference_products:
- Uber
- Airbnb
- Strava
---

# 地图画布 + 底部抽屉

## 何时适用

空间位置、距离、路线或现场状态是用户决策语境。

## 可借鉴

- 地图作为背景语境
- 底部抽屉承载当前选择和下一步动作
- 实时状态用轻量标签和进度反馈表达

## 不应借鉴

- Web 端不要机械使用移动端 bottom sheet；更适合侧栏或分栏
- 不要让地图遮挡关键决策信息

## QA 检查点

- 位置权限失败有替代路径
- 抽屉展开/收起不丢失上下文
- 小屏幕地图与 CTA 不互相遮挡
