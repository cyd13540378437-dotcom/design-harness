# Codex 开工单：实现 Product Business Modeling v0.2.3

请以 v0.2.2 runtime-aware 为基线，实现 v0.2.3。

## 必须先读

1. `docs/PRD.product-business-modeling-v0.2.3.md`
2. `core/product-design/business-modeling/CAPABILITY.md`
3. `core/product-design/business-modeling/protocols/business-model-overview.md`
4. `core/product-design/business-modeling/protocols/validation-and-evals.md`

## 实施顺序

### Milestone 1：用户总览

- 新增 Core overview 模板和编译协议；
- 新增项目模板 `docs/product/BUSINESS_MODEL_OVERVIEW.md`；
- 明确唯一默认用户入口与派生边界。

### Milestone 2：协议归一化

- 固定 canonical Work Item 文件；
- 统一 State Schema；
- 强化 Dictionary / Index / Schema；
- 强化 Decision Package、Action / State / Rule 引用。

### Milestone 3：一致性校验

- 增加 lifecycle object boundary；
- 增加 contextual attribute placement；
- 增加 ambiguous object identity；
- 增加 overview freshness；
- 所有 Core 写入后强制调用 validator。

### Milestone 4：Adapters 与示例

- 更新 Shared / Codex / Claude Code / Cursor；
- 更新 state steward；
- 更新 runtime overlays；
- 将示例升级为 canonical Work Item + overview。

### Milestone 5：评测与验收

- 保留全部旧评测；
- 新增 v0.2.3 场景；
- 校验 YAML / JSON / TOML / Markdown 链接；
- 清理 zip 元数据；
- 产出 manifest 和 readiness audit。

## 严格范围

不得新增 CLI、Hook、Plugin、Installer、外部依赖或业务代码。

## 最终回复

说明：

1. 总览如何成为唯一用户入口；
2. 原有文件如何继续保留；
3. 哪些协议问题已修复；
4. 示例与评测结果；
5. 语法、链接和压缩包校验结果。
