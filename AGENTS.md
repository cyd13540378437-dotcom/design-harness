# Codex Design Harness 仓库规则

本仓库定义 v0.1.0-alpha 的 Design Engineering Harness。后续修改必须保持 PRD、Skill、Steward Agent、模板、示例、评测和 README 彼此一致。

## 范围

- v0.1 保持手动、文档型交付。
- 不添加安装器、Codex Plugin 包、Marketplace 元数据、Hook、CLI、`statectl`、云服务或外部运行时依赖。
- 不虚构 Codex 不支持的配置字段。
- 第三方 UI 或浏览器 Skill 只能作为可选增强被提及。

## 核心概念

- Thread 是临时 Codex 对话，不是 Work Item。
- Work Item 是持久任务身份。
- 每个独立 Work Item 最多只有一个权威 `STATE.md`。
- `WORK_ITEMS.md` 只是索引；若与 `STATE.md` 冲突，以 `STATE.md` 为准。
- `completed + sealed` 状态只读，不得恢复，也不得用于新的实现修改。

## 必须保持的枚举

状态解析决定只能是：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

`status` 只能是：

```text
active / paused / completed / cancelled
```

`phase` 只能是：

```text
intake / discovery / visual-direction / prototype / ux-flow / implementation / qa / completion-review / complete
```

`gate` 只能是：

```text
none / work-item-binding / visual-direction-approval / prototype-approval / interaction-decision / completion-approval
```

## 跨文件检查

修改下列文件之一时，完成前必须检查对应文件是否仍一致：

- [docs/PRD.md](docs/PRD.md)
- [skills/design-engineering/SKILL.md](skills/design-engineering/SKILL.md)
- [agents/design-state-steward.toml](agents/design-state-steward.toml)
- [skills/design-engineering/assets/STATE.template.md](skills/design-engineering/assets/STATE.template.md)
- [skills/design-engineering/assets/WORK_ITEMS.template.md](skills/design-engineering/assets/WORK_ITEMS.template.md)
- [examples/idea-storm-lab/docs/design/WORK_ITEMS.md](examples/idea-storm-lab/docs/design/WORK_ITEMS.md)
- [evals/scenarios](evals/scenarios/)

示例必须继续使用 idea-storm-lab 的三个请求：

1. 检查项目上下文
2. 优化前端样式
3. 统一内容模块问题长度换行

