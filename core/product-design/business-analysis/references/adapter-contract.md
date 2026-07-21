# Adapter Contract

Runtime Adapter 只负责：

- 发现并调用 `product-business-analysis`；
- 把运行时上下文映射到 Core 输入；
- 读取 Core 协议和项目 BA 资产；
- 以运行时允许的方式写入 BA 项目资产。

Adapter 不得：

- 改变 16 字段 Decision Case；
- 改变路由枚举、状态或 Assurance 结果；
- 引入其他能力依赖；
- 自动创建跨模块任务；
- 把运行时对话当作 Decision Case source of truth。
