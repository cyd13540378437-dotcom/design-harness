# 校验与评测协议

## 1. 一致性校验范围

- 业务字典与 schema-view 是否一致；
- 对象画像是否覆盖核心对象；
- 关系是否引用存在对象；
- 动作是否具备 actor / target / effects；
- 状态转换是否有触发动作；
- 规则是否绑定对象、动作或状态；
- 是否误用数据字段；
- 下游视图是否过期或越权。

## 2. 人工评测格式

所有评测文件使用 Given / When / Then。

## 3. 最小评测集

v0.2 评测集包含 14 个场景，详见 `evals/product-business-modeling/scenarios/`。
