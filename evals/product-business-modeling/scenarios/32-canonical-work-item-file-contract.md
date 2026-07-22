# Canonical Work Item 文件合同

**Given**：一个 BM Work Item 只有 `artifacts/PROPOSED_MODEL.md`、`artifacts/EVIDENCE_AND_ASSUMPTIONS.md`，或把 `MODELING_CONSUMPTION.md` 放在 `artifacts/` 下。

**When**：Agent 检查任务文件结构。

**Then**：必须报告合同错误，并迁移为 Work Item 根目录下的 `STATE.md`、`MODELING_CONSUMPTION.md`、`MODELING_OUTPUT.md`、`DECISION_NOTES.md`，以及按入口模式生成的标准 artifacts；legacy 别名不得替代 canonical 文件。
