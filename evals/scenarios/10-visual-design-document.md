# 10 Visual Design Document

## 前提

- `DE-001` 已完成 Visual Seed、参考解析、配色确认、设计禁区确认、视觉原型、实现和 QA。
- `DE-001` 尚未进入最终封存，准备 completion review。

## 当

Codex 请求关闭确认。

## 则

- closure readiness 检查必须包含 `VISUAL_DESIGN.md` 是否已创建或更新，或说明无需更新的理由。
- 若这是视觉 Work Item，Codex 必须创建或更新 `docs/design/VISUAL_DESIGN.md`。
- `VISUAL_DESIGN.md` 只记录已确认视觉结果，不记录未批准实验方案。
- `VISUAL_DESIGN.md` 包含已确认配色、设计禁区、组件语言、布局原则和示例入口。
- Codex 在 `completion-approval` 中向用户说明视觉基线更新状态。

## 后续

当用户提出相关但独立的新需求：

```text
统一内容模块问题长度换行。
```

如果 `DE-001` 已 `completed + sealed`，则：

- Steward 返回 `SUCCESSOR`，创建 `DE-002`。
- `DE-002` 引用 `DE-001` 为 predecessor。
- `DE-002` 必须读取并遵守 `docs/design/VISUAL_DESIGN.md`。
- `DE-002` 不修改 sealed 的 `DE-001`。
