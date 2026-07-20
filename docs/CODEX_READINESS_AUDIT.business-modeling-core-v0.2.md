# Codex Readiness Audit — Business Modeling Core v0.2 Reviewed

## Verdict

当前 Core 包已经足够交给 Codex 执行业务模型 Core 落仓；本 reviewed 版补充了 UX / Design Engineering 兼容性说明，并修正了两个规格不一致点。

## Checked Scope

- Core / Adapter / Project Assets 分层
- 业务属性与数据字段边界
- `schema-view.json` 五项边界
- `model-triggers/` 与 `MODEL_IMPACT_REPORT.md`
- Human Decision Control Plane
- Downstream Views
- 14 个 Given / When / Then 评测
- 与既有 Design Engineering Harness / `docs/design/` 的兼容性

## Findings

### Ready

- 业务模型自身定义、协议、模板、示例和评测已经能指导 Codex 建立文档型 Core 包。
- 非目标范围清楚：不做 CLI、Hook、Plugin、安装器、外部运行时依赖、数据库迁移或 API 生成。
- 核心业务模型不会把数据库字段写入 source of truth。
- Project Extraction、Downstream Compilation 和 Passive Trigger 都有明确边界。

### Fixed in reviewed package

1. 增加 `ux-design-engineering-compatibility.md`，明确 Business Modeling 不直接修改 `docs/design/`。
2. 增加 `ux-design-engineering-view.md` 派生视图模板，用于表达业务模型变化对 UX 的影响。
3. 更新 Codex 开工单，要求检查既有 Design Engineering Harness 并保护 UX 资产。
4. 统一 Trigger 状态，补充 `dismissed` / `superseded` 作为有理由的终止状态。
5. 统一 `requirements-view.md` 命名，替换旧的 `requirement-expression-view.md`。

## UX Impact Conclusion

Business Modeling Core 会影响 UX，但影响是“语义输入和触发关系”，不是“直接改写 UX 设计资产”。

会影响 UX 的点包括：对象身份、对象关系、业务动作、状态生命周期、规则权限、横向语义冲突。这些影响应进入 `MODEL_IMPACT_REPORT.md` 和 `ux-design-engineering-view.md`，必要时触发 Design Engineering Successor。

不会被 Business Modeling Core 直接修改的 UX 资产包括：

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/*/STATE.md
docs/design/work-items/*/REFERENCE_SELECTION.md
docs/design/reference-library/**
docs/design/reference-library/assets/color-cards/**
```

## Remaining Non-blocking Suggestions

- 未来可以为产品表达、需求表达和 UX 各自定义正式 Trigger 协议，以便跨 Cluster 全链路闭环更稳定。
- 未来可以把 `PRODUCT_WORK_ITEMS.md` 与 `docs/design/WORK_ITEMS.md` 的跨索引关系做成更明确的 federated index，但 v0.2 不需要实现。
