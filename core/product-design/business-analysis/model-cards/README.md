# Analysis Model Card Registry

Analysis Model Card 不是方法名清单，而是：

```text
专业模型知识
+ 适用 / 不适用条件
+ 输入和输出合同
+ 常见误用
+ 质量检查
+ 六类受控 Prompt
```

每次实际使用卡片，会在 Decision Case 的 Analysis Workspace 和 Work Item 的 `ANALYSIS_RUNS.md` 中生成一个 Analysis Run。

## 六类 Prompt

```text
routing_prompt       判断是否应该使用
user_input_prompt    以低负担方式获取最低必要输入
execution_prompt     执行模型
analysis_run_prompt  结构化记录结果
conclusion_prompt    转成选择题式输出
misuse_guard_prompt  检查误用和伪精确
```

只有满足 `analysis-model-card.schema.yml` 的卡可以标记为 ready。
