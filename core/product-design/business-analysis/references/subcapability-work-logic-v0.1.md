# 子能力工作逻辑 v0.1

## 1. 统筹与路由

| 中文 | ID | 职责 |
|---|---|---|
| 商业分析总协调器 | `business-analysis-orchestrator` | 入口模式、Work Item、调用顺序、输出收敛 |
| 输入理解器 | `decision-input-interpreter` | 保留原始输入、生成理解快照、控制理解确认 |
| 决策案例路由器 | `decision-case-router` | 新建、继续、补证据、复审、冲突、影响、无 Case |
| 下一最佳问题规划器 | `next-best-question-planner` | 选择信息增益最高的 1–2 个问题 |

## 2. 核心决策分析

| 中文 | ID | 职责 |
|---|---|---|
| Decision Case 管理器 | `decision-case-manager` | 创建、更新、压缩 16 字段 Case |
| 分析模型选择器 | `analysis-model-selector` | 选择 Model Cards 并记录未使用原因 |
| 专业分析运行器 | `analysis-model-runner` | 执行 usage prompts，生成 Analysis Runs |
| 选项与权衡综合器 | `option-tradeoff-synthesizer` | 生成真实选项、权衡和可逆性 |
| 反方分析器 | `counterfactual-opposition-analyzer` | 不做、做错、维持现状、更小选择 |

## 3. 复审、风险与决策记忆

| 中文 | ID | 职责 |
|---|---|---|
| 验证与复审规划器 | `validation-review-planner` | 验证动作、阈值、复审条件 |
| 决策网管理器 | `decision-network-manager` | 维护 Case 关系，不产生跨能力 Trigger |
| 决策复审器 | `decision-reviewer` | 新证据下复审旧决定，保留历史 |

## 4. 材料接收、项目提取与质量保障

| 中文 | ID | 职责 |
|---|---|---|
| 证据接收分类器 | `evidence-intake-classifier` | 分类、相关性、采用/弃用、证据账本 |
| 项目决策提取器 | `project-decision-extractor` | 从现有文档恢复候选 Case；默认 provisional |
| 决策质量保障器 | `decision-assurance-validator` | pass / warn / block，检查模型适配与结论边界 |

## 5. Human Decision Control Plane

横切以上全部子能力，执行 D0–D3 分级、用户确认、状态升级和封存控制。

## 6. 禁止越界

任何子能力都不得：

- 修改其他能力资产；
- 创建跨能力 Trigger；
- 把 Decision Network 关系解释成模块依赖；
- 在 Work Item 内创建第二份 Decision Case；
- 替用户确认 D2 / D3 决定。
