# Analysis Model Card Protocol v0.1.4

## 1. 模型卡不是方法名

模型卡必须说明适用 / 不适用场景、最低输入、输出、误用风险、用户提问、运行 Prompt、Choice Delta 和质量检查。

## 2. 运行角色

- `internal_control`：商业分析自身推理纪律，quick / standard 默认不单独落盘。
- `professional_analysis`：针对具体商业问题运行，结果优先写入中文 `ANALYSIS_WORKSPACE.md`。

## 3. Choice-first 约束

Choice Loop 打开时，执行前必须明确模型会改变哪个选项、后果、推荐或置信度；执行后输出 Choice Delta。

## 4. Closure 与 Scope 约束

```text
choice_loop_status=closed
→ 除正式 review_signal 外，不得调用任何模型卡。
```

所有模型必须遵守 Decision Scope Lock，不得输出实施步骤、正式 Schema、公式权重、样例数据、代码或执行提议。

## 5. 结论出口

模型卡的 `conclusion_prompt` 只向中央综合器提供候选含义，不得直接向用户输出最终结论。
