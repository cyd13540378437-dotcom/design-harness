# Design Engineering Harness 产品总结说明（Color Card Registry 版）

## 1. 产品定位

Design Engineering Harness 是一套面向 Codex 的 Human-in-the-loop UI/UX 设计工程工作流。

Reference Library 版已经把产品视觉参考资料沉淀为长期资料层；Color Card Registry 版在此基础上，把色卡从“预留素材文件夹”升级为可被 Agent 检索、可被用户直观看见、可被 Work Item 稳定消费的第一等视觉参考对象。

一句话：

> Thread 是工作现场，Work Item 是任务身份，STATE.md 是权威状态快照，Reference Library 是长期视觉参考资料层，REFERENCE_SELECTION.md 是本任务如何消费资料库的记录，Color Card Registry 是可视化配色参考的完整性登记系统。

---

## 2. 本版解决的问题

v0.1.1 已经预留了：

```text
docs/design/reference-library/assets/color-cards/
├── README.md
├── palette-index.md
├── color-card.schema.yml
├── images/
├── palettes/
└── annotations/
```

但如果只靠文件夹和相似文件名，色卡知识会很容易退化为散落素材：图片存在、结构化 palette 缺失、annotation 没有同步、索引忘记更新，最终导致 Agent 在配色确认时拿不出稳定、可解释、可追溯的候选。

Color Card Registry 版补上的核心规则是：

```text
Color Card = palette-index.yml entry + image + palette + annotation
```

色卡不是图片本身，图片只是色卡对象的一个视觉资产。

---

## 3. 与 Reference Library 版的关系

Reference Library 版的三层关系保持不变：

```text
reference-library = 长期可复用资料
REFERENCE_SELECTION.md = 某个 Work Item 本次实际消费的参考
STATE.md = 本任务状态、批准决定和证据摘要
```

Color Card Registry 是 `reference-library/assets/color-cards/` 内的子能力。它不改变 Work Item、Gate、Steward 或 sealed 状态模型，只让配色确认可以使用完整的大图色卡和业务语义。

---

## 4. 当前产品核心流程

```text
用户提出 UI/UX 任务
        ↓
状态解析：CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
        ↓
业务理解：用户、任务、成功标准、约束
        ↓
终端判断：web-app / mobile-app / responsive-web / desktop-app / tablet / multi-surface
        ↓
参考检索：从 reference-library 按终端、页面类型、任务类型筛选
        ↓
色卡检索：从 palette-index.yml 读取 ready + gate_preview 色卡
        ↓
Work Item 参考选择：写入 REFERENCE_SELECTION.md
        ↓
视觉方向与配色方向：展示大图色卡，用业务语言给出 2–3 个方向和推荐
        ↓
visual-direction-approval
        ↓
静态原型
        ↓
prototype-approval
        ↓
关键 UX 决策
        ↓
生产实现
        ↓
目标终端 QA，对照 Reference Selection 与色卡方向
        ↓
completion-approval
        ↓
用户批准后 completed + sealed
```

---

## 5. Color Card Registry 结构

```text
docs/design/reference-library/assets/color-cards/
├── README.md
├── palette-index.md          # 人类可读索引
├── palette-index.yml         # 机器权威索引，新增
├── color-card.schema.yml     # 字段和完整性约束
├── images/
│   └── <color_card_id>.png
├── palettes/
│   └── <color_card_id>.yml
└── annotations/
    └── <color_card_id>.md
```

仍然保留集中式 `images/` 目录，因为设计过程中的图片浏览体验很重要。禁止改成：

```text
color-cards/cards/<id>/card.png
color-cards/cards/<id>/palette.yml
color-cards/cards/<id>/annotation.md
```

这个替代结构会降低图库浏览效率，不作为本产品方向。

---

## 6. 完整性契约

Color Card Registry 使用 `palette-index.yml` 作为 source of truth。

一张色卡只有在以下条件全部满足时，才算正式进入 Reference Library：

1. `palette-index.yml` 中存在唯一 `id`；
2. entry 同时声明 `image`、`palette`、`annotation`；
3. 三个路径都真实存在；
4. `images/`、`palettes/`、`annotations/` 中的正式文件都被 exactly one 个 entry 引用；
5. 文件名 stem 与 `id` 一致；
6. palette 文件与 annotation 文件声明同一个 `id`；
7. 只有 `status: ready` 的色卡可被消费；
8. 只有 `status: ready` 且 `gate_preview: true` 的色卡可进入 `visual-direction-approval` 候选。

简写规则：

> No orphan color-card asset. Any file under `images/`, `palettes/`, or `annotations/` must belong to exactly one valid color card entry.

---

## 7. 状态生命周期

```yaml
status: draft | ready | deprecated
```

含义：

- `draft`：素材或知识尚未完整，不允许展示给用户确认；
- `ready`：图像、palette、annotation 和索引完整，可被 Skill 消费；
- `deprecated`：保留追溯价值，但默认不再推荐。

---

## 8. 用户确认体验

错误体验：

```text
请选择 #006C9F / #1CA6D9 / #23B8B5。
```

正确体验：

```text
方向 A：清透海浪蓝绿
[展示大图色卡]

适合：冷静、可信、清爽、有流动感的产品界面。
代价：情绪偏冷，不适合强促销或强社群场景。
建议：深蓝做主按钮和导航，青蓝做强调，雾白蓝做背景。
```

HEX / RGB / token 只能作为实现细节，不作为用户决策的主要语言。

---

## 9. 关键角色分工

### design-engineering Skill

- 读取 `palette-index.yml`；
- 过滤 incomplete / draft / deprecated 色卡；
- 在视觉方向确认时展示大图色卡和业务语义；
- 把最终采用的色卡写入 Work Item 的 `REFERENCE_SELECTION.md`；
- 实现阶段把 approved color direction 转为 design token 使用建议；
- QA 阶段检查界面是否符合批准的色彩方向。

### design_state_steward

- 仍然只管理状态；
- 可以在 `STATE.md` 记录已批准色卡摘要和 `REFERENCE_SELECTION.md` 链接；
- 不挑选色卡，不解释色彩，不修改 `reference-library`；
- 不为了补色卡而修改 sealed Work Item。

### Reference Library

- 保存长期、跨任务复用的色卡资料；
- 不保存某个 Work Item 专属的配色选择；
- 不允许孤儿图片或孤儿 palette / annotation。

---

## 10. 当前版本边界

Color Card Registry 版仍然是文档型产品，不做自动化平台。

明确不做：

- 自动安装器；
- Plugin；
- Hook；
- CLI；
- 自动图片分析脚本；
- 自动 OCR；
- 自动下载第三方截图或色卡；
- 云端素材库；
- 外部运行时依赖。

它的价值在于把“色卡知识如何表达、如何展示、如何完整、如何被 Work Item 消费”沉淀为稳定规则。
