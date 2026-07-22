# Runtime Adapter Contract v0.1.4

Runtime Adapter 只负责：

- 发现并调用 `product-business-analysis`；
- 把运行时上下文映射到 Core 输入；
- 恢复 BA Work Item 与 Decision Case；
- 维护 Choice Core、Recommendation、Claim-level Assurance 和用户决定状态；
- 按 Core 合同写入 BA 项目资产；
- 确保用户可见与项目人读输出具有完整中文版本。

Adapter 不得：

- 改变 Choice Set 生命周期、推荐义务或 Assurance 语义；
- 用全局 block 替代声明级保障；
- 让模型卡各自直接向用户收尾；
- 机械创建完整审计文件；
- 引入 Motivation Analysis 或其他能力依赖；
- 自动创建跨模块任务；
- 把运行时对话当作 Decision Case source of truth；
- 只生成英文人读输出。

## v0.1.4 Boundary Contract

Adapters must parse mixed turns, close the choice loop after confirmation, preserve decision scope, avoid implementation artifacts and execution offers, and enforce state enums.
