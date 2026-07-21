---
schema_version: 1
case_id: BA-DC-001
title: 未激活邀请是否占用付费 Seat
status: confirmed
created_at: "2026-07-21"
updated_at: "2026-07-21"
owner: product-owner
---

# Decision Case: 未激活邀请是否占用付费 Seat

## 0. 原始输入

### First User Input

> 未激活邀请要不要占用付费 Seat？我不希望客户觉得为还没使用产品的人付费，但也担心无限邀请会造成滥用。

### Input Metadata

- Created at: 2026-07-21
- Source: user conversation
- Attachments: none
- User-stated urgency: medium
- User-stated desired outcome: 形成可执行且公平的计费原则

## 1. 当前问题

- Status: confirmed
- Interpreted decision question: 在按 Seat 收费的 Workspace 中，待接受邀请是否应计入付费容量；若不计入，如何控制滥用？
- User confirmation: confirmed

## 2. 为什么现在需要处理

- Trigger: 即将明确邀请与账单规则
- Urgency: 中等
- If ignored: 客户账单理解、邀请限制和客服处理可能不一致

## 3. 决策范围

### 包含

- 已发送但尚未接受的成员邀请
- 付费 Seat 容量
- 待接受邀请上限

### 不包含

- 已激活成员的计费
- 免费计划整体设计
- 技术数据结构和实现

### 适用对象 / 场景 / 时间范围

B2B Workspace 的标准订阅计划；当前版本政策。

## 4. 关键线索

| Clue | Source | Relevance | Status |
|---|---|---|---|
| 客户不愿为未使用成员付费 | user | high | confirmed concern |
| 完全不限制邀请可能被滥用 | user | high | provisional |

## 5. 已知事实

| Fact | Source | Confidence | Date |
|---|---|---|---|
| 当前讨论采用按 Seat 计费 | user-confirmed scope | high | 2026-07-21 |
| 未激活邀请尚未产生实际成员使用 | definition for this case | medium | 2026-07-21 |

## 6. 重要假设

| Assumption | Why needed | If wrong | Status |
|---|---|---|---|
| 客户把 Seat 理解为实际可使用成员 | 判断公平性 | 若 Seat 是预留容量，则待接受邀请可合理占用 | provisional |
| 待接受邀请上限足以控制滥用 | 形成折中方案 | 可能仍需短期预留或其他政策 | provisional |

## 7. 相关证据

| Evidence | Supports / Refutes | Strength | Limitation |
|---|---|---|---|
| 用户明确提出公平性担忧 | 支持不立即计费 | medium | 尚无客户样本数据 |
| 滥用风险为合理运营推断 | 支持设置上限 | weak | 尚无实际滥用数据 |

## 8. 专业分析工作区

### 8.1 Analysis Runs

#### AR-001: 方案评估

- Model ID: option-assessment
- Purpose: 比较立即占用、不占用、短期预留三类政策
- Why selected: 当前已形成清晰选项
- Inputs used: 计费公平性、滥用风险、规则复杂度
- Analysis output: 不占用 + 上限在公平性与风险之间最平衡
- Implications: 需清晰说明待接受邀请不计费但受数量限制
- Limitations: 缺乏实际滥用和账单争议数据
- Confidence: provisional
- Case fields updated: 9, 10, 12, 13

#### AR-002: 反方分析

- Model ID: counterfactual-opposition
- Purpose: 检查不做限制、立即计费和折中方案的失败方式
- Analysis output: 立即计费损害公平感；完全不限制提高滥用风险；折中方案增加一条规则但可逆
- Confidence: medium

### 8.2 Models Considered but Not Used

| Model | Why considered | Why not used |
|---|---|---|
| NPV | 涉及收入 | 缺少现金流，且问题是局部政策而非投资项目 |
| SWOT | 通用战略工具 | 该问题不是战略环境扫描 |

### 8.3 Cross-model Synthesis

两个分析均支持“不计费 + 限制待接受邀请数量”的可逆折中策略。

## 9. 可选方案

| Option | Description | Included? | Notes |
|---|---|---|---|
| A | 发出邀请即占用付费 Seat | yes | 规则保守，但公平性弱 |
| B | 接受邀请后才占用；待接受邀请无限制 | yes | 公平但滥用风险高 |
| C | 接受后占用；待接受邀请设上限 | yes | 推荐，增加轻量规则 |
| D | 邀请后短期预留，超时释放 | yes | 适合未来若容量预留成为价值 |

## 10. 主要权衡

| Option | Value | Cost | Risk | Reversibility |
|---|---|---|---|---|
| A | 易控制容量 | 客户为未使用者付费 | 账单争议 | medium |
| B | 最符合实际使用 | 容量控制弱 | 大量邀请滥用 | high |
| C | 公平与风险平衡 | 多一条上限规则 | 上限需调优 | high |
| D | 表达容量预留 | 规则和提示复杂 | 用户难理解 | medium |

## 11. 反方观点 / 不做会怎样

### 不做的损失

规则长期模糊，销售、客服和产品可能给出不同解释。

### 做了的代价

推荐方案需要引入待接受邀请数量上限和对应说明。

### 当前建议可能错在哪里

若客户购买的本质是预留容量，而不是实际成员使用，待接受邀请不占用可能低估价值。

### 更小、更可逆的选择

先采用默认上限，并通过账单争议和邀请滥用率调整。

## 12. 当前结论

- Conclusion type: confirmed operational policy
- System recommendation: 选择 C
- User decision: 未激活邀请默认不占用付费 Seat；设置待接受邀请数量上限
- Status: confirmed

## 13. 验证方式

- What to test: 邀请滥用、账单争议、客户理解
- How to test: 观察支持工单、超限事件和政策反馈
- Success threshold: 没有显著滥用，账单争议保持低位
- Failure threshold: 超限规避频繁或客户仍误解计费
- Review date: 2026-10-21

## 14. 复审条件

| Trigger | Why it matters | Action if triggered |
|---|---|---|
| 改为预购容量 | Seat 价值语义变化 | 重开 Case |
| 滥用显著增加 | 上限策略不足 | 复审 B/C/D |
| 客户要求容量锁定 | 可能需要预留机制 | 评估 D |

## 15. 关联决策

### depends_on

- 按 Seat 收费的当前业务假设

### affects

- 邀请政策
- 账单解释

### conflicts_with

- none

### supersedes

- none

### reopens

- none
