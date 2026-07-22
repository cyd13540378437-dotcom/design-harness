# BM Work Item 文件合同

## 1. 标准目录

每个持久化业务模型 Work Item 必须使用：

```text
docs/product/work-items/BM-xxx-<slug>/
├── STATE.md
├── MODELING_CONSUMPTION.md
├── MODELING_OUTPUT.md
├── DECISION_NOTES.md
└── artifacts/
    ├── MODEL_EXTRACTION_REPORT.md      # 按需
    ├── MODEL_CONSISTENCY_REPORT.md     # 发生模型写入时必须
    ├── MODEL_IMPACT_REPORT.md          # 被动触发时必须
    └── SOURCE_EVIDENCE.md              # 解析或证据链任务按需
```

四个根文件必须始终存在。Artifact 按入口模式生成。

## 2. 路径硬规则

- `MODELING_CONSUMPTION.md` 和 `MODELING_OUTPUT.md` 必须位于 Work Item 根目录；
- 不得把它们放入 `artifacts/`；
- 新运行不得生成 `PROPOSED_MODEL.md`、`EVIDENCE_AND_ASSUMPTIONS.md` 等平行别名；
- 读取旧项目时可将这些文件视为 legacy input，但必须迁移到标准文件名；
- `PRODUCT_WORK_ITEMS.md` 是索引，冲突时以各 Work Item 的 `STATE.md` 为准。

## 3. `STATE.md` Frontmatter 合同

允许的标准顶层字段：

```yaml
schema_version: 1
state_id: BM-000
title: ""
slug: ""
capability_id: product-business-modeling
entry_mode: direct_modeling
binding_decision: CREATE
status: active
phase: intake
knowledge_status: draft
awaiting_human: false
sealed: false
related_triggers: []
predecessors: []
created_at: YYYY-MM-DDTHH:mm:ssZ
updated_at: YYYY-MM-DDTHH:mm:ssZ
completed_at: ""
extensions: {}
```

运行时特有信息只能写入 `extensions` 或正文，不得自由增加 `model_status`、`semantic_confirmation_status`、`state_steward`、`downstream_compilation_status` 等平行顶层字段。

## 4. 状态边界

- 解析器只返回 `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`；
- 只有实际存在的 Work Item 才有 `STATE.md`，因此 `binding_decision` 只记录 `CREATE / RESUME / SUCCESSOR`；
- `sealed: true` 不得恢复或静默修改；
- AI 不得自行 seal；
- `knowledge_status` 不得高于实际业务语义确认程度。

## 5. 关闭前检查

有核心模型写入的 Work Item 在进入完成确认前必须具备：

- 标准根文件；
- 最新一致性报告；
- 已重新编译的 `BUSINESS_MODEL_OVERVIEW.md`；
- 已记录的 D2 / D3 决策状态；
- 需要时已重编译的专业下游视图；
- 未解决 critical issue 的明确阻断或人类接受记录。
