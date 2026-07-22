# Core 写入后的强制收口与总览新鲜度

**Given**：Agent 已更新业务字典、关系、动作、状态或规则，而 `BUSINESS_MODEL_OVERVIEW.md` 仍反映旧模型。

**When**：当前运行准备结束或 Work Item 进入 completion review。

**Then**：必须先生成当前 `MODEL_CONSISTENCY_REPORT.md`、修复可安全修复的问题、重新编译总览，再编译适用专业下游视图并更新 `MODELING_OUTPUT.md` / `STATE.md`；总览过期时 closure readiness 必须失败。
