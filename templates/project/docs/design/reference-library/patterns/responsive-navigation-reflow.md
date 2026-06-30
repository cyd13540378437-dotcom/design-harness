---
id: PAT-022
slug: responsive-navigation-reflow
name_zh: 响应式导航重排
name_en: Responsive navigation reflow
suitable_surfaces:
- responsive-web
- web-app
risky_surfaces:
- mobile-app
not_suitable_for:
- 单一终端原生 App
reference_products:
- Medium
- Shopify
- GitHub
- Notion
- Airbnb
---

# 响应式导航重排

## 何时适用

同一 Web 产品需要同时覆盖桌面和移动 Web，但不是原生 App。

## 可借鉴

- 桌面侧栏/顶部导航在移动端重排为抽屉或底部辅助入口
- 主行动保留在首屏
- 次级信息延后

## 不应借鉴

- 不要把 native app 的 tab bar 当作 mobile web 的默认答案
- 不要牺牲桌面效率来迁就移动端

## QA 检查点

- 1440、768、390 三档可用
- 导航层级不丢失
- 移动端主 CTA 不被菜单遮挡
