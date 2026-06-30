# Reference Library Consumption

## Core Rule

References are evidence for the agent, not vocabulary the user is expected to know.

中文表达：参考资源用于帮助 Agent 形成专业建议，不要求用户理解或命名具体产品的设计优势。

## Required Flow

1. Determine whether the current request is a stateful UI/UX Work Item.
2. Resolve or create the Work Item through `design_state_steward`.
3. Before visual direction, perform Surface Resolution.
4. If `docs/design/reference-library/` exists, query it by surface, page type, task type, content density and interaction complexity.
5. Save the task-level selection in `docs/design/work-items/<id>-<slug>/REFERENCE_SELECTION.md`.
6. Present 2–3 directions in product language, not as product-name choices.
7. Ask user to approve the direction only after explaining trade-offs and recommendation.
8. During prototype and implementation, follow approved design principles, not third-party screenshots directly.
9. During QA, verify against target surfaces and the approved Reference Selection.
10. Ask `design_state_steward` to record only the summary and link in `STATE.md`.

## Surface Resolution

Do this before searching references.

```yaml
primary_surface: web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface
secondary_surfaces: []
explicitly_out_of_scope: []
evidence: []
open_questions: []
```

If the target surface is unclear and materially affects reference selection or implementation, ask the user. Otherwise make a justified assumption and record it.

## User-facing Direction Wording

Bad:

```text
你要 Linear 的密度、Notion 的低噪音，还是 Airbnb 的卡片？
```

Good:

```text
我判断这是 Web 端工作台任务。建议采用“效率工作台”方向：首屏突出任务状态、下一步行动和最近对象。它会比营销型首页更紧凑，但更适合高频使用。我会用 Web SaaS 工作台和专业工具参考来支撑这个方向。
```
