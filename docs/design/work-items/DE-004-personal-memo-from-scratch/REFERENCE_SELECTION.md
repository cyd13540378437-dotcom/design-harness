# Reference Selection

## Work Item

- State ID: DE-004
- Title: 个人备忘录从头开始
- STATE.md: [STATE.md](STATE.md)

## Surface Target

- Primary surface: mobile-app
- Secondary surfaces: responsive-web
- Explicitly out of scope: continuing DE-002; backend sync; account system; enterprise dashboard; native desktop app
- Evidence: User asked to design a personal memo from scratch. A personal memo product is most naturally mobile-first for quick capture, with responsive web as a useful secondary surface for later review.
- Open questions: Whether the first prototype should be phone-only or also include desktop responsive behavior.

## Task Diagnosis

The product goal is a personal memo experience for fast capture, calm review, lightweight organization, and safe recovery. The main risk is turning a private memo tool into either a generic productivity dashboard or a too-soft decorative note app. The design should privilege quick input, low cognitive load, readable note history, and trustworthy save/delete feedback.

## Reference Query

```yaml
surface: [mobile-app, responsive-web]
page_type: [quick-add, note-list, note-detail, empty-state, search]
task_type: [personal-capture, lightweight-organization, review, safe-delete]
user_maturity: mixed
content_density: medium
interaction_complexity: medium
risk_level: medium
```

## Selected References

| Reference | Surface | Why relevant | Use | Do not use |
|---|---|---|---|---|
| Todoist / quick-add principles | mobile-app, web-app | Fast capture and lightweight hierarchy are central to a memo tool. | Keep the capture entry always easy to reach; use small status and priority cues. | Do not copy Todoist branding, task semantics, or red visual identity. |
| Notion / low-noise workspace principles | web-app, desktop-app, mobile-app | Personal notes benefit from quiet typography and durable reading surfaces. | Borrow low-noise document feel and composable note structure. | Do not import database complexity or workspace chrome. |
| Natural-language capture | mobile-app, web-app, desktop-app | Memo users often want to write first and organize later. | Let users type naturally, then lightly classify or suggest tags. | Do not auto-structure into irreversible fields. |
| Empty-state activation | web-app, mobile-app, responsive-web | First-run memo products need a clear first action. | Explain the empty state and provide one obvious capture action. | Do not use marketing copy instead of a real action. |
| Low-stimulation visual principles | mobile-app, responsive-web | Personal memo capture often happens when the user is busy, tired, or mid-thought. | Use low-saturation colors, calm spacing, and gentle feedback. | Do not make important warnings too pale or invisible. |

## Rejected References

| Reference | Reason |
|---|---|
| Existing DE-002 warm-white memo baseline | The user explicitly asked to start from scratch; it can be a known predecessor in the repository but should not constrain this design. |
| Web SaaS dashboard patterns | The task is private capture and review, not business monitoring or operations. |
| Gamified path / achievement feedback | Memo capture should not pressure the user or turn private writing into a streak system by default. |
| Content-card discovery | Browsing and discovery are secondary; quick capture and retrieval matter more. |

## Design Principles for This Work Item

1. Capture first: the fastest path is opening the app and writing immediately.
2. Organize later: tags, search, pinning, and suggestions help without forcing upfront structure.
3. Calm trust: save, delete, and recovery states must be visible without creating anxiety.
4. Private by default: the visual language should feel personal, quiet, and local, not social or enterprise.

## User-facing Direction Summary

Approved direction: a mobile-first personal memo app focused on fast capture and calm review. The first screen should make writing feel immediate, with organization available but secondary. Approved palette is A "墨白速记": near-white background, ink text, green primary action, and low-saturation tags. I will avoid carrying over the previous DE-002 warm-white result unless you explicitly choose that family again.

## STATE.md Summary

- Surface target: mobile-app primary, responsive-web secondary.
- Reference Selection: [REFERENCE_SELECTION.md](REFERENCE_SELECTION.md).
- Approved / pending direction: approved direction 1, `快速捕捉型`; approved palette A, `墨白速记`; approved visual guardrails; pending `prototype-approval`.
- Important exclusions: no DE-002 continuation, no enterprise dashboard, no gamified pressure, no copied third-party assets.

## Copyright Boundary

Only internal design analysis and abstract patterns are used. Do not copy third-party brand assets, icons, illustrations, proprietary copy, screenshots, or complete page layouts.
