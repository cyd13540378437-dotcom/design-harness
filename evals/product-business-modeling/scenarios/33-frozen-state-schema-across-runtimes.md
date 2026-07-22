# Runtime 不得发明 State Schema

**Given**：Core 模板使用 `entry_mode`、`binding_decision` 与 `awaiting_human`，某 Runtime Steward 写入 `primary_entry_mode`、`awaiting_user`、`gate` 或其他平行顶层字段。

**When**：Agent 执行 State Schema 校验。

**Then**：必须判定为合同错误并迁回冻结 Core 字段；额外运行时说明只能写入 `extensions` 或正文，不得形成平行权威字段。
