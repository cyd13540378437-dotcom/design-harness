# 子能力工作逻辑 v0.1.2

## 1. 统筹与路由

| 中文 | ID | 职责 |
|---|---|---|
| 商业分析总协调器 | `business-analysis-orchestrator` | Work Item 续接、入口、深度、调用和输出收敛 |
| 输入理解器 | `decision-input-interpreter` | 原始输入、问题理解、解法与问题分离 |
| 多轮续接管理器 | `follow-up-continuity-manager` | 恢复 STATE / Case / Process Package，识别 Turn Type |
| 决策案例路由器 | `decision-case-router` | 新建、继续、补证据、记录决定、摘要、复审、冲突、影响 |
| 决策锚点管理器 | `decision-anchor-manager` | 维护当前商业问题、选项、阻塞未知和证据边界 |
| 分析深度规划器 | `analysis-depth-planner` | quick / standard / deep |
| 下一决策问题规划器 | `decision-relevant-question-planner` | 只问会产生 Decision Delta 的 1–2 个问题 |

## 2. 核心决策分析

| 中文 | ID | 职责 |
|---|---|---|
| Decision Case 管理器 | `decision-case-manager` | 维护 16 字段 Case |
| 解法前提挑战器 | `solution-premise-challenger` | 比较用户解法、维持现状、更小替代和验证路径 |
| 分析模型选择器 | `analysis-model-selector` | 适配、最低输入、Decision Relevance |
| 专业分析运行器 | `analysis-model-runner` | 生成有 Decision Delta 的 Analysis Runs |
| 选项与权衡综合器 | `option-tradeoff-synthesizer` | 真实业务选项、代价、风险和可逆性 |
| 反方分析器 | `counterfactual-opposition-analyzer` | 不做、做错、更小选择 |
| 中央决策综合器 | `decision-synthesizer` | 唯一用户结论出口，生成中文 Decision Summary |

## 3. 复审、风险与决策记忆

| 中文 | ID | 职责 |
|---|---|---|
| 验证与复审规划器 | `validation-review-planner` | 阈值、下一决策点、复审条件 |
| 决策网管理器 | `decision-network-manager` | 商业分析内部 Case 关系 |
| 决策复审器 | `decision-reviewer` | 保留历史并正式复审 |

## 4. 材料接收、项目提取与质量保障

| 中文 | ID | 职责 |
|---|---|---|
| 证据接收分类器 | `evidence-intake-classifier` | 相关性、采用、弃用、证据账本 |
| 项目决策提取器 | `project-decision-extractor` | 从材料恢复 provisional Case |
| 连续性检查器 | `business-problem-continuity-validator` | 检查问题、模型、结论是否仍服务 Decision Anchor |
| 决策质量保障器 | `decision-assurance-validator` | pass / warn / block |
| 中文输出检查器 | `chinese-output-validator` | 保证用户与项目输出有中文版本 |

## 5. Human Decision Control Plane

执行 D0–D3 分级、确认、替代、废弃和封存。
