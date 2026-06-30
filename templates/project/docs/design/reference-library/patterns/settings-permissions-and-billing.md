---
id: PAT-017
slug: settings-permissions-and-billing
name_zh: 设置、权限与计费中心
name_en: Settings permissions and billing
suitable_surfaces:
- web-app
- desktop-app
- responsive-web
risky_surfaces:
- mobile-app
not_suitable_for:
- 娱乐内容流
reference_products:
- Stripe Dashboard
- Vercel
- Supabase
- Dropbox
- HubSpot CRM
---

# 设置、权限与计费中心

## 何时适用

产品涉及团队、权限、额度、账单、集成和不可逆配置。

## 可借鉴

- 设置按风险和对象分组
- 权限/账单变化前解释影响
- 危险操作隔离并强确认

## 不应借鉴

- 不要把设置入口藏得过深
- 不要把高风险设置做成普通表单

## QA 检查点

- 权限不足、账单失败、删除/转移有明确反馈
- 移动端不隐藏关键信息
- 审计/记录入口可追踪
