---
id: REF-003
name: Uber
slug: uber
industry: 出行/本地服务
surfaces:
- mobile-app
primary_surface: mobile-app
platforms:
- iOS
- Android
page_types:
- map-home
- bottom-sheet-selection
- price-confirmation
- in-trip-status
task_types:
- 叫车、车型选择、路线与价格确认
pattern_tags:
- map-canvas-bottom-sheet
- stepwise-confirmation
- realtime-status
visual_tags:
- 地图画布
- 底部抽屉
- 低干扰
- 高效率
content_density: high
user_maturity: mixed
priority: S
source_urls:
- https://apps.apple.com/us/app/uber-request-a-ride/id368677368
---

# Uber

## 适合参考的任务

需要把复杂服务流程压缩成一步步确认

## 可借鉴

地图作为主画布；核心选择集中在 bottom sheet；只在必要时出现品牌色和行动按钮。

## 不应借鉴

不要复用第三方品牌资产、图标、插画、文案或完整页面布局。 若当前任务是 Web/桌面端，不得直接照搬移动端导航、底部栏、手势或屏幕比例；只能抽象借鉴信息层级、反馈机制和文案语气。

## 终端判断

- Primary surface: `mobile-app`
- Candidate surfaces: `mobile-app`
- 选择它作为参考时，必须先确认当前 Work Item 的目标终端与页面类型是否匹配。

## 备注

适合研究实时状态、位置、价格、时长的可视化
