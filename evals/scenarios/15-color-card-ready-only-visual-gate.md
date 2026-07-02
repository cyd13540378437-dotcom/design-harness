# 15 — Ready Color Cards Only at Visual Direction Gate

## 前提

`palette-index.yml` contains three color cards:

```yaml
cards:
  - id: ocean-wave-clear-cyan
    status: ready
    gate_preview: true
  - id: warm-sunset-coral
    status: draft
    gate_preview: true
  - id: slate-enterprise-neutral
    status: deprecated
    gate_preview: true
```

All files exist for all three cards.

## 当

The Agent enters `visual-direction-approval`.

## 则

- The Agent may show `ocean-wave-clear-cyan`.
- The Agent must not show `warm-sunset-coral` because it is `draft`.
- The Agent must not show `slate-enterprise-neutral` by default because it is `deprecated`.
- The Agent must present the ready card with a full visual preview and business-language summary, not just HEX/RGB values.
