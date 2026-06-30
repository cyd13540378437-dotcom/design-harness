---
schema_version: 1
state_id: "DE-004"
title: "个人备忘录从头开始"
slug: "personal-memo-from-scratch"
scope_type: "work-item"
release: ""

status: "active"
phase: "prototype"
gate: "prototype-approval"
awaiting_user: true
sealed: false

mode: "full"
predecessors: []
related_items: ["DE-002"]
approved_gates:
  - gate: "work-item-binding"
    approved_at: "2026-06-30T23:52:33+08:00"
    summary: "design_state_steward 返回 CREATE。用户明确说“从头开始”，因此创建 DE-004，不继续等待 completion-approval 的 DE-002。"
  - gate: "visual-direction-approval"
    approved_at: "2026-06-30T23:57:14+08:00"
    summary: "用户选择方向 1：快速捕捉型。后续以快速记录入口、最近备忘、轻标签和清楚保存状态为主，可吸收少量低刺激视觉原则。"
  - gate: "visual-direction-approval"
    approved_at: "2026-07-01T00:11:33+08:00"
    summary: "用户回复“继续”，批准配色 A “墨白速记”后的 7 条设计禁区，并授权进入静态原型。"

created_at: "2026-06-30T23:52:33+08:00"
updated_at: "2026-07-01T00:17:02+08:00"
completed_at: ""
---

# Work Item 状态

## 任务摘要

从头设计一个个人备忘录产品体验，重点是快速记录、低干扰回看、轻量组织和可信保存/删除反馈。该任务不延续 DE-002 的暖白极简结果，只把它作为仓库中已有的相关历史只读参考。

## 范围

### 包含

- 个人备忘录的产品方向、视觉方向和移动优先信息架构。
- 快速记录入口、最近备忘列表、搜索、标签/轻分类、置顶或收藏、删除恢复提示。
- 空状态、保存中/已保存/保存失败、长文本和无结果状态的设计要求。
- `REFERENCE_SELECTION.md` 记录本任务如何消费 Reference Library。
- 后续可进入静态 HTML/CSS 原型。

### 不包含

- 继续或关闭 DE-002。
- 真实账号、云同步、数据库、加密、推送提醒或后端服务。
- 企业团队协作、复杂项目管理、看板、日历工作流。
- 将当前 Work Item 标记为 completed + sealed。

## 设计对象与终端

- Primary surface: `mobile-app`
- Secondary surfaces: `responsive-web`
- Explicitly out of scope: native desktop app, enterprise dashboard, continuing DE-002
- Evidence: 个人备忘录的核心场景是随手记录和稍后回看，天然适合移动优先；响应式 Web 可作为后续桌面整理入口。
- Open questions: 第一轮原型是否只做手机视口，还是同时做桌面响应式延展。

## 参考资源摘要

- Reference Selection: [REFERENCE_SELECTION.md](REFERENCE_SELECTION.md)
- 采用的参考原则：快速捕捉、低噪音文档感、空状态激活、低刺激反馈。
- 明确不采用：不延续 DE-002 作为既定视觉基线；不采用 Web SaaS dashboard、游戏化路径或内容发现流。
- 版权边界：仅用于内部设计分析和模式抽象，不复制第三方品牌资产、图标、插画、文案或完整页面布局。

## 验收标准

- 用户能在首屏立即理解“这里可以快速写下一条备忘”。
- 记录入口足够近，不被筛选、分类或装饰遮挡。
- 最近备忘、置顶/收藏、标签/轻分类和搜索之间的层级清楚。
- 保存、保存失败、删除进入回收站和恢复提示明确。
- 390px 手机宽度下无横向溢出，主要操作单手可触达。
- 视觉风格与 DE-002 有明确区分，体现“从头开始”的新方向。
- 后续原型必须覆盖空、加载、错误或保存失败中的至少一种状态。

## 当前检查点

已创建 DE-004，并完成 Surface Resolution、Reference Selection、视觉方向确认、配色确认和设计禁区确认。已创建第一版 390px 手机静态原型。当前等待用户在 `prototype-approval` Gate 检查并批准或要求修改原型。

原型检查点：prototype-review

已确认方向：

- 快速捕捉型：首屏写入优先，最近备忘其次，标签/搜索/置顶后置但可见；保存状态要短、清楚、可信。
- 风格边界：更像随手记录工具，不做厚重日记、不做效率看板、不沿用 DE-002 的暖白极简基线。

已确认配色：A / 墨白速记

- 背景：`#F7F7F4`
- 主要表面：`#FFFFFF`
- 主文字：`#20211F`
- 次级文字：`#62665F`
- 边框/分隔：`#E1E3DC`
- 主操作：`#2D5A3E`
- 轻标签：`#E3ECDD`
- 成功/保存：`#2F7D4E`
- 警告/删除恢复：`#B26A2C`

已确认设计禁区：

1. 不做仿纸张、胶带、贴纸、手帐装饰或拟物纹理。
2. 不做效率看板、数据仪表盘、多列项目管理或复杂筛选台。
3. 不让标签、分类、搜索或排序挡在“立即写一条”之前。
4. 不使用大面积高饱和背景、紫蓝渐变、发光装饰或浮动色块。
5. 不加入社交、团队、分享、公开发布或协作暗示。
6. 不弱化保存、保存失败、删除、恢复等可信反馈；状态必须可见但不吵。
7. 不用营销式欢迎页或功能说明页替代真实输入界面；首屏必须可操作。

已创建原型：

- 原型入口：[../../prototypes/DE-004-personal-memo-from-scratch/index.html](../../prototypes/DE-004-personal-memo-from-scratch/index.html)
- 手机截图：[artifacts/prototype-mobile-390.png](artifacts/prototype-mobile-390.png)
- 覆盖内容：快速输入区、保存状态、轻标签、最近备忘列表、置顶备忘、删除按钮、保存失败提示、空状态、删除恢复 toast、底部导航。
- 交互范围：textarea 可编辑；保存按钮会恢复“已保存”状态；删除按钮触发回收站 toast 动效。原型不写入真实数据。

等待用户确认：批准原型进入 UX 流程/关键交互检查，或提出需要修改的视觉、布局、内容密度、状态反馈和导航意见。

## 视觉设计上下文

### Visual Seed

用户原始输入：“还是做一个个人备忘录，从头开始”。

### 参考图片与解析

- 本次没有用户上传参考图。
- Reference Library 采用：Todoist 快速捕捉、Notion 低噪音文档感、Natural-language capture、Empty-state activation、Low-stimulation visual principles。
- 可借鉴：输入优先、组织后置、低饱和反馈、清楚空状态、保存/删除状态可见。
- 不应复制：第三方品牌、Logo、图标、文案、完整页面布局、DE-002 的既定暖白视觉。

### 已确认配色

- A “墨白速记”。
- 以近白背景、深墨文字、绿色主操作和低饱和标签建立快速捕捉感。
- 主要令牌：背景 `#F7F7F4`，表面 `#FFFFFF`，主文字 `#20211F`，次级文字 `#62665F`，边框 `#E1E3DC`，主操作 `#2D5A3E`。

### 已确认设计禁区

- 已确认 7 条设计禁区，重点防止手帐装饰化、SaaS 看板化、过度营销化和状态反馈过弱。

### 视觉原型摘要

- 原型入口：[../../prototypes/DE-004-personal-memo-from-scratch/index.html](../../prototypes/DE-004-personal-memo-from-scratch/index.html)
- 手机截图：[artifacts/prototype-mobile-390.png](artifacts/prototype-mobile-390.png)
- 原型为静态 HTML/CSS/JS 单文件，移动优先，默认视口 390px。
- 视觉上使用 A “墨白速记”：近白背景、白色表面、深墨文字、绿色主操作、低饱和标签和琥珀警告。
- 首屏以大输入区为主，最近备忘和标签组织后置；不包含营销页、社交暗示、复杂看板或手帐装饰。
- 原型覆盖保存成功、保存失败/未同步、空状态和删除恢复反馈。

### 视觉基线文档

- 已读取现有 [../../VISUAL_DESIGN.md](../../VISUAL_DESIGN.md)，该文件来自 DE-002。
- 本任务从头开始，不默认继承 DE-002 视觉基线；若后续批准新的视觉方向，可再决定是否更新项目级 `VISUAL_DESIGN.md`。

## 已批准决定

- 创建新的 `DE-004`，不继续 DE-002。
- 用户选择视觉方向 1 “快速捕捉型”。
- 用户选择配色 A “墨白速记”。
- 用户回复“继续”，批准 7 条设计禁区并授权进入静态原型。

## 待确认问题

- 用户是否批准第一版 390px 手机静态原型。
- 若批准，下一步进入 UX 流程与关键交互检查；若不批准，先按用户意见修改原型。
- 响应式桌面延展可在手机原型通过后补。

## 工作假设

- 这是一个个人使用的备忘录，不是团队协作工具。
- 快速记录比复杂分类更重要。
- 用户希望看到一个和 DE-002 不同的新起点。

## 产物与链接

- Reference Selection: [REFERENCE_SELECTION.md](REFERENCE_SELECTION.md)
- 相关旧状态：`../DE-002-personal-memo/STATE.md`
- 状态索引：[../../WORK_ITEMS.md](../../WORK_ITEMS.md)

## 验证证据

- 已完成状态解析：`CREATE DE-004`。
- 已完成 Reference Library 初筛，并写入 `REFERENCE_SELECTION.md`。
- 静态检查确认原型文件存在：`docs/design/prototypes/DE-004-personal-memo-from-scratch/index.html`。
- `git diff --check` 通过，未发现补丁空白问题。
- `rg` 检查未发现冲突标记或未完成标记。
- 使用本地服务 `http://127.0.0.1:4174/` 和 in-app Browser 检查 390x844 视口：文档宽高 390x844，横向溢出为 0，底部导航位于视口底部，内容区内部可滚动，按钮尺寸不小于 30px。
- 使用 in-app Browser 检查 1280x720 桌面框架：无横向溢出，手机原型框居中显示，未发现右侧越界元素。
- 手机截图已保存到 `docs/design/work-items/DE-004-personal-memo-from-scratch/artifacts/prototype-mobile-390.png`。

## 下一步行动

等待用户在 `prototype-approval` Gate 回复。用户可以批准原型，也可以要求修改配色、密度、文案、状态反馈、底部导航或原型覆盖的状态。

## 关键状态变更摘要

- 2026-06-30T23:52:33+08:00：Steward 返回 `CREATE`，创建 DE-004。
- 2026-06-30T23:52:33+08:00：完成 Surface Resolution、Reference Selection，并进入 `visual-direction-approval` 等待用户选择方向。
- 2026-06-30T23:57:14+08:00：用户选择方向 1 “快速捕捉型”，进入 `palette-selection` 等待用户确认配色。
- 2026-06-30T23:59:58+08:00：用户选择配色 A “墨白速记”，进入 `visual-guardrails` 等待用户确认设计禁区。
- 2026-07-01T00:11:33+08:00：用户回复“继续”，批准设计禁区并进入静态原型。
- 2026-07-01T00:17:02+08:00：创建 DE-004 静态原型和手机截图，完成浏览器检查，进入 `prototype-approval` 等待用户确认。
