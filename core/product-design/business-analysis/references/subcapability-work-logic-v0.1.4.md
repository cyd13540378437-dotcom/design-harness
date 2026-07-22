# 子能力工作逻辑 v0.1.4

## 1. 统筹与路由

| 中文 | ID | 职责 |
|---|---|---|
| 商业分析总协调器 | `business-analysis-orchestrator` | Work Item 续接、入口、深度、调用和输出收敛 |
| 输入理解器 | `decision-input-interpreter` | 原始输入、问题理解、候选解法与问题分离 |
| 混合轮次解释器 | `mixed-turn-interpreter` | 分别识别决定信号与后续请求，先处理决定 |
| 多轮续接管理器 | `follow-up-continuity-manager` | 恢复 STATE / Case / Summary / Notes |
| 决策案例路由器 | `decision-case-router` | 新建、继续、记录决定、摘要、澄清、复审和新 Case 候选 |
| 决策范围锁定器 | `decision-scope-lock-manager` | 锁定当前决策粒度、明确非范围、阻止静默下沉 |
| Choice Core 管理器 | `choice-core-manager` | 维护 Choice Set、推荐、证据边界和用户决定 |
| Choice Loop 管理器 | `choice-loop-manager` | open / closed / reopened，确认后停止同层分析 |
| 分析深度规划器 | `analysis-depth-planner` | quick / standard / deep |

## 2. Choice-first 核心决策分析

保留选择空间构建、解法前提挑战、推荐生成、模型选择、专业分析、权衡、反方和中央综合。

## 3. 决定后收口与边界

| 中文 | ID | 职责 |
|---|---|---|
| 决定后澄清器 | `post-decision-clarifier` | 只解释目的、理由、代价、证据边界与复审条件 |
| 产物边界检查器 | `artifact-boundary-validator` | 拦截 Runbook、Schema、样例、代码、UI / 技术规格 |
| 禁止执行检查器 | `no-execution-offer-validator` | 拦截“帮你生成 / 运行 / 实现”等执行提议 |
| 状态枚举检查器 | `state-enum-validator` | 强制合法 status / phase / gate |
| 决策闭环管理器 | `decision-closure-manager` | confirmed 后关闭 Choice Loop，进入 completion-review |

## 4. 复审、风险与决策记忆

保留验证与复审规划、Decision Network 和 Decision Review；只有新证据或取舍变化才允许重开。

## 5. Human Decision Control Plane

执行 D0–D3 分级。明确指代性接受可以构成 confirmed；泛化知悉仍为 acknowledged。confirmed 必须关闭 Choice Loop。
