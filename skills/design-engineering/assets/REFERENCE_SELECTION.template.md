# Reference Selection

## Work Item

- State ID:
- Title:
- STATE.md:

## Surface Target

- Primary surface:
- Secondary surfaces:
- Explicitly out of scope:
- Evidence:
- Open questions:

## Task Diagnosis

简要说明本次任务的产品目标、目标用户、核心页面、使用频率、内容密度和风险等级。

## Reference Query

```yaml
surface: []
page_type: []
task_type: []
user_maturity: mixed
content_density: medium
interaction_complexity: medium
risk_level: medium
```

## Selected References

| Reference | Surface | Why relevant | Use | Do not use |
|---|---|---|---|---|

## Rejected References

| Reference | Reason |
|---|---|

## Color Card Selection

### Registry Source

- Registry source: `project | project-installed-from-skill-bundled | skill-bundled | none`
- Project color card registry: `docs/design/reference-library/assets/color-cards/palette-index.yml`
- Skill-bundled color card registry: `<skill-root>/assets/color-cards/palette-index.yml`
- Integrity check result: `pass | skipped-incomplete | no-ready-cards | no-registry`
- Source note: If using `project-installed-from-skill-bundled`, state that the project had no installed Color Card Registry and the Skill installed the bundled registry into the project before palette selection. If using `skill-bundled`, state why project installation was unsafe or impossible.

### Color Direction Query

- Surface target:
- Desired product emotion:
- Brand constraints:
- Accessibility constraints:
- Existing design token constraints:

### Candidate Color Cards

| ID | Title | Status | Gate Preview | Fit Reason | Trade-off | Image | Annotation |
|---|---|---|---|---|---|---|---|

### Rejected Color Cards

| ID | Title | Reason |
|---|---|---|

### User-Facing Color Direction Summary

```text
Direction name:
Best for:
Trade-off:
Implementation intent:
```

### Approved Color Direction

- Approved by:
- Approved at:
- Selected color-card id:
- Selected color-card title:
- User notes:

### Token Translation Notes

| Token Role | Intended Color Role | Source Color Card Note |
|---|---|---|
| `color.primary` |  |  |
| `color.accent` |  |  |
| `color.background` |  |  |
| `color.surface` |  |  |
| `color.text.primary` |  |  |

### Accessibility Notes

- Contrast risks:
- Text-on-background restrictions:
- CTA / focus / state-color cautions:

## Typography Selection

### Typography Query

- Existing visual baseline:
- Brand font constraints:
- Locale and writing system:
- Surface and density:
- Long-form reading needs:
- Data/code display needs:
- Performance or licensing constraints:

### Candidate Typography Systems

| Candidate | Font family | Fallback stack | Scale character | Fit reason | Trade-off | Sample coverage |
|---|---|---|---|---|---|---|

### Rejected Typography Systems

| Candidate | Reason |
|---|---|

### Approved Typography System

- Approved by:
- Approved at:
- Source: existing-baseline | candidate | modified-candidate | custom
- User notes:
- Font family:
- Fallback stack:
- License / loading notes:
- Type scale:
- Responsive adjustments:
- Readability risks:

### Implementation Boundary

- Do not copy third-party imagery or protected assets.
- Use the color-card image only as internal reference unless license explicitly allows publication.
- Do not treat HEX/RGB values as the user approval language.

## Design Principles for This Work Item

1.
2.
3.

## User-facing Direction Summary

用用户能理解的业务语言描述推荐方向，不要求用户理解具体参考产品的设计优势。

## STATE.md Summary

建议同步写入 `STATE.md` 的摘要：

- Surface target:
- Reference Selection:
- Approved / pending direction:
- Important exclusions:

## Copyright Boundary

仅用于内部设计分析和模式抽象。不得复制第三方品牌资产、图标、插画、文案或完整页面布局。
