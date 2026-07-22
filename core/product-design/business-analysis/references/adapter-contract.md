# Runtime Adapter Contract v0.1.2

Runtime Adapter 只负责：

- 发现并调用 `product-business-analysis`；
- 把运行时上下文映射到 Core 输入；
- 读取 Core 协议和项目 BA 资产；
- 在回复前执行 Follow-up Turn Continuity；
- 以运行时允许的方式写入 BA 项目资产；
- 确保用户可见与项目人读输出具有完整中文版本。

Adapter 不得：

- 改变 16 字段 Decision Case；
- 改变路由枚举、状态或 Assurance 结果；
- 跳过 Decision Anchor 恢复；
- 让模型卡各自直接向用户输出最终结论；
- 引入其他能力依赖；
- 自动创建跨模块任务；
- 把运行时对话当作 Decision Case source of truth；
- 只生成英文的人读输出。
