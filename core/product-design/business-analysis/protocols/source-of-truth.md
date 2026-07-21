# Source of Truth

## 1. 唯一项目根目录

```text
docs/product/business-analysis/
```

商业分析的所有长期资产和 Work Item 均位于此目录。它不依赖共享 `docs/product/work-items/`。

## 2. 长期资产

| 知识类型 | Source of Truth |
|---|---|
| Decision Case | `decision-cases/BA-DC-xxx.md` |
| Case 索引 | `BUSINESS_ANALYSIS_INDEX.md/yml` |
| Work Item 索引 | `BUSINESS_ANALYSIS_WORK_ITEMS.md` |
| 决策关系 | `decision-network/DECISION_NETWORK.yml`；Markdown 为人读视图 |
| 证据索引 | `evidence/EVIDENCE_LEDGER.yml`；Markdown 为人读视图 |
| 决策复审 | `reviews/BA-DR-xxx.md` |

## 3. Work Item 资产

```text
work-items/BA-xxx/
├── STATE.md
├── ANALYSIS_CONSUMPTION.md
├── ANALYSIS_OUTPUT.md
├── DECISION_NOTES.md
├── DECISION_PROCESS_PACKAGE.md
└── artifacts/
    ├── INPUT_UNDERSTANDING_SNAPSHOT.md
    ├── ANALYSIS_ROUTING_RECORD.md
    ├── EVIDENCE_INTAKE_RECORD.md
    ├── MODEL_SELECTION_RECORD.md
    ├── ANALYSIS_RUNS.md
    ├── DECISION_ASSURANCE_CHECK.md
    └── DECISION_NETWORK_UPDATE.md
```

## 4. 单一权威规则

- Work Item 内不得存在第二份 `DECISION_CASE.md`。
- `STATE.md` 只链接 primary Decision Case 和当前状态。
- `ANALYSIS_OUTPUT.md` 记录本轮如何修改长期资产。
- `DECISION_NOTES.md` 只记录明确的人类决定和高影响确认。
- `DECISION_PROCESS_PACKAGE.md` 是过程压缩，不是 Decision Case 的替代源。
- YML 是 Network / Evidence 的机器权威源；MD 是人读视图。

## 5. 独立性

不得在本协议中建立指向其他能力 source of truth 的写入所有权。其他能力即使存在，也只作为仓库中需要保护的兄弟目录。
