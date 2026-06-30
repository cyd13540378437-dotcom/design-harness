---
id: PAT-014
slug: data-table-filtering-and-bulk-actions
name_zh: 数据表格筛选与批量操作
name_en: Data table filtering and bulk actions
suitable_surfaces:
- web-app
- desktop-app
risky_surfaces:
- mobile-app
not_suitable_for:
- 图片发现流
- 沉浸式视频
reference_products:
- Stripe Dashboard
- Airtable
- Jira
- GitHub
- Google Analytics
---

# 数据表格筛选与批量操作

## 何时适用

用户需要从大量对象中筛选、排序、批量处理或追踪状态。

## 可借鉴

- 筛选器、列、状态、批量操作和详情抽屉协作
- 默认视图回答最常见问题
- 危险批量操作需二次确认

## 不应借鉴

- 不要在移动端硬塞完整表格
- 不要把筛选结果和原始数据混淆

## QA 检查点

- 长字段、空列、大量选中、无结果可处理
- 键盘与焦点状态可用
- 批量操作后反馈明确
