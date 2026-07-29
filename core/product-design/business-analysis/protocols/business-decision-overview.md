# 商业决策总览编译协议

## 1. 目的

`docs/product/business-analysis/BUSINESS_DECISION_OVERVIEW.md` 是商业分析模块的默认交付出口。

它解决的是“当前项目有哪些重要商业选择、推荐与待确认问题”的阅读体验，不替代 Decision Case：

```text
Decision Case / Decision Network / Evidence Ledger = 商业分析 source of truth
BUSINESS_DECISION_OVERVIEW.md = 面向用户的当前商业决策编译视图
```

项目交付层可以引用本总览，但不得从项目交付层反写 Decision Case。

## 2. 路径与所有权

固定路径：

```text
docs/product/business-analysis/BUSINESS_DECISION_OVERVIEW.md
```

固定写入者：

```text
business-analysis-orchestrator
```

该文件必须声明：

```yaml
view_type: business_decision_overview
audience: product_owner
is_default_module_delivery_view: true
is_project_delivery_entry: false
is_source_of_truth: false
```

不得把它放入某个 Work Item 的 `artifacts/`，也不得用 `ANALYSIS_OUTPUT.md`、`DECISION_SUMMARY.md` 或聊天回复替代。

## 3. 编译输入

至少消费：

```text
BUSINESS_ANALYSIS_INDEX.yml
BUSINESS_ANALYSIS_WORK_ITEMS.md
相关 decision-cases/BA-DC-xxx.md
相关 work-items/BA-xxx/STATE.md
相关 work-items/BA-xxx/DECISION_SUMMARY.md
相关 work-items/BA-xxx/DECISION_NOTES.md
Decision Network
Evidence Ledger
Claim-level Assurance / DECISION_ASSURANCE_CHECK（若存在）
```

只允许从商业分析模块自有资产编译。不得读取、修改或触发兄弟能力资产来补全本总览。

## 4. 必需内容

总览必须让用户仅阅读这一份文件即可回答：

1. 当前商业分析模块正在支持哪些业务选择；
2. 每个重要选择的推荐是什么；
3. 哪些选择已确认、暂缓、拒绝、修改或仍待确认；
4. 推荐依赖哪些证据、假设和边界；
5. 什么条件会改变推荐或触发复审；
6. 用户现在需要回复什么；
7. 哪些内容只是概念级验证路径，不是实施方案；
8. 权威 Decision Case 和证据文件在哪里。

若存在待确认选择，总览必须包含完整的决策压缩：当前理解、现实选项、主要代价、推荐、证据边界和可直接回复格式。用户不应被迫打开 `DECISION_NOTES.md` 或审计文件才知道如何决策。

## 5. 编译时机

以下情况必须更新总览：

- 新建或更新 Decision Case 后；
- 形成或更新 Choice Set 与推荐后；
- 写入 `DECISION_SUMMARY.md` 后；
- 用户决定被记录、修改、拒绝或暂缓后；
- 新证据改变推荐、置信度或复审条件后；
- Decision Network 或 Evidence Ledger 发生相关变化后；
- Work Item 进入 completion review 前。

强制收口顺序：

```text
更新 Decision Case / Evidence / Network
→ 更新 Work Item State 和必要 Summary / Notes
→ 执行 Claim-level Assurance
→ 编译 BUSINESS_DECISION_OVERVIEW.md
→ 更新 Work Item 输出状态
```

## 6. 新鲜度与失败处理

总览 frontmatter 必须记录：

```text
decision_overview_status
choice_loop_status
recommendation_status
assurance_status
generated_at
source_cases
source_work_items
source_assets
```

若关键 Case 缺少足够证据：

- 总览仍可生成；
- `decision_overview_status` 必须为 `partial` 或 `provisional`；
- 不得把推荐描述为已证明；
- 必须在“证据边界与复审条件”中写清楚哪些声明是 provisional / conditional / blocked。

若总览与 Decision Case 冲突，以 Decision Case 为准；该冲突本身必须作为商业分析一致性问题修复并重新编译。

## 7. 用户交付规则

商业分析任务的常规最终回复默认突出：

```text
docs/product/business-analysis/BUSINESS_DECISION_OVERVIEW.md
```

单个活跃 Case 的用户交互仍可引用对应 `DECISION_SUMMARY.md`，但项目级或跨 Case 汇总不应让用户在多个 Work Item 目录中寻找当前推荐。

## 8. 与其他文件的关系

- `Decision Case`：商业决策 source of truth；
- `DECISION_SUMMARY.md`：单个 Work Item 当前轮次结论；
- `DECISION_NOTES.md`：用户决定完整审计记录；
- `ANALYSIS_WORKSPACE.md`：影响 Choice Set 的专业分析工作区；
- `Decision Network`：决策关系和复审线索；
- `Evidence Ledger`：证据登记与边界；
- `BUSINESS_DECISION_OVERVIEW.md`：上述资产的用户交付出口。
