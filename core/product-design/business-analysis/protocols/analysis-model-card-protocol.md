# Analysis Model Card Protocol

Analysis Model Card 是可复用的专业分析知识对象，同时也是受控 Prompt 模板。

它不是方法名列表。

## 1. Card 必须回答

```text
这个模型适合什么问题？
不适合什么问题？
需要哪些输入？
最低可运行输入是什么？
会产出什么？
会更新 Decision Case 哪些字段？
使用时怎样问用户？
执行时怎样分析？
结果怎样写入 Analysis Workspace？
怎样转成选择题式结论？
如何防止误用？
```

## 2. usage_prompts 必填

每张 ready 模型卡必须包含：

```text
routing_prompt
user_input_prompt
execution_prompt
analysis_run_prompt
conclusion_prompt
misuse_guard_prompt
```

## 3. Model Card 与 Analysis Run

```text
Analysis Model Card = 长期可复用专业方法知识
Analysis Run = 某个 Decision Case 中实际运行该模型后的结果
Analysis Workspace = 保存所有 Analysis Runs 的位置
```

## 4. 不能看到关键词就套模型

例如：

```text
用户说“投资” ≠ 一定使用 NPV
用户说“战略” ≠ 一定使用 SWOT
用户说“流程” ≠ 一定使用 SIPOC
```

必须先判断输入是否满足模型适用条件和最低输入要求。

## 5. 被考虑但未使用的模型也要记录

如果某个模型看起来相关但未使用，应写入 `Models Considered but Not Used`。

例如：

```text
未使用 NPV：当前没有可靠现金流、折现率和投资周期。强行计算会制造伪精确。
```


## Prompt 完整性合同

每张 `status: ready` 的卡必须具有非空：

```text
routing_prompt
user_input_prompt
execution_prompt
analysis_run_prompt
conclusion_prompt
misuse_guard_prompt
```

Prompt 必须能在不知道其他能力存在的情况下独立执行。
