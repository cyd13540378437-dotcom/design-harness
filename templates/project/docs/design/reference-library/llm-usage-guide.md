# LLM Usage Guide for Product Visual Reference Library

## 目标

让 Agent 用资料库做专业判断，而不是让用户负责说出“某产品的某设计优势”。

## 标准流程

### 1. Surface Resolution

在检索资料库之前先明确本次设计对象：

```yaml
surface_target:
  primary: web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface
  secondary: []
  explicitly_out_of_scope: []
  evidence: []
  open_questions: []
```

如果终端已经能从用户请求或项目技术栈判断，直接记录假设并继续；只有终端不明确且会显著影响参考选择时，才向用户确认。

### 2. Reference Query

基于任务生成检索条件：

```yaml
reference_query:
  surface: []
  page_type: []
  task_type: []
  user_maturity: new-user | mixed | expert
  content_density: low | medium | high
  interaction_complexity: low | medium | high
  risk_level: low | medium | high
```

### 3. Filter Order

按以下顺序过滤：

1. 同终端；
2. 同页面类型；
3. 同任务类型；
4. 相近内容密度和交互复杂度；
5. 相近用户成熟度；
6. 相邻行业；
7. 视觉标签。

### 4. Reference Selection

将本次任务实际采用和排除的参考写入：

```text
docs/design/work-items/<STATE_ID>-<slug>/REFERENCE_SELECTION.md
```

不要写入 `reference-library/`。

### 5. Present Direction to User

给用户看的方向必须是业务语义，而不是产品名堆叠。

错误：

```text
你要 Linear 的密度，Notion 的低噪音，还是 Airbnb 的卡片？
```

正确：

```text
我判断这是 Web 端工作台任务。建议优先做“效率工作台”方向：信息密度较高，突出下一步行动和状态扫描。代价是首次视觉会比营销型首页更紧凑。我会用 Web SaaS 工作台和专业工具参考来支撑这个方向。
```

### 6. Cross-surface Borrowing

跨终端参考只能用于抽象模式，不得直接落地为布局、导航、手势和视觉比例。

### 7. STATE.md Summary

`STATE.md` 只记录：

- 终端目标；
- Reference Selection 链接；
- 采用的设计原则摘要；
- 用户批准的方向；
- 关键不采用项。
