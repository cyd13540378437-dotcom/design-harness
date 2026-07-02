# Codex Prompt：生产 Color Card Reference 知识

你将在当前仓库中为 Design Engineering Harness 的 Color Card Registry 生产色卡知识。

## 开始前必须阅读

1. `docs/PRD.md`
2. `docs/PRD.reference-library-v0.1.1.md`
3. `docs/PRD.color-card-registry-v0.1.2.md`
4. `docs/design/reference-library/assets/color-cards/README.md`
5. `docs/design/reference-library/assets/color-cards/color-card.schema.yml`
6. `docs/design/reference-library/assets/color-cards/palette-index.yml`
7. `skills/design-engineering/references/color-card-consumption.md`

## 你的任务

基于用户提供的色卡图片或明确指定的本地图片路径，生产完整的 Color Card Reference 知识。

每张正式色卡必须包含：

```text
palette-index.yml entry
+ images/<id>.png
+ palettes/<id>.yml
+ annotations/<id>.md
+ palette-index.md 人读摘要
```

## 输入来源

优先使用用户明确提供的本地图片路径，例如：

```text
docs/design/reference-library/assets/color-cards/images/<id>.png
```

如果用户只提供了一批图片但没有命名，请先为每张图片生成稳定 slug，使用小写英文、数字和连字符，例如：

```text
ocean-wave-clear-cyan
warm-sunset-coral
soft-sage-productivity
```

如果当前仓库中没有可查看的色卡图片，也没有用户提供的图片说明，请停止并向用户说明需要图片或明确视觉描述；不要凭空创建 ready 色卡。

## 重要限制

- 不要下载外部图片。
- 不要使用第三方版权图片作为新资产，除非用户已经合法提供并要求写入。
- 不要新增 CLI、Hook、Plugin、脚本或外部依赖。
- 不要创建 `color-cards/cards/<id>/`。
- 不要创建 `reference-library/reference-packs/`。
- 不要把 Work Item 专属选择写入 `reference-library/`。
- 不要把完整色卡分析写入 `STATE.md`。
- 不要只生产 HEX/RGB；必须生产用户可理解的色彩语义和业务使用建议。
- 如果你无法可靠查看图片内容，不得臆造色彩气质；应请求用户补充说明或把条目标为 `draft`。

## 生产流程

### Step 1：盘点输入

列出本次要处理的图片：

```text
- source path
- proposed id
- whether image is viewable
- whether user supplied description exists
```

### Step 2：为每张图片建立或确认 id

要求：

- id 使用英文小写、数字和连字符；
- id 要描述视觉气质，不要只描述文件编号；
- 文件名 stem 必须等于 id；
- 如果需要重命名图片，请说明并执行。

### Step 3：生成 palette file

为每张色卡创建：

```text
docs/design/reference-library/assets/color-cards/palettes/<id>.yml
```

必须包含：

```yaml
schema_version: 1
id: <id>
title: <中文标题>
source_image: ../images/<id>.png
colors:
  - role: primary
    name: <中文色名>
    hex: "#______"
    usage: <适合用法>
  - role: secondary
    name: <中文色名>
    hex: "#______"
    usage: <适合用法>
  - role: accent
    name: <中文色名>
    hex: "#______"
    usage: <适合用法>
  - role: soft_background
    name: <中文色名>
    hex: "#______"
    usage: <适合用法>
  - role: page_background
    name: <中文色名>
    hex: "#______"
    usage: <适合用法>
token_suggestions: {}
accessibility_notes: []
```

HEX 可以是近似值，但必须服务于实现转化；用户确认时不能只展示 HEX。

### Step 4：生成 annotation file

为每张色卡创建：

```text
docs/design/reference-library/assets/color-cards/annotations/<id>.md
```

必须包含 frontmatter：

```markdown
---
schema_version: 1
id: <id>
title: <中文标题>
status: draft | ready
---
```

正文必须包含：

```markdown
# <中文标题>

## 用户可见摘要

## 色彩气质

## 适合的产品语义

## 不适合的产品语义

## 界面落地建议

## Token 转化建议

## 无障碍与可读性风险

## visual-direction-approval 展示话术
```

展示话术必须像这样面向业务判断：

```text
这是一套清透、冷静、可信的蓝绿色方案。适合 AI 助手、数据工具和效率工作台。代价是情绪偏冷，不适合强促销或强社群活跃场景。
```

不要写成：

```text
请选择 #006C9F + #1CA6D9。
```

### Step 5：更新 palette-index.yml

为每张色卡添加或更新条目：

```yaml
schema_version: 1
cards:
  - id: <id>
    title: <中文标题>
    status: draft | ready | deprecated
    gate_preview: true | false
    image: images/<id>.png
    palette: palettes/<id>.yml
    annotation: annotations/<id>.md
    surfaces:
      - web-app
      - responsive-web
    mood_tags:
      - <标签>
    business_semantics:
      best_for:
        - <场景>
      avoid_for:
        - <场景>
    user_facing_summary: <用户可见摘要>
    token_hint: <一句话 token 转化建议>
    accessibility_risk_level: low | medium | high
```

只有满足以下条件才可设为 `ready`：

- image 存在；
- palette 存在；
- annotation 存在；
- 三处 id 一致；
- 用户或模型已经可靠理解图片内容；
- 有明确业务语义；
- 有 token 建议；
- 有无障碍风险说明。

否则设为 `draft` 且 `gate_preview: false`。

### Step 6：更新 palette-index.md

用人类可读方式汇总每张色卡：

```markdown
| ID | Title | Status | Preview | Mood | Best For | Risk |
|---|---|---|---|---|---|---|
| ocean-wave-clear-cyan | 清透海浪蓝绿 | ready | images/ocean-wave-clear-cyan.png | 清透、冷静、可信 | AI / 数据 / 效率工具 | medium |
```

并说明 `palette-index.yml` 是 source of truth。

### Step 7：完整性自检

逐项检查：

1. `palette-index.yml` 中每个 id 唯一；
2. 每个 entry 同时声明 image、palette、annotation；
3. 每个路径真实存在；
4. 文件名 stem 等于 id；
5. palette 内 id 等于 index id；
6. annotation frontmatter id 等于 index id；
7. `images/`、`palettes/`、`annotations/` 中无 orphan 正式资产；
8. `draft` 或 `deprecated` 没有 `gate_preview: true`；
9. 没有只靠 HEX/RGB 作为用户确认内容；
10. 没有把完整色卡知识写入 `STATE.md`。

## 输出要求

完成后回复：

1. 新增或修改了哪些色卡；
2. 哪些是 `ready`，哪些是 `draft`，为什么；
3. 是否存在跳过的图片，原因是什么；
4. 完整性自检结果；
5. 用户在 `visual-direction-approval` 中会看到哪些大图色卡候选；
6. 任何需要用户确认的内容。
