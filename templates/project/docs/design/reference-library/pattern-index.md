# Design Pattern Index

| ID | 模式 | English | 适用终端 | 代表产品 | 何时适用 |
| --- | --- | --- | --- | --- | --- |
| PAT-001 | 内容卡片式发现 | Content card discovery | mobile-app, responsive-web, web-app | Airbnb, Pinterest, Spotify, Medium | 用户需要浏览、比较、收藏或从大量内容/商品/案例中发现目标。 |
| PAT-002 | 地图画布 + 底部抽屉 | Map canvas with bottom sheet | mobile-app, responsive-web | Uber, Airbnb, Strava | 空间位置、距离、路线或现场状态是用户决策语境。 |
| PAT-003 | 数据卡片化 Dashboard | Data-card dashboard | web-app, responsive-web, mobile-app | Revolut, Shopify, Strava, Google Analytics, Plausible | 用户需要快速知道当前状态、异常、趋势和下一步。 |
| PAT-004 | 游戏化路径 | Gamified progress path | mobile-app, responsive-web | Duolingo, Nike Run Club, Strava | 产品需要持续召回、进度感、打卡或训练动力。 |
| PAT-005 | 低刺激健康视觉 | Low-stimulation health UI | mobile-app, responsive-web | Headspace, Calm, MyFitnessPal | 用户处于压力、健康、睡眠、心理或陪伴型场景。 |
| PAT-006 | 深色内容沉浸 | Dark content immersion | mobile-app, desktop-app, web-app, tv-app | Spotify, Netflix, TikTok | 内容资产本身具有强视觉/音视频吸引力，界面应让位给内容。 |
| PAT-007 | 专业工具高密度工作台 | Dense productivity workspace | web-app, desktop-app, tablet | Linear, Notion, Slack, GitHub, Jira | 熟练用户需要快速扫描任务、状态、消息、对象关系和下一步。 |
| PAT-008 | 模板先行降低门槛 | Template-first creation | web-app, mobile-app, responsive-web | Canva, Notion, Airtable, Miro, Framer | 用户面对空白画布、复杂配置或创作任务时容易不知道从何开始。 |
| PAT-009 | AI 答案与来源可信化 | Cited AI answer | web-app, responsive-web, mobile-app, desktop-app | Perplexity, ChatGPT | AI 输出会影响用户判断，用户需要知道答案依据和下一步怎么做。 |
| PAT-010 | 自然语言快速输入 | Natural-language capture | mobile-app, web-app, desktop-app | Todoist, ChatGPT, Superhuman | 用户希望先表达意图，再由系统结构化成任务、文档、查询或动作。 |
| PAT-011 | 社区成就反馈 | Community achievement feedback | mobile-app, responsive-web | Strava, Instagram, TikTok, Nike Run Club | 用户愿意分享“我做到了”或“我发现了”，社区反馈能强化动机。 |
| PAT-012 | 价格/服务透明决策 | Transparent commerce/service decision | mobile-app, web-app, responsive-web | Wise, Uber Eats, Apple Store, Stripe Dashboard | 用户需要在价格、费率、时效、限制、配置或风险之间做决定。 |
| PAT-013 | Web SaaS 工作台首页 | Web SaaS dashboard home | web-app, desktop-app, responsive-web | Shopify, Vercel, Airtable, HubSpot CRM, Supabase | 用户进入产品后需要知道业务状态、待办、最近对象和下一步。 |
| PAT-014 | 数据表格筛选与批量操作 | Data table filtering and bulk actions | web-app, desktop-app | Stripe Dashboard, Airtable, Jira, GitHub, Google Analytics | 用户需要从大量对象中筛选、排序、批量处理或追踪状态。 |
| PAT-015 | 编辑器画布 + 属性面板 | Editor canvas and inspector | web-app, desktop-app, tablet | Figma, Canva, Webflow, Framer, Retool | 产品需要用户在可视化画布上创建、排列、配置或预览复杂对象。 |
| PAT-016 | 渐进式新手引导 | Progressive onboarding | web-app, mobile-app, responsive-web | Asana, Notion, Canva, Airtable, Duolingo | 新用户需要理解价值、完成首个结果，而不是先学习完整系统。 |
| PAT-017 | 设置、权限与计费中心 | Settings permissions and billing | web-app, desktop-app, responsive-web | Stripe Dashboard, Vercel, Supabase, Dropbox, HubSpot CRM | 产品涉及团队、权限、额度、账单、集成和不可逆配置。 |
| PAT-018 | 定价与套餐比较 | Pricing plan comparison | responsive-web, web-app | Mailchimp, Airtable, Stripe, Canva, Notion | 用户需要选择套餐、理解限制、升级或取消。 |
| PAT-019 | AI Copilot 侧栏/辅助面板 | AI copilot side panel | web-app, desktop-app | Intercom, Framer, Airtable, GitHub, Figma | AI 需要读取当前对象上下文，给出建议、草稿、分析或自动化动作。 |
| PAT-020 | 协作评论与 @ 提及 | Collaboration comments and mentions | web-app, desktop-app, mobile-app | Figma, Slack, GitHub, Loom, Dropbox | 多人需要围绕同一个对象、页面、视频、文件或任务讨论并形成行动。 |
| PAT-021 | 空状态激活 | Empty-state activation | web-app, mobile-app, responsive-web | Notion, Linear, Loom, Canva, Airtable | 新账号、无数据、无权限或筛选无结果时，界面不能只显示空白。 |
| PAT-022 | 响应式导航重排 | Responsive navigation reflow | responsive-web, web-app | Medium, Shopify, GitHub, Notion, Airbnb | 同一 Web 产品需要同时覆盖桌面和移动 Web，但不是原生 App。 |

## 使用提醒

每个模式都标注了适用终端和风险终端。Agent 在做视觉方向建议前必须检查该模式是否适合当前 Work Item 的目标终端。
