# Product Business Analysis Core v0.1.4 PRD

- 版本：v0.1.4-alpha
- 状态：Codex 可执行规范
- 主题：Decision Boundary & Choice Closure

## 1. 第一性原则

商业分析围绕业务问题维护 Decision Case 与 Decision Network，把输入转化成可选择、可审查、可验证、可复审的决策过程。选择是核心对象。

v0.1.4 增加同等重要的终止原则：用户完成选择后，关闭原 Choice Loop，锁定原决策粒度，不继续下沉为实施设计与执行。

## 2. 必须实现

### 2.1 Mixed-turn Interpretation

同轮分别识别决定信号和后续请求，先记录决定。

### 2.2 Choice Loop Closure

用户 confirmed 后：推荐转 `user_confirmed`、选项转 `selected`、Choice Loop 转 `closed`、写入 Decision Notes。

### 2.3 Decision Scope Lock

Case 与 State 记录 scope ID、类型、陈述、状态和 explicit non-scope。

### 2.4 Post-decision Clarification

允许目的、理由、后果、证据边界和复审条件；禁止逐步实施、Schema、公式、样例、代码、UI 和技术设计。

### 2.5 Artifact Boundary Gate

拦截实施 Runbook、手工指南、数据 Schema、样例数据、脚本、技术规格和执行结果。

### 2.6 No Execution Offer

不得主动提出生成样例、写脚本、运行模拟或实现产品。

### 2.7 State Enum Enforcement

固定 status / phase / gate；禁止业务专属状态。

### 2.8 Summary Modes

支持 `choice_request / decision_confirmed / post_decision_clarification / review`，并与 Choice Loop 一致。

## 3. ARCOS 验收

用户：

> 其他的都没问题，你说的 M0 手工跑是怎么个跑法？

系统必须：

```text
识别 B+ 路线 confirmed；
关闭 Choice Loop；
记录 DECISION_NOTES；
概念级解释 M0 的业务目的和证据边界；
不创建 M0_MANUAL_SIMULATION_GUIDE；
不定义表格、字段、公式和样例；
不提出帮用户生成或运行；
进入 completion-review。
```

若用户随后说 M0 人工成本不可接受，才重开 Choice Loop。

## 4. 非目标

不集成 motivation-analysis；不调用、修改或触发其他模块；不实现实施任务、代码、样例数据、CLI、Hook、Plugin、Installer 或外部依赖。

## 5. Definition of Done

- Mixed-turn、Choice Closure、Scope Lock、Post-decision Clarification 完整；
- Artifact Boundary 和 No Execution Offer 完整；
- State 枚举强校验完整；
- 模板与示例升级到 schema 3；
- ARCOS 确认 + 实施追问回归通过；
- 56 个评测齐全；
- 中文输出完整；
- 商业分析保持独立。
