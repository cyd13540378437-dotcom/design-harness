# Codex 开工单：实现 Color Card Registry 增量

请在现有 `codex-design-harness` Reference Library 版仓库基础上，实现 `docs/PRD.color-card-registry-v0.1.2.md` 定义的 Color Card Registry 增量。

## 工作方式

1. 先阅读现有 `docs/PRD.md`，确认 v0.1 的 Work Item、`STATE.md`、Gate、Skill/Steward 边界和非目标。
2. 再阅读 `docs/PRD.reference-library-v0.1.1.md`，确认 Reference Library、Surface Resolution、`REFERENCE_SELECTION.md` 和色卡预留结构。
3. 再阅读本次增量 PRD：`docs/PRD.color-card-registry-v0.1.2.md`。
4. 不要破坏 v0.1 原七个评测，也不要破坏 v0.1.1 的 Reference Library 评测。
5. 先输出简短实施计划，但不要重复 PRD。
6. 按 Milestone 顺序实现；每完成一个 Milestone，交叉检查路径、术语、枚举、示例和 README 是否一致。

## 严格范围

必须新增或修改：

- `templates/project/docs/design/reference-library/assets/color-cards/README.md`；
- `templates/project/docs/design/reference-library/assets/color-cards/palette-index.yml`；
- `templates/project/docs/design/reference-library/assets/color-cards/palette-index.md`；
- `templates/project/docs/design/reference-library/assets/color-cards/color-card.schema.yml`；
- `skills/design-engineering/SKILL.md` 中的配色确认规则；
- `skills/design-engineering/references/color-card-consumption.md`；
- `skills/design-engineering/assets/REFERENCE_SELECTION.template.md` 中的色卡小节；
- `skills/design-engineering/assets/STATE.template.md` 或相关说明中的色卡摘要边界；
- `templates/project/AGENTS.fragment.md` 中的 Color Card Registry 规则；
- `README.md`、`README.zh-CN.md`、`docs/architecture.md`、`docs/manual-test-guide.md` 中对应说明；
- `evals/scenarios/` 中的色卡完整性与配色确认评测；
- `docs/product-summary.color-card-registry-version.md`。

不得新增：

- `color-cards/cards/<id>/`；
- `reference-library/reference-packs/`；
- CLI；
- Hook；
- Plugin；
- 安装器；
- 自动截图下载器；
- 自动 OCR 或视觉识别流水线；
- 外部运行时依赖；
- Steward 的设计职责；
- 未经用户提供图片的具体 ready 色卡。

## 核心判断

- 色卡不是图片；图片只是色卡对象的一个资产。
- `palette-index.yml` 是 source of truth。
- `palette-index.md` 是人读索引。
- `Color Card = index entry + image + palette + annotation`。
- `images/`、`palettes/`、`annotations/` 继续保留集中式浏览体验。
- 任何正式资产都不得 orphan。
- `draft` 不得进入配色确认。
- `deprecated` 默认不推荐。
- 只有 `status: ready` 且 `gate_preview: true` 的色卡可进入 `visual-direction-approval`。
- 配色确认必须展示大图色卡和业务语义，不得只展示 HEX/RGB 或小 icon。
- Work Item 采用的色卡写入 `REFERENCE_SELECTION.md`；`STATE.md` 只保留摘要和链接。

## 建议实施顺序

### Milestone 1：色卡注册表模型

- 更新 `assets/color-cards/README.md`；
- 新增 `palette-index.yml`；
- 更新 `palette-index.md`；
- 更新 `color-card.schema.yml`。

### Milestone 2：Skill / AGENTS 消费规则

- 更新 `design-engineering/SKILL.md`；
- 新增 `skills/design-engineering/references/color-card-consumption.md`；
- 更新 `templates/project/AGENTS.fragment.md`。

### Milestone 3：Work Item 模板

- 更新 `REFERENCE_SELECTION.template.md`，加入 Color Direction Candidates 和 Approved Color Direction；
- 更新 `STATE.template.md` 或相关说明，加入色卡摘要边界。

### Milestone 4：README / architecture / manual test

- 更新中英文 README；
- 更新 architecture；
- 更新 manual test guide；
- 更新产品总结。

### Milestone 5：示例与评测

- 新增 orphan asset、id mismatch、ready-only、business-language color approval 评测；
- 自检 v0.1 和 v0.1.1 原评测仍成立。

## 最终回复请说明

1. 创建或修改了哪些核心文件；
2. Color Card Registry 与 Reference Library / Work Item / STATE.md 的关系；
3. `palette-index.yml` 如何保护图片、palette、annotation 的完整性；
4. 配色确认如何展示大图色卡，而不是 HEX/RGB 和小 icon；
5. 为什么没有采用每张色卡一个目录的方案；
6. 原 v0.1 七个评测是否仍成立；
7. v0.1.1 Reference Library 评测是否仍成立；
8. 新增 Color Card Registry 评测是否满足；
9. 当前明确未实现的 v0.2+ 或非目标能力。
