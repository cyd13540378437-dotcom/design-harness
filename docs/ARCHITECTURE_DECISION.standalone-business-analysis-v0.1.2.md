# 架构决策：商业分析保持独立能力（v0.1.2）

## 决策

`product-business-analysis` 是 DesignHarnessAgent 中可独立安装、独立运行、独立维护资产、独立结束的兄弟能力。

## 三层结构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

## 项目资产根目录

```text
docs/product/business-analysis/
```

商业分析拥有自己的：

```text
Decision Cases
Decision Network
Evidence Ledger
Decision Reviews
BUSINESS_ANALYSIS_WORK_ITEMS.md
work-items/BA-xxx/
```

## 当前不实现

```text
跨模块 Trigger
跨模块影响传播
Downstream View
自动 Handoff
自动启动业务模型或其他能力
共享 Work Item 根目录
```

这些行为若未来需要，应作为新的集成功能设计，不能成为商业分析 Core 的隐含依赖。

## 与五个运行域的关系

商业分析借鉴能力集群思想，但当前采用五个内在运行域：

1. 统筹与路由；
2. 核心决策分析；
3. 复审、风险与决策记忆；
4. 材料接收、项目提取与质量保障；
5. Human Decision Control Plane。

`Passive Trigger Interface` 不属于本版本。
