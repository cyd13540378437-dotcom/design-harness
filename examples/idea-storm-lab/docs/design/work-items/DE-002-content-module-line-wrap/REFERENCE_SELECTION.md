# Reference Selection

## Work Item

- State ID: DE-002
- Title: 统一内容模块问题长度换行
- STATE.md: [STATE.md](STATE.md)

## Surface Target

- Primary surface: responsive-web
- Secondary surfaces: []
- Explicitly out of scope: native mobile app redesign; full dashboard redesign
- Evidence: The task concerns the existing idea-storm-lab web interface, desktop list/detail layout, and 390px mobile responsive width.
- Open questions: None.

## Task Diagnosis

This is a lightweight responsive-web refinement inside the sealed DE-001 visual baseline. The goal is to keep long question text readable without breaking card layout, list scanning, focus states, or mobile single-column flow.

## Reference Query

```yaml
surface: [responsive-web, web-app]
page_type: [content-list, detail-panel, card-grid]
task_type: [text-wrapping, readability, layout-stability]
user_maturity: mixed
content_density: medium
interaction_complexity: low
risk_level: medium
```

## Selected References

| Reference | Surface | Why relevant | Use | Do not use |
|---|---|---|---|---|
| Existing `VISUAL_DESIGN.md` | responsive-web | DE-002 must preserve the sealed DE-001 visual baseline. | Keep warm creator workspace palette, content-first hierarchy, and moderate card density. | Do not reopen DE-001 or change the visual baseline. |
| Editorial content system principles | responsive-web | Long text needs readable line length, predictable wrapping, and calm hierarchy. | Apply clear line-height, max-width, and multi-line scan rules. | Do not turn list cards into article layouts or add editorial decoration. |
| Dense productivity workspace principles | web-app | Lists must remain scannable when item text varies in length. | Keep row height changes controlled and preserve focus/hover stability. | Do not import table density, sidebars, or compact enterprise chrome. |

## Rejected References

| Reference | Reason |
|---|---|
| Native mobile bottom-sheet patterns | The task targets responsive web, not native mobile navigation or gestures. |
| Marketing hero/content-card discovery patterns | The issue is layout stability for existing modules, not discovery or brand storytelling. |

## Design Principles for This Work Item

1. Preserve the DE-001 visual baseline and do not rewrite sealed history.
2. Favor readable wrapping and stable card geometry over decorative variation.
3. Treat mobile width as responsive web behavior, not native mobile app layout.

## User-facing Direction Summary

Recommended direction: keep the existing creator-workspace style and make long questions behave predictably across desktop and mobile. The trade-off is that very long questions may occupy up to three lines in lists, while full reading remains available in detail areas.

## STATE.md Summary

- Surface target: responsive-web.
- Reference Selection: [REFERENCE_SELECTION.md](REFERENCE_SELECTION.md).
- Approved / pending direction: lightweight layout-stability refinement inside the DE-001 visual baseline.
- Important exclusions: no native mobile redesign, no visual baseline change, no update to sealed DE-001.

## Copyright Boundary

Only internal design principles and abstract patterns are used. No third-party brand assets, icons, illustrations, proprietary copy, screenshots, or complete page layouts are copied.
