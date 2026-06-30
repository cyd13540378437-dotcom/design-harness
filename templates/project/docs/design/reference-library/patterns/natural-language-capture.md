---
id: PAT-010
slug: natural-language-capture
name_zh: 自然语言快速输入
name_en: Natural-language capture
suitable_surfaces:
- mobile-app
- web-app
- desktop-app
risky_surfaces: []
not_suitable_for:
- 必须严格字段校验的高风险提交
reference_products:
- Todoist
- ChatGPT
- Superhuman
---

# 自然语言快速输入

## 何时适用

用户希望先表达意图，再由系统结构化成任务、文档、查询或动作。

## 可借鉴

- 输入框常驻或足够容易触达
- 提交后自动结构化并允许轻量编辑
- 建议项围绕用户意图生成

## 不应借鉴

- 不要把自然语言结果直接提交到不可逆系统
- 不要隐藏字段解析结果

## QA 检查点

- 解析错误可纠正
- 键盘和移动输入友好
- 空输入和长输入有合理反馈
