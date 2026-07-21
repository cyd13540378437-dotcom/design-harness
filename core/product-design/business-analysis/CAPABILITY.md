---
capability_id: product-business-analysis
display_name: 商业分析能力集群
version: v0.1.1-alpha
status: implementation-ready
language: zh-CN
agent_neutral: true
created_at: 2026-07-21
---

# 商业分析能力集群（`product-business-analysis`）

## 1. 定位

商业分析帮助用户在业务情境中形成、管理和复审决策。它以 Decision Case 为基本单位，以 Decision Network 记录决策之间的依赖与影响，通过 Analysis Model Cards、证据检查、反方分析、验证设计和人类确认，把模糊问题推进到可选择、可审查、可验证、可复审的状态。

> 商业分析最终都是在做选择题。

选择可以是方案，也可以是：是否现在决定、是否继续分析、是否先验证、是否维持现状、是否缩小范围、是否暂缓、是否复审旧决策。

## 2. 独立性边界

本能力是 Agent-neutral、可单独安装、可单独运行、可单独维护知识资产的模块。

它不依赖任何其他能力，不读取其他能力的 source of truth 来决定自身工作流，也不会主动修改、触发或生成其他能力的资产。

当前版本明确不包含：

```text
跨模块 Trigger
跨模块影响传播
下游视图
自动 Handoff
自动启动其他能力
共享 Work Item 状态目录
```

这些属于未来独立产品功能，不是本能力的默认职责。

## 3. 三层架构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

- Core：能力协议、Skill、模型卡、模板、质量规则、示例和评测。
- Adapters：Codex、Claude Code、Cursor 的运行时包装，不得改变 Core 语义。
- Project Assets：真实项目里的 Decision Cases、Decision Network、证据和 BA Work Items。

## 4. 五个运行域

六段式架构可以作为参考，但不是所有模块的强制模板。商业分析当前采用五个真正适用的运行域：

### 4.1 统筹与路由

负责输入理解、Case 关联判断、入口模式识别、Work Item 绑定、下一最佳问题和工作计划。

### 4.2 核心决策分析

负责 Decision Case、模型选择、Analysis Runs、选项生成、权衡、反方分析和选择题式综合。

### 4.3 复审、风险与决策记忆

负责验证计划、复审条件、Decision Review、Decision Network 和决策历史追踪。

### 4.4 材料接收、项目提取与质量保障

负责证据接收、事实/假设/解释分类、从已有材料提取候选决策、Decision Assurance 和一致性检查。

### 4.5 Human Decision Control Plane

横切所有运行域，控制高影响决定、状态升级、替代、废弃和封存。

`Passive Trigger Interface` 当前不采用，也不预置伪接口。

## 5. 核心产物

### 5.1 Decision Case

长期权威资产，固定 16 个语义字段：

```text
0. 原始输入
1. 当前问题
2. 为什么现在需要处理
3. 决策范围
4. 关键线索
5. 已知事实
6. 重要假设
7. 相关证据
8. 专业分析工作区
9. 可选方案
10. 主要权衡
11. 反方观点 / 不做会怎样
12. 当前结论
13. 验证方式
14. 复审条件
15. 关联决策
```

字段固定，填充深度动态。

### 5.2 Decision Process Package

一次 BA Work Item 的过程压缩包。

### 5.3 Decision Network

支持：

```text
depends_on
affects
conflicts_with
supersedes
reopens
```

### 5.4 Decision Review

当新证据、新决定或时间变化使旧 Case 需要复审时，生成独立 Review，而不是静默重写历史。

## 6. 项目资产位置

```text
docs/product/business-analysis/
```

商业分析的长期资产和 Work Item 都位于该根目录下，避免依赖共享目录或其他能力。

## 7. 硬规则

1. 必须完整保留用户第一次输入原文。
2. 第一步只做输入理解；理解确认或明确假设之后才路由。
3. Decision Case 只能有一个权威文件，位于 `decision-cases/`。
4. Work Item 不复制 Decision Case，只记录消费、输出、决定和过程包。
5. 专业模型分析必须写入 Analysis Workspace。
6. 模型卡必须包含适用条件、输入合同、输出合同、常见误用和六类 usage prompt。
7. 反方分析默认执行。
8. 阶段结论前必须执行 Decision Assurance Check。
9. 能生成选择题就生成选择题。
10. 系统建议不能冒充用户决定。
11. 假设不能冒充事实。
12. 新材料不能静默改变 Case 边界。
13. 新决定不能静默改写旧决定。
14. 不得跨模块读写、触发或编译资产。
