# Analysis Model Card Protocol v0.1.2

Analysis Model Card 是专业分析知识对象和受控 Prompt 合同，不是方法名列表。

## 1. ready 卡必填七类 Prompt

```text
decision_relevance_prompt
routing_prompt
user_input_prompt
execution_prompt
analysis_run_prompt
conclusion_prompt
misuse_guard_prompt
```

## 2. 运行规则

- `decision_relevance_prompt`：先判断模型会不会改变当前业务选择。
- `routing_prompt`：内部判断是否适用。
- `user_input_prompt`：只有缺少会改变选项排序的输入时才问用户。
- `execution_prompt`：内部执行分析。
- `analysis_run_prompt`：写入 Analysis Workspace，必须包含 Decision Delta。
- `misuse_guard_prompt`：内部自检。
- `conclusion_prompt`：只向中央决策综合器返回候选含义，禁止直接对用户收尾。

## 3. Analysis Run 必填

```text
model_id
purpose
decision_relevance
inputs_used
analysis_output
decision_delta
implications
limitations
confidence
```

## 4. 中文输出

模型内部 Prompt 可以使用英文或中文，但写入项目的 Analysis Run、用户问题和结论必须有中文版本。
