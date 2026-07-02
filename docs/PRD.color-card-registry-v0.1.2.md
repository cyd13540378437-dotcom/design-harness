# Codex Design Harness — Color Card Registry 增量 PRD

- **版本**：v0.1.2-alpha
- **文档状态**：可执行增量 PRD
- **基线版本**：v0.1.1-alpha / Reference Library 版
- **产品显示名**：Design Engineering Harness
- **新增核心能力**：Color Card Reference Registry
- **主要语言**：简体中文；配置字段、状态枚举和文件名使用英文

---

## 1. 产品摘要

v0.1.1 已经在 `docs/design/reference-library/assets/color-cards/` 下预留了色卡素材区，但只定义了目录，没有定义色卡知识对象如何表达、如何校验完整性、如何进入 `visual-direction-approval`。

v0.1.2 在 Reference Library 基础上，把色卡从“图片和解释的预留目录”升级为一个可消费、可校验、可用于配色确认的 **Color Card Reference Registry**：

```text
Color Card Registry
        ↓
Integrity Check
        ↓
Ready Color Cards
        ↓
Visual Direction + Color Direction Candidates
        ↓
visual-direction-approval
        ↓
REFERENCE_SELECTION.md + STATE.md summary
```

核心原则：

> 色卡不是图片；图片只是色卡对象的一个资产。正式色卡必须同时具备视觉图、结构化 palette、语义 annotation，并通过 index 进入可消费状态。

---

## 2. 背景与问题

Reference Library 版已经明确：`reference-library/` 是长期资料层，`REFERENCE_SELECTION.md` 是某个 Work Item 的消费结果，`STATE.md` 只保留摘要和链接。

但色卡目录如果只依赖文件名和人工约定，会出现以下问题：

1. `images/` 中有图片，但缺少对应 `palettes/` 或 `annotations/`；
2. 图片、palette、annotation 的文件名看似相同，但内部 `id` 不一致；
3. `palette-index.md` 只适合人看，不足以成为机器权威清单；
4. 色卡知识可能只剩 HEX/RGB 编码，用户仍然无法基于视觉感受确认配色；
5. Skill 可能把未完成的草稿图片展示给用户，导致配色确认不稳定。

v0.1.2 通过新增 `palette-index.yml`、完整性规则、状态生命周期和 Skill 消费协议，保护色卡知识生产结果的稳定性。

---

## 3. 本次增量目标

v0.1.2 必须实现：

1. 在 `assets/color-cards/README.md` 中写明 Color Card Registry 的完整规则；
2. 新增 `assets/color-cards/palette-index.yml`，作为机器可读 source of truth；
3. 保留集中式 `images/`、`palettes/`、`annotations/` 浏览结构，不采用每张色卡一个目录的方案；
4. 更新 `color-card.schema.yml`，定义 index entry、palette file 和 annotation frontmatter 的必需字段；
5. 明确 `Color Card = index entry + image + palette + annotation`；
6. 明确 `draft / ready / deprecated` 生命周期；
7. 明确 `status: ready` 且 `gate_preview: true` 的色卡才可进入配色确认；
8. 明确禁止 orphan color-card asset；
9. 更新 `design-engineering` Skill，使配色确认必须展示大图色卡卡片，而不是 HEX/RGB 和小 icon；
10. 更新 `REFERENCE_SELECTION.template.md`，增加 Color Direction Candidates 和 Approved Color Direction；
11. 更新 `STATE.template.md` 或其说明，只记录色卡选择摘要和链接，不吞掉完整色卡知识；
12. 更新项目 `AGENTS.fragment.md`，加入色卡完整性和消费规则；
13. 新增人工评测，验证 orphan assets、ready-only 展示和用户确认语言。

---

## 4. 非目标

v0.1.2 仍然不实现：

- 自动安装器；
- Codex Plugin；
- Marketplace；
- Hook；
- CLI；
- `statectl`；
- 自动截图下载；
- 自动 OCR；
- 自动视觉识别流水线；
- 云端素材库；
- 外部运行时依赖；
- 第三方版权图片托管；
- 自动生成全部色卡知识；
- 把色卡目录改成每张色卡一个独立文件夹；
- 让 `design_state_steward` 承担设计判断或色卡挑选职责。

Codex 可以在实现中增加文档型完整性检查步骤和人工评测，但不得新增脚本、CLI 或运行时依赖。

---

## 5. 核心概念

### 5.1 Color Card

一张完整的色卡知识对象，包含：

```text
视觉图 / image
+ 结构化 palette
+ 语义 annotation
+ index entry
```

它不是一组 HEX/RGB 编码，也不是单张图片。

### 5.2 Color Card Registry

`docs/design/reference-library/assets/color-cards/` 下的正式色卡资料注册表。

它属于 Reference Library，是长期资料层，不属于任何单个 Work Item。

### 5.3 `palette-index.yml`

机器可读的权威清单。

只有出现在 `palette-index.yml` 中，并且完整性校验通过的条目，才算正式色卡。

### 5.4 `palette-index.md`

人类可读索引，用于浏览色卡标题、摘要、适用终端、情绪关键词和状态。

它不是 source of truth，应从 `palette-index.yml` 的内容保持同步。

### 5.5 Palette File

位于：

```text
docs/design/reference-library/assets/color-cards/palettes/<color_card_id>.yml
```

用于保存颜色角色、近似 HEX、design token 建议、使用边界和无障碍风险。

### 5.6 Annotation File

位于：

```text
docs/design/reference-library/assets/color-cards/annotations/<color_card_id>.md
```

用于保存人类和 LLM 可读的色彩语义、适合场景、不适合场景、产品气质、确认话术和落地建议。

### 5.7 Image Asset

位于：

```text
docs/design/reference-library/assets/color-cards/images/<color_card_id>.png
```

用于在 `visual-direction-approval` 中以大图方式展示给用户。

### 5.8 Status

```text
draft       已有部分素材或知识，但未完整，不允许给用户确认
ready       通过完整性检查，可用于配色确认
deprecated  保留追溯，但默认不再推荐
```

---

## 6. 目录结构要求

v0.1.2 在 v0.1.1 色卡目录上新增 `palette-index.yml`：

```text
docs/design/reference-library/assets/color-cards/
├── README.md
├── palette-index.md
├── palette-index.yml          # 新增，机器权威清单
├── color-card.schema.yml
├── images/
│   └── .gitkeep
├── palettes/
│   └── .gitkeep
└── annotations/
    └── .gitkeep
```

### 6.1 明确不采用的结构

不得为了完整性而改成每张色卡一个目录：

```text
docs/design/reference-library/assets/color-cards/cards/<color_card_id>/
```

原因：设计过程中的集中图片浏览体验优先。`images/` 必须继续作为统一图库入口。

### 6.2 正式资产区

以下三个目录是正式资产区：

```text
images/
palettes/
annotations/
```

任何进入正式资产区的非 `.gitkeep` 文件，都必须属于 exactly one 个 `palette-index.yml` 条目。

---

## 7. 完整性合同：Color Card Integrity Contract

v0.1.2 必须在 README、Skill 规则和人工评测中固定以下合同：

> No orphan color-card asset. Any file under `images/`, `palettes/`, or `annotations/` must belong to exactly one valid color card entry. Any incomplete color card must not be shown to the user or written into `REFERENCE_SELECTION.md` as selected color reference.

### 7.1 必须满足的规则

1. 只有出现在 `palette-index.yml` 的条目，才算正式色卡；
2. 每个 `color_card_id` 必须唯一；
3. 每个 index entry 必须同时声明 `image`、`palette`、`annotation`；
4. `image`、`palette`、`annotation` 指向的文件必须真实存在；
5. `images/`、`palettes/`、`annotations/` 中每个正式文件必须被 exactly one 个 index entry 引用；
6. 文件名 stem 必须和 `id` 一致，例如 `ocean-wave-clear-cyan.png`、`ocean-wave-clear-cyan.yml`、`ocean-wave-clear-cyan.md`；
7. palette 文件必须声明同一个 `id`；
8. annotation 文件 frontmatter 必须声明同一个 `id`；
9. 只有 `status: ready` 的色卡可被 Skill 推荐；
10. 只有 `status: ready` 且 `gate_preview: true` 的色卡可出现在 `visual-direction-approval`；
11. `draft` 可以保存在 index 中，但不得展示给用户做最终配色确认；
12. `deprecated` 可以被只读引用，但默认不参与推荐。

### 7.2 不合法示例

```text
images/ocean-wave-clear-cyan.png
```

但缺少：

```text
palettes/ocean-wave-clear-cyan.yml
annotations/ocean-wave-clear-cyan.md
palette-index.yml 中的对应 entry
```

这种状态不合法。图片不能作为 ready 色卡被展示。

---

## 8. `palette-index.yml` 要求

示例结构：

```yaml
schema_version: 1
cards:
  - id: ocean-wave-clear-cyan
    title: 清透海浪蓝绿
    status: ready
    gate_preview: true

    image: images/ocean-wave-clear-cyan.png
    palette: palettes/ocean-wave-clear-cyan.yml
    annotation: annotations/ocean-wave-clear-cyan.md

    surfaces:
      - web-app
      - responsive-web
      - mobile-app
    mood_tags:
      - 清透
      - 冷静
      - 可信
      - 科技感
      - 流动感
    business_semantics:
      best_for:
        - AI 助手
        - 数据工具
        - 效率工作台
      avoid_for:
        - 强促销页面
        - 高热度社群产品
    user_facing_summary: 适合冷静、可信、清爽、有流动感的产品界面。
    token_hint: 深蓝做主行动，青蓝做高亮，雾白蓝做页面背景。
    accessibility_risk_level: medium
```

必填字段：

```text
id
title
status
gate_preview
image
palette
annotation
surfaces
mood_tags
user_facing_summary
accessibility_risk_level
```

---

## 9. Palette File 要求

示例：

```yaml
schema_version: 1
id: ocean-wave-clear-cyan
title: 清透海浪蓝绿
source_image: ../images/ocean-wave-clear-cyan.png

colors:
  - role: primary
    name: 深海蓝
    hex: "#006C9F"
    usage: 主按钮、关键导航、重要状态
  - role: secondary
    name: 亮青蓝
    hex: "#1CA6D9"
    usage: 链接、图表高亮、轻量强调
  - role: accent
    name: 蓝绿色
    hex: "#2BB6B3"
    usage: 成功反馈、AI 反馈、辅助强调
  - role: soft_background
    name: 浅水蓝
    hex: "#86D2E4"
    usage: 卡片背景、空状态、轻量区域
  - role: page_background
    name: 雾白蓝
    hex: "#E8F4F6"
    usage: 页面底色、低噪音背景

token_suggestions:
  color.primary: primary
  color.accent: accent
  color.background: page_background
  color.surface.tint: soft_background

accessibility_notes:
  - 浅蓝背景上不要直接使用低饱和青色小字。
  - 主 CTA 应优先使用最深色阶保证对比度。
```

HEX 可以是近似值，但必须服务于 token 转化；用户确认时不得只展示 HEX。

---

## 10. Annotation File 要求

annotation 文件必须包含 frontmatter：

```markdown
---
schema_version: 1
id: ocean-wave-clear-cyan
title: 清透海浪蓝绿
status: ready
---
```

正文至少包含：

```markdown
# 清透海浪蓝绿

## 用户可见摘要

## 色彩气质

## 适合的产品语义

## 不适合的产品语义

## 界面落地建议

## Token 转化建议

## 无障碍与可读性风险

## visual-direction-approval 展示话术
```

`visual-direction-approval` 展示话术必须面向业务判断，例如：

```text
这是一套清透、冷静、可信的蓝绿色方案。适合 AI 助手、数据工具和效率工作台。代价是情绪偏冷，不适合强促销或强社群活跃场景。
```

---

## 11. Skill 消费规则增量

`design-engineering` Skill 必须新增以下行为：

1. 在视觉方向阶段，如果 `assets/color-cards/` 存在，读取 `palette-index.yml`；
2. 在展示候选色卡前执行完整性检查；
3. 排除 `draft`、`deprecated`、缺少任一资产、id 不一致、未被 index 引用或被多处引用的色卡；
4. 只展示 `status: ready` 且 `gate_preview: true` 的色卡；
5. 展示时必须使用大图色卡卡片，并附带业务语义、适合场景、代价和推荐用法；
6. 不得让用户通过 HEX/RGB 编码加小 icon 做配色确认；
7. 可以在说明中展示近似 HEX，但只能作为实现补充；
8. 用户批准后，把色卡 ID、title、image path、palette path、annotation path 和用户批准摘要写入 `REFERENCE_SELECTION.md`；
9. `STATE.md` 只写色卡选择摘要与链接；
10. 实现阶段根据 palette file 转成设计 token 或局部 CSS 变量，不直接复制图片本身。

### 11.1 配色确认展示格式

推荐格式：

```text
方向 A：清透海浪蓝绿
[展示 images/ocean-wave-clear-cyan.png 大图]

适合：冷静可信、AI / 数据 / 效率工具、低噪音工作台
代价：情绪偏冷，不适合强促销或强社群活跃氛围
推荐用法：深蓝做主行动，青蓝做状态反馈，雾白蓝做背景
```

不允许的格式：

```text
方案 A：#006C9F + #1CA6D9 + #2BB6B3
[一个很小的色块 icon]
```

---

## 12. `REFERENCE_SELECTION.md` 增量

Work Item 的 `REFERENCE_SELECTION.md` 应新增：

```markdown
## Color Direction Candidates

| ID | Title | Status | Image | Why Relevant | Tradeoff |
|---|---|---|---|---|---|

## Approved Color Direction

- Color Card ID:
- Title:
- Image:
- Palette:
- Annotation:
- User approved summary:
- Token conversion notes:
- Accessibility notes:
```

只有通过完整性检查的 ready 色卡可以进入这些小节。

---

## 13. `STATE.md` 增量

`STATE.md` 的“参考资源摘要”或“已批准决定”中只记录：

```markdown
- 已批准配色方向：清透海浪蓝绿
- Color Card：`ocean-wave-clear-cyan`
- Reference Selection：`./REFERENCE_SELECTION.md`
- 采用摘要：深蓝主行动、青蓝强调、雾白蓝背景；保持冷静、可信、清爽。
- 风险摘要：浅蓝背景上的小字对比度需验证。
```

不得把完整 annotation、完整 palette 表格或色卡图片分析复制进 `STATE.md`。

---

## 14. Steward 边界增量

`design_state_steward` 仍然只管理状态。

它可以：

- 在 `STATE.md` 中记录已批准的 Color Card ID、title、摘要和 `REFERENCE_SELECTION.md` 链接；
- 在 Gate 前写入等待用户确认配色方向的 checkpoint；
- 在用户批准后记录批准决定。

它不得：

- 选择色卡；
- 判断色彩气质；
- 生成 palette 或 annotation；
- 修改 Reference Library 以补齐色卡；
- 修改 sealed 状态补充新色卡。

---

## 15. AGENTS.fragment 增量

项目级规则必须新增：

```markdown
### Color Card Registry

- `docs/design/reference-library/assets/color-cards/palette-index.yml` 是色卡机器权威清单。
- `images/`、`palettes/`、`annotations/` 中不得存在 orphan 正式资产。
- 一张正式色卡必须同时拥有 image、palette、annotation 和 index entry。
- 只有 `status: ready` 且 `gate_preview: true` 的色卡可用于 `visual-direction-approval`。
- 配色确认必须向用户展示大图色卡和业务语义，不得只展示 HEX/RGB 或小 icon。
- Work Item 采用的色卡必须写入 `REFERENCE_SELECTION.md`；`STATE.md` 只写摘要和链接。
```

---

## 16. README 增量

`assets/color-cards/README.md` 必须解释：

1. 色卡不是图片，而是 reference object；
2. 为什么保留集中式 `images/` 浏览体验；
3. `palette-index.yml` 是 source of truth；
4. `palette-index.md` 是人读索引；
5. `draft / ready / deprecated` 的含义；
6. No orphan asset 规则；
7. 新增色卡的步骤；
8. 配色确认时如何展示给用户；
9. `STATE.md` 和 `REFERENCE_SELECTION.md` 如何记录；
10. 如何处理不完整或无法确认来源的素材。

---

## 17. 知识生产规则

新增色卡时必须遵循：

```text
1. 为色卡分配稳定 id；
2. 添加 images/<id>.png；
3. 添加 palettes/<id>.yml；
4. 添加 annotations/<id>.md；
5. 添加 palette-index.yml entry；
6. 更新 palette-index.md；
7. 执行完整性自检；
8. 只有通过后才把 status 改为 ready。
```

如果只有图片，尚未完成 palette 和 annotation，不得放入 `images/` 作为 ready 资产。可以保持 `status: draft`，但不能进入用户确认。

若 Codex 无法可靠查看图片或判断图像内容，应停止并说明需要用户提供视觉描述或可查看的图片，不得凭文件名臆造色彩知识。

---

## 18. 示例与评测增量

### 18.1 Orphan image 不得通过

Given：`images/ocean-wave-clear-cyan.png` 存在，但缺少 `palettes/ocean-wave-clear-cyan.yml`。

When：Skill 准备配色候选。

Then：该色卡不得进入候选；应报告为 incomplete，并继续使用其他 ready 色卡或要求补齐。

### 18.2 Ready-only preview

Given：`palette-index.yml` 中存在 `draft`、`ready`、`deprecated` 三种色卡。

When：进入 `visual-direction-approval`。

Then：只展示 `status: ready` 且 `gate_preview: true` 的色卡。

### 18.3 用户基于色卡视觉和业务语义确认

Given：有一张完整 ready 色卡。

When：Skill 请求用户确认配色。

Then：必须展示大图色卡、色彩气质、适合场景、代价和推荐用法；不得只展示 HEX/RGB 和小 icon。

### 18.4 ID mismatch 不得通过

Given：index id 为 `ocean-wave-clear-cyan`，palette 文件内 id 为 `ocean-wave-blue`。

When：执行完整性检查。

Then：该色卡不得进入 ready 候选。

### 18.5 Work Item 记录边界

Given：用户批准某色卡作为配色方向。

When：更新 Work Item。

Then：`REFERENCE_SELECTION.md` 记录完整色卡引用与转化原则，`STATE.md` 只记录摘要和链接。

---

## 19. 与 v0.1.1 的对比

| 模块 | v0.1.1 Reference Library | v0.1.2 Color Card Registry |
|---|---|---|
| 色卡 | 预留 `color-cards/` 目录，不预填具体色卡 | 定义正式色卡对象、index、schema、完整性规则 |
| Index | `palette-index.md` 人读索引 | 新增 `palette-index.yml` 作为机器权威清单 |
| 知识完整性 | 未定义 | No orphan asset、id 一致、ready-only |
| 配色确认 | 未定义具体展示协议 | 大图色卡 + 业务语义 + 代价 + token 建议 |
| Work Item 消费 | `REFERENCE_SELECTION.md` 记录参考选择 | 增加 Color Direction Candidates / Approved Color Direction |
| STATE.md | 记录参考摘要和链接 | 记录色卡选择摘要和链接，不吞掉完整色卡知识 |
| 目录体验 | `images/` 集中存放 | 保留集中图库，不采用 per-card folder |

---

## 20. Definition of Done 增量

- [ ] `assets/color-cards/README.md` 包含 Color Card Integrity Contract；
- [ ] 新增 `palette-index.yml`；
- [ ] 更新 `palette-index.md`，说明其为人读索引而非 source of truth；
- [ ] 更新 `color-card.schema.yml`，包含 index、palette、annotation 的必填字段；
- [ ] 保留集中式 `images/`、`palettes/`、`annotations/` 结构；
- [ ] 没有创建 `color-cards/cards/<id>/`；
- [ ] Skill 文档明确配色确认必须展示大图色卡；
- [ ] Skill 文档明确不得只用 HEX/RGB 和小 icon 让用户确认；
- [ ] `REFERENCE_SELECTION.template.md` 包含 Color Direction Candidates 和 Approved Color Direction；
- [ ] `STATE.template.md` 或说明包含色卡摘要记录规则；
- [ ] `AGENTS.fragment.md` 包含 ready-only 和 no-orphan 规则；
- [ ] 新增 orphan、ready-only、business-language color approval 评测；
- [ ] 不预填具体色卡，除非用户明确提供图片并要求进行知识生产；
- [ ] 不新增 CLI、Hook、Plugin、脚本或外部依赖；
- [ ] v0.1 原七个评测仍成立；
- [ ] v0.1.1 Reference Library 评测仍成立。

---

## 21. 实施顺序建议

### Milestone 1：色卡注册表模型

- 更新 `assets/color-cards/README.md`；
- 新增 `palette-index.yml`；
- 更新 `palette-index.md`；
- 更新 `color-card.schema.yml`。

### Milestone 2：Skill / AGENTS 消费规则

- 更新 `design-engineering/SKILL.md`；
- 新增或更新 `skills/design-engineering/references/color-card-consumption.md`；
- 更新 `templates/project/AGENTS.fragment.md`。

### Milestone 3：Work Item 模板

- 更新 `REFERENCE_SELECTION.template.md`；
- 更新 `STATE.template.md` 或相关说明，加入色卡摘要边界。

### Milestone 4：README / architecture / manual test

- 更新中英文 README；
- 更新 architecture；
- 更新 manual test guide。

### Milestone 5：示例与评测

- 新增色卡完整性评测；
- 新增 ready-only 配色确认评测；
- 新增用户基于大图色卡和业务语义确认的评测；
- 自检 v0.1 和 v0.1.1 原评测仍成立。
