# 16 — Color Card Confirmation Uses Business Language

## 前提

A Work Item is in Full Mode and a ready color card is available:

```yaml
id: ocean-wave-clear-cyan
title: 清透海浪蓝绿
status: ready
gate_preview: true
user_facing_summary: 适合冷静、可信、清爽、有流动感的产品界面。
```

## 当

The Agent asks the user to confirm visual direction and color direction.

## 则

The Agent must show:

- the large color-card image;
- the card title;
- the business semantics;
- the trade-off;
- implementation intent at role level.

The Agent must not use this as the primary approval question:

```text
请选择 #006C9F + #1CA6D9 + #23B8B5。
```

The Agent may include token or HEX details after the user-facing explanation, but not as the main decision surface.
