# Artifact Boundary Gate / 产物边界检查 v0.1.4

## 1. 允许的核心产物

```text
STATE.md
Decision Case
ANALYSIS_WORKSPACE.md
DECISION_SUMMARY.md
DECISION_NOTES.md
Decision Review / Decision Network Update（按需）
Deep / Audit 的治理与审计材料
```

## 2. 默认禁止的产物类别

```text
实施路径或 Runbook
手工操作指南
正式数据 Schema
样例数据集
脚本或代码
UI / 技术规格
算法实现说明
执行结果与代跑产物
```

典型禁止文件名包括但不限于：

```text
SIMULATOR_IMPLEMENTATION_PATH.md
M0_MANUAL_SIMULATION_GUIDE.md
DATA_SCHEMA.md
SAMPLE_DATA.*
RUNBOOK.md
SCRIPT.*
UI_SPEC.md
TECHNICAL_DESIGN.md
```

## 3. 内容级检查

即使文件名看起来中性，只要内容主要包含以下任一项，也应被拦截：

```text
逐步操作步骤；
具体字段清单；
公式与权重；
样例数据；
命令、代码或脚本；
产品界面、系统组件或技术选型；
替用户执行后的结果。
```

## 4. 合法替代

概念级验证路线、阶段目的、最低输入类别、证据边界和升级条件，写入 Decision Case、Analysis Workspace 或 Decision Summary，不新建实施产物。
