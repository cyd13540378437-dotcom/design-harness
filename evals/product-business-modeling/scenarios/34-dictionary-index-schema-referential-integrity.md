# Dictionary / Index / Schema 引用完整性

**Given**：`schema-view.json` 中存在 `work_order`，但 `business-dictionary.yml.business_objects` 或 `BUSINESS_MODEL_INDEX.yml.business_objects` 未登记该对象；或三处对同一业务属性使用不同 stable ID。

**When**：执行一致性校验。

**Then**：必须报告引用完整性错误；对象和业务属性的 stable ID 在 Dictionary、Schema 和适用 Index 引用中一致后才能通过。
