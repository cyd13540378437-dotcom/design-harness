---
id: PAT-019
slug: ai-copilot-side-panel
name_zh: AI Copilot 侧栏/辅助面板
name_en: AI copilot side panel
suitable_surfaces:
- web-app
- desktop-app
risky_surfaces:
- mobile-app
not_suitable_for:
- 无上下文的普通聊天
reference_products:
- Intercom
- Framer
- Airtable
- GitHub
- Figma
---

# AI Copilot 侧栏/辅助面板

## 何时适用

AI 需要读取当前对象上下文，给出建议、草稿、分析或自动化动作。

## 可借鉴

- AI 面板靠近当前对象但不遮挡主任务
- 建议可以接受、编辑、撤销
- 显示使用了哪些上下文

## 不应借鉴

- 不要让 AI 面板替代核心工作流
- 不要默认执行高风险动作

## QA 检查点

- 来源上下文清楚
- 接受建议后可撤销
- 移动端有抽屉/全屏降级
