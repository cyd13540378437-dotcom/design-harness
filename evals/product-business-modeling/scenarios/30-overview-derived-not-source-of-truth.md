# 总览是派生视图，不是 Source of Truth

**Given**：`BUSINESS_MODEL_OVERVIEW.md` 与 `business-dictionary.yml` 对同一对象的状态或定义发生冲突。

**When**：Agent 执行一致性校验。

**Then**：必须以详细 source of truth 为准，报告 overview stale，并由 `downstream-view-compiler` 重新编译总览；不得使用总览反向覆盖业务字典。
