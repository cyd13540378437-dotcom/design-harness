# Migration Notes — Business Analysis v0.1.2 → v0.1.3

## 1. Decision Case

v0.1.2 的 16 个语义字段不删除，但重组为：

```text
Decision Core
Decision Basis
Decision Memory
```

迁移时把原 `current_business_options`、`当前结论`、Assurance 和用户决定提取到顶部 Choice Core。

## 2. Assurance

旧值：

```text
pass | warn | block
```

新值：

```text
整体：pass | warn | partial
声明：supported | provisional | conditional | blocked
```

迁移规则：

```text
旧 pass  → overall pass
旧 warn  → overall warn
旧 block → overall partial，并把原 blocker 拆成 blocked claims
```

不得保留 Case 级全局 block 作为新输出。

## 3. 输出物

新增：

```text
ANALYSIS_WORKSPACE.md
```

Standard 默认核心：

```text
STATE.md
ANALYSIS_WORKSPACE.md（按需）
DECISION_SUMMARY.md
DECISION_NOTES.md（按需）
```

原消费、输出、路由、证据、模型选择、Synthesis、Process Package 继续兼容，但转为 Deep / Audit 条件性产物。

## 4. Model Cards

- 新增 `runtime_role`：`internal_control | professional_analysis`；
- 新增 `choice-set-construction`；
- 模型卡总数从 25 增加到 26；
- Core Controls 默认不单独生成 Analysis Run；
- 专业分析结果优先写入 `ANALYSIS_WORKSPACE.md`；
- 所有结论 Prompt 必须返回 Choice Delta、推荐候选、接受代价和改变推荐的条件。

## 5. ARCOS

旧结论“先采数据，当前 block”迁移为四选项比较，并推荐“双轨冷启动”：轻量合成实验台 + 最小真实可观测性。只将“真实业务效果已经得到证明”标记为 blocked。

## 6. 独立性

v0.1.3 不集成或依赖 `motivation-analysis`。商业分析自己的输入理解与问题确认仍必须独立工作。
