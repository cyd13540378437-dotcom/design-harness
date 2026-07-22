# Output Contract / 输出物契约 v0.1.2

## 1. 中文用户可见输出

```text
输入理解反馈
下一最有决策价值的问题
中文阶段性决策摘要
Human Decision Request
验证或复审选择
```

所有用户可见输出默认使用简体中文。

## 2. 长期资产

```text
Decision Case
Decision Network
Evidence Ledger
Decision Review
```

## 3. Work Item 根目录

```text
STATE.md
ANALYSIS_CONSUMPTION.md
ANALYSIS_OUTPUT.md
DECISION_NOTES.md
DECISION_SUMMARY.md
DECISION_PROCESS_PACKAGE.md
```

`DECISION_SUMMARY.md` 是唯一的中文用户可见结论文件名；不得再创建平行的“商业分析结论”文件。

## 4. 过程 artifacts

全部位于：

```text
work-items/BA-xxx/artifacts/
```

包括：

```text
INPUT_UNDERSTANDING_SNAPSHOT.md
TURN_CONTINUITY_CHECK.md
ANALYSIS_ROUTING_RECORD.md
EVIDENCE_INTAKE_RECORD.md
MODEL_SELECTION_RECORD.md
ANALYSIS_RUNS.md
DECISION_ASSURANCE_CHECK.md
DECISION_SYNTHESIS.md
DECISION_NETWORK_UPDATE.md
```

其中 `TURN_CONTINUITY_CHECK.md` 是滚动检查点，只在 standard / deep、总结、决定、复审、范围变化或连续性风险时更新；不为每轮创建新文件。

不得在 Work Item 根目录放置过程文件，不得创建临时 `intake/` 目录。

## 5. 按深度生成

- `quick`：更新 Case、STATE、中文 Decision Summary，加必要的轻量分析；可不创建 Turn Check 或完整 Process Package。
- `standard`：生成必要消费、输出、模型、Assurance、Turn Continuity 和中央综合记录。
- `deep`：生成完整 Process Package、全部必要审计材料和正式复审计划。

不得为了模板完整而创建无价值空文件。

## 6. 中文版本合同

- 所有项目级人读 Markdown 输出必须有完整简体中文内容。
- 英文可以作为运行时 Prompt、稳定 ID、文件名、状态枚举或机器字段。
- 用户要求英文时，可额外生成英文 companion，但中文主版本不能缺失。
