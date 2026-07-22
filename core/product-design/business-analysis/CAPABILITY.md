---
capability_id: product-business-analysis
display_name: 商业分析能力集群
version: v0.1.2-alpha
status: implementation-ready
primary_language: zh-CN
agent_neutral: true
standalone: true
created_at: 2026-07-21
---

# 商业分析能力集群（`product-business-analysis`）

## 1. 定位

商业分析帮助用户在业务情境中形成、管理和复审选择。它以 Decision Case 为基本单位，通过证据分类、专业分析模型、反方分析、质量保障和人类确认，把模糊输入推进为可行动、可验证、可复审的业务决定。

> 决策最终表现为选择；高质量分析的职责，是先形成真实选择空间，再帮助用户理解每个选择的后果。

## 2. v0.1.2 的核心能力

```text
多轮对话状态续接
商业问题连续性与 Decision Anchor
用户解法前提挑战
分析深度控制
下一最有决策价值的问题
模型到决策的 Decision Delta
单一中央决策综合
中文优先输出
```

## 3. 独立性边界

本能力可以独立安装、独立运行、独立维护资产、独立结束。

当前版本不包含：

```text
跨模块 Trigger
跨模块影响传播
下游视图
自动 Handoff
自动启动其他能力
共享 Work Item 状态目录
```

## 4. 三层架构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

## 5. 五个运行域

1. **统筹与路由**：输入理解、Follow-up 恢复、Case 路由、深度选择和下一决策问题。
2. **核心决策分析**：Decision Case、模型选择、Analysis Runs、选项与权衡、反方分析。
3. **复审、风险与决策记忆**：验证、复审、Decision Network 和历史追踪。
4. **材料接收、项目提取与质量保障**：证据接收、项目提取、Decision Assurance、连续性检查。
5. **Human Decision Control Plane**：D0–D3 分级、确认、替代、废弃和封存。

`Passive Trigger Interface` 仍然不在本版本中。

## 6. 核心产物

- `Decision Case`：长期权威决策对象，固定 16 个语义字段。
- `Decision Summary`：面向用户的中文阶段性结论，必须绑定 Case、Assurance 和用户决定状态。
- `Decision Process Package`：本次分析过程压缩包。
- `Decision Network`：Decision Case 之间的关系。
- `Decision Review`：新证据或新环境下的正式复审。

## 7. 中文输出合同

- 用户可见对话默认使用简体中文。
- 所有项目 Markdown 输出必须提供简体中文内容。
- 机器 YML / JSON 可使用英文键，但面向人的标题、摘要、结论必须有中文值。
- 英文运行时说明可以存在，但不得替代中文项目资产或中文用户结论。

## 8. 核心硬规则

1. 每个新 Case 完整保存第一次输入原文。
2. 输入理解确认前不得做实质推荐，除非问题低歧义、低影响且明确标记 provisional。
3. 活动 BA Work Item 存在时，后续每轮先恢复状态再回答。
4. 每轮维护 Decision Anchor；模型与问题必须服务当前业务选择。
5. 用户提出具体解法时，先挑战解法前提，不把解法当成问题本身。
6. 每个模型运行必须说明 `decision_relevance` 和 `decision_delta`。
7. 模型卡不得各自直接向用户生成最终结论；只有中央决策综合器可以收尾。
8. 按 `quick / standard / deep` 选择分析深度。
9. 最终摘要必须绑定 Decision Case ID、Assurance、结论状态和用户决定状态。
10. 商业分析不得无提示滑入产品范围、数据结构、UI 或技术实现设计。
11. 过程文件必须进入 `artifacts/`；不得创建临时 `intake/` 目录。
12. 不得跨模块读写、触发或编译资产。

## 9. 模型卡注册表

当前包含 25 张 ready 模型卡（9 张 Core、16 张 Professional），每张卡有 7 个 usage prompts。

## 10. 多轮续接落盘原则

状态恢复是每轮强制运行时行为，但文件生成按深度控制：`quick` 可只更新 `STATE.md`；`standard / deep`、总结、决定、复审、范围变化或连续性风险时，更新同一个滚动的 `TURN_CONTINUITY_CHECK.md`。
