# Product Business Analysis Rules v0.1.2

本项目使用独立的 `product-business-analysis` 能力。

## 模块自有根目录

```text
docs/product/business-analysis/
```

所有商业分析长期资产和 Work Items 都必须保留在该根目录下。

## 硬规则

- 完整保存用户第一次输入原文。
- 输入理解先于路由和具体方案推荐。
- 已有 BA Work Item 时，每轮先恢复 `STATE.md`、Primary Case、最新 Assurance、Decision Notes 和最近结论。
- 维护 Decision Anchor，不允许多轮对话退化成普通建议。
- 用户提出的模拟器、企业版、免费版等解法只是候选方案，必须先比较替代路径。
- Decision Case 的唯一权威文件位于 `decision-cases/`。
- Work Item 只链接 Case，不复制 Case。
- 所有过程文件进入 `work-items/BA-xxx/artifacts/`；不得创建 `intake/`。
- Model Cards 必须执行七类 usage prompts，并记录 Decision Delta。
- 各模型不能自行向用户输出最终结论；只能由统一综合器生成一次结论。
- 反方分析和 Decision Assurance 默认执行。
- 最终结论必须绑定 Case、Work Item、Assurance、结论状态和用户决定状态。
- 所有用户可见和项目级人读输出必须提供完整简体中文内容。
- 明确 D2 / D3 人类决定；`acknowledged` 不等于 `confirmed`。
- 不读取、修改、触发或创建兄弟能力资产。
- 不为本模块创建共享 `docs/product/work-items/`、`model-triggers/` 或 Downstream Views。
