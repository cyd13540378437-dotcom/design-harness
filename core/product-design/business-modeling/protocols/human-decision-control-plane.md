# Human Decision Control Plane 协议

## 1. 职责

识别哪些业务模型判断不能由 AI 自动确认，并要求在写入或覆盖 confirmed source of truth 前获得明确人类决定。

## 2. 影响等级

```text
D0 = 机械同步，可自动执行
D1 = 可逆局部语义，可自动 provisional
D2 = 核心产品语义，确认或覆盖 confirmed 前必须由人决定
D3 = 治理与终态，必须明确人类决定
```

## 3. 必须阻断的情况

- 对象身份存在互斥判断；
- 关系影响权限、流程或数据库；
- 动作改变核心流程；
- 状态流转有多个合理方案；
- 规则涉及责任、权限、审计或合规；
- 上游变化导致模型重构；
- provisional 已被下游依赖；
- 升级为 confirmed；
- 关闭、封存、废弃或覆盖重要资产。

## 4. 决策压缩要求

在询问用户前，Agent 必须先完成决策压缩：

```text
当前理解
→ 为什么重要
→ 2–3 个可行方案
→ 各自优点与代价
→ Agent 推荐
→ 用户可直接回复的选项
```

仅列出“问题清单”不合格。

## 5. 决策 ID 与记录

- 所有 D2 / D3 决策使用稳定 `BMD-xxx` ID；
- 禁止用 `HD-xxx`、无 ID 标题或运行时私有 ID 作为业务模型决策主键；
- 完整记录写入 `DECISION_NOTES.md`；
- 足以让用户做决定的压缩版本必须同步编译进 `BUSINESS_MODEL_OVERVIEW.md`。

## 6. 等待状态

进入等待用户阶段时：

```yaml
phase: awaiting_decision
awaiting_human: true
```

用户回复后，先更新 `DECISION_NOTES.md` 和 `STATE.md`，再继续模型写入。

## 7. 用户可见体验

用户通常只需阅读 `docs/product/BUSINESS_MODEL_OVERVIEW.md`。总览必须包含所有当前待确认判断的可决策信息；`DECISION_NOTES.md` 继续保留完整审计用途。
