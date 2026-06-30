---
id: PAT-013
slug: web-saas-dashboard
name_zh: Web SaaS 工作台首页
name_en: Web SaaS dashboard home
suitable_surfaces:
- web-app
- desktop-app
- responsive-web
risky_surfaces:
- mobile-app
not_suitable_for:
- 纯浏览内容流
- 一次性营销落地页
reference_products:
- Shopify
- Vercel
- Airtable
- HubSpot CRM
- Supabase
---

# Web SaaS 工作台首页

## 何时适用

用户进入产品后需要知道业务状态、待办、最近对象和下一步。

## 可借鉴

- 首屏分为状态、行动、最近对象和风险提醒
- 二级导航承担复杂模块
- 移动端响应式保留主行动

## 不应借鉴

- 不要只做漂亮欢迎页
- 不要把所有模块入口平均铺开

## QA 检查点

- 桌面首屏能看见主行动和关键状态
- 移动端信息顺序合理
- 空账户也能激活
