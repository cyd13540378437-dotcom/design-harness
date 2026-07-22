# 业务模型总览编译协议

## 1. 目的

`docs/product/BUSINESS_MODEL_OVERVIEW.md` 是业务负责人、产品负责人和非建模专业用户的唯一默认阅读入口。

它解决的是**阅读与决策体验**，不是替代底层模型资产：

```text
详细模型资产 = 权威事实与可维护结构
BUSINESS_MODEL_OVERVIEW.md = 面向用户的当前模型编译视图
```

底层对象、关系、动作、状态、规则、权限、风险、下游视图、Work Item 和证据文件继续按原定义保留。

## 2. 路径与所有权

固定路径：

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

固定写入者：

```text
downstream-view-compiler
```

该文件必须声明：

```yaml
view_type: business_model_overview
audience: product_owner
is_default_user_entry: true
is_source_of_truth: false
```

不得把它放入某个 Work Item 的 `artifacts/`，也不得使用 `PROPOSED_MODEL.md`、`MODEL_SUMMARY.md` 等临时文件替代。

## 3. 编译输入

至少消费：

```text
BUSINESS_MODEL_INDEX.yml
business-dictionary.yml
schema-view.json
相关 domain-objects/
relationships/
actions/
states/
rules/
roadmap/
risks/
当前 Work Item 的 MODELING_OUTPUT.md
当前 Work Item 的 DECISION_NOTES.md
当前 MODEL_CONSISTENCY_REPORT.md
```

只允许从 source of truth 和任务级权威记录编译，不得从过期下游视图反向拼装核心事实。

## 4. 必需内容

总览必须让用户仅阅读这一份文件即可回答：

1. 这个产品或业务模型是什么；
2. 当前包含什么、不包含什么；
3. 核心对象和端到端流程是什么；
4. 关键规则、权限和责任是什么；
5. 当前版本建议开发什么；
6. 哪些内容已确认，哪些只是 provisional；
7. 现在需要用户确认什么；
8. 主要风险和最近一次更新是什么。

若存在待确认 D2 / D3 判断，总览中必须包含完整的决策压缩：当前理解、重要性、方案、优缺点、推荐和可直接回复的选项。用户不应被迫打开 `DECISION_NOTES.md` 才能做决定。

## 5. 编译时机

以下情况必须更新总览：

- 新建或更新任何核心 source-of-truth 资产后；
- Greenfield Modeling 完成初始模型后；
- Human Decision 被记录或变更后；
- 一致性校验改变了问题清单或校验状态后；
- 下游能力范围或一期建议发生变化后；
- Work Item 进入 completion review 前。

强制收口顺序：

```text
写入核心资产
→ 执行 consistency_validation
→ 修复可安全修复的问题
→ 编译 BUSINESS_MODEL_OVERVIEW.md
→ 编译其他必要下游视图
→ 更新 MODELING_OUTPUT.md 与 STATE.md
```

## 6. 新鲜度与失败处理

总览 frontmatter 必须记录：

```text
source_model_version
source_model_status
validation_status
generated_at
source_work_item
source_assets
```

若一致性校验发现未解决问题：

- 总览仍可生成；
- `validation_status` 必须为 `issues_found`；
- 不得把模型描述为“已确认完成”；
- 必须在“主要风险与观察点”中压缩呈现阻塞问题。

若总览与 source of truth 冲突，以 source of truth 为准；该冲突本身是 consistency error，必须重新编译。

## 7. 用户交付规则

业务模型任务的常规最终回复只突出：

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

不得默认向用户抛出长文件清单。详细文件仅在用户明确要求审计、开发交接或查看证据时再按需提供。

## 8. 与其他文件的关系

- `BUSINESS_MODEL_INDEX.md`：模型维护者导航，不是用户入口；
- `BUSINESS_MODEL_INDEX.yml`：机器索引；
- `MODELING_OUTPUT.md`：记录“这次改了什么”，不是当前完整模型；
- `DECISION_NOTES.md`：完整审计记录；总览只提供足以让用户决策的压缩版本；
- `STATE.md`：任务恢复快照，不是业务模型说明书；
- `downstream-views/*`：面向特定下游角色的派生视图。
