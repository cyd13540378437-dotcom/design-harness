# Output Contract / 输出物契约

## 1. 用户可见输出

- Input Understanding Feedback
- Next Best Question
- Choice-style Conclusion
- Human Decision Request
- Validation / Review Options

## 2. 过程输出

- Input Understanding Snapshot
- Analysis Routing Record
- Evidence Intake Record
- Model Selection Record
- Analysis Runs
- Decision Assurance Check
- Decision Network Update

## 3. 长期资产

- Decision Case
- Decision Network
- Evidence Ledger
- Decision Review

## 4. Work Item 输出

### `ANALYSIS_CONSUMPTION.md`

记录本轮读取了哪些本模块 Case、Network、Evidence、Review、用户输入和附件，以及哪些输入被当作 provisional。

### `ANALYSIS_OUTPUT.md`

记录新增、修改、保持不变、标记复审或替代的本模块长期资产。

### `DECISION_NOTES.md`

记录 D2 / D3 人类决定：用户选择、理由、被否决方案、接受的代价、影响范围和复审条件。

### `DECISION_PROCESS_PACKAGE.md`

压缩本次分析过程，但不复制完整长期 Case。

## 5. 最小合格回合

非平凡分析至少形成：

```text
Input Understanding Snapshot
Analysis Routing Record
Decision Case 当前版本
至少一个 Analysis Run，或明确说明无需专业模型
Counterfactual Analysis
Decision Assurance Check
Choice-style Conclusion
ANALYSIS_OUTPUT.md
Decision Process Package
```

若用户作出 D2 / D3 决定，还必须更新 `DECISION_NOTES.md`。
