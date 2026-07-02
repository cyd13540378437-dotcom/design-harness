# v0.1.1 → v0.1.2 差异与增量说明

## 一句话

v0.1.1 建立了 Product Visual Reference Library；v0.1.2 将其中预留的 `assets/color-cards/` 升级为可校验、可消费、可用于配色确认的 Color Card Reference Registry。

## 最大变化

1. 新增 `palette-index.yml` 作为色卡机器权威清单。
2. 将色卡定义为 `index entry + image + palette + annotation`，而不是单张图片或一组颜色代码。
3. 在 `README.md` 中固定 Color Card Integrity Contract。
4. 明确禁止 orphan color-card asset。
5. 保留集中式 `images/` 浏览体验，不采用每张色卡一个目录的方案。
6. 增加 `draft / ready / deprecated` 生命周期。
7. 只有 `status: ready` 且 `gate_preview: true` 的色卡可进入 `visual-direction-approval`。
8. 配色确认必须展示大图色卡和业务语义，不得只展示 HEX/RGB 或小 icon。
9. Work Item 的 `REFERENCE_SELECTION.md` 增加 Color Direction Candidates 与 Approved Color Direction。
10. `STATE.md` 只记录色卡选择摘要与链接，不吞掉完整色卡知识。

## 文件级增量

| 路径 | 动作 | 目的 |
|---|---|---|
| `docs/PRD.color-card-registry-v0.1.2.md` | 新增 | Color Card Registry 增量 PRD |
| `docs/PRD.v0.1.1-to-v0.1.2-color-card-registry-delta.md` | 新增 | 本差异说明 |
| `docs/product-summary.color-card-registry-version.md` | 新增 | 更新后的产品总结 |
| `CODEX_BUILD_BRIEF.color-card-registry.md` | 新增 | 给 Codex 的实现开工单 |
| `CODEX_PROMPT.color-card-knowledge-production.md` | 新增 | 给 Codex 的色卡知识生产 Prompt |
| `templates/project/docs/design/reference-library/assets/color-cards/README.md` | 修改 | 写入完整性合同、生命周期、生产规则和消费规则 |
| `templates/project/docs/design/reference-library/assets/color-cards/palette-index.yml` | 新增 | 机器可读色卡注册表 |
| `templates/project/docs/design/reference-library/assets/color-cards/palette-index.md` | 修改 | 人读索引，说明 source of truth 为 YAML |
| `templates/project/docs/design/reference-library/assets/color-cards/color-card.schema.yml` | 修改 | 定义 index、palette、annotation 字段 |
| `skills/design-engineering/references/color-card-consumption.md` | 新增 | Skill 的色卡消费细则 |
| `skills/design-engineering/assets/REFERENCE_SELECTION.color-card-section.template.md` | 新增 | 可合并进 REFERENCE_SELECTION 模板的色卡小节 |
| `templates/project/AGENTS.fragment.color-card-registry.md` | 新增 | 可合并进 AGENTS.fragment.md 的项目规则 |
| `evals/scenarios/14-color-card-registry-integrity.md` | 新增 | Orphan / id mismatch 评测 |
| `evals/scenarios/15-color-card-ready-only-visual-gate.md` | 新增 | ready-only gate 展示评测 |
| `evals/scenarios/16-color-card-business-language-confirmation.md` | 新增 | 大图色卡 + 业务语义确认评测 |

## 不变项

- 状态解析枚举仍是 `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`。
- Gate 枚举不变，不新增 `color-approval`；配色确认属于 `visual-direction-approval`。
- `reference-library/` 仍是长期资料层。
- `REFERENCE_SELECTION.md` 仍是 Work Item 级消费结果。
- `STATE.md` 仍只保存最小权威摘要。
- `design_state_steward` 仍只管理状态，不负责设计判断和色卡挑选。
- `completed + sealed` 仍不可被修改补充色卡。
- 仍不做 CLI、Hook、Plugin、安装器、自动截图下载、自动 OCR、外部依赖。

## 编码重点

Codex 实现时应优先保证：

1. 不创建 `color-cards/cards/<id>/`；
2. `palette-index.yml` 是 source of truth；
3. `images/`、`palettes/`、`annotations/` 下无 orphan 正式资产；
4. 文件名 stem、index id、palette id、annotation frontmatter id 一致；
5. `draft` 与 `deprecated` 不进入用户配色确认；
6. 用户看到的是大图色卡和业务语义，而不是 HEX/RGB 列表；
7. `REFERENCE_SELECTION.md` 记录完整色卡引用；
8. `STATE.md` 只写摘要和链接；
9. 不预填具体色卡，除非用户明确提供图片并要求知识生产；
10. 原 v0.1 七个评测和 v0.1.1 Reference Library 评测仍通过。
