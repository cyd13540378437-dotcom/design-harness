---
id: PAT-003
slug: data-card-dashboard
name_zh: 数据卡片化 Dashboard
name_en: Data-card dashboard
suitable_surfaces:
- web-app
- responsive-web
- mobile-app
risky_surfaces: []
not_suitable_for:
- 纯内容阅读页
- 一次性表单提交页
reference_products:
- Revolut
- Shopify
- Strava
- Google Analytics
- Plausible
---

# 数据卡片化 Dashboard

## 何时适用

用户需要快速知道当前状态、异常、趋势和下一步。

## 可借鉴

- 首屏回答“现在怎样、哪里异常、下一步做什么”
- 指标卡和趋势图按决策优先级排序
- 异常状态比完整数据更优先

## 不应借鉴

- 不要把所有表格字段都塞进首屏
- 不要只追求漂亮图表而忽略可行动信息

## QA 检查点

- 空数据、极端数字、异常值和权限不足都能解释
- 桌面和移动端指标排序一致
- 图表有文字辅助说明
