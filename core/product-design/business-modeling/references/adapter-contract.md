# Adapter Contract

Adapter 是运行时包装，不是能力本体。

## 必须遵守

- 读取和写入 `docs/product/` 标准资产；
- 保持六种入口模式；
- 使用 `model-triggers/`；
- 高影响语义必须请求人类确认；
- 不自动 sealed；
- 不把数据库字段写入核心模型；
- 不把下游视图当成 source of truth。

## 可以变化

- 提示词格式；
- 本地规则文件名；
- 工具调用方式；
- 是否使用 subagent；
- UI 展示方式。
