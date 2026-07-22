# 校验与评测协议

## 1. 强制一致性校验

任何修改核心 source of truth 的运行都必须追加 `consistency_validation`。校验不是可选建议，而是写入后的完成条件。

## 2. 一致性校验范围

至少检查：

1. Canonical Work Item 文件是否齐全且位于固定位置；
2. `STATE.md` 是否严格使用冻结 Core 字段，Adapter 是否发明替代字段；
3. 业务字典 Markdown / YAML 是否结构完整且一致；
4. `schema-view.json` 是否符合唯一结构和五项边界；
5. `BUSINESS_MODEL_INDEX.yml` 是否登记现有对象、关系、动作、状态、规则、权限和下游视图；
6. 对象、领域、分类、属性 ID 是否可解析；
7. 关系端点是否存在；
8. 动作是否有 stable ID、actor、target、preconditions、effects；
9. 状态转换是否引用现有 action / state；
10. 一个生命周期是否只属于一个对象；
11. 规则和权限是否绑定现有 ID；
12. 是否误用数据字段；
13. 上下文相关值是否错误放入单一对象固有属性；
14. 对象身份是否使用斜杠或合并命名掩盖歧义；
15. 下游视图是否过期或越权；
16. `BUSINESS_MODEL_OVERVIEW.md` 是否最新、完整、可让用户独立理解和决策。

## 3. 校验结果

- `passed`：无 error；
- `issues_found`：存在 error 或需显式披露的 warning；
- error 阻止 Work Item 被描述为完成；
- warning 必须压缩进总览的风险部分。

## 4. 人工评测格式

所有评测文件使用 Given / When / Then。

## 5. 回归要求

v0.2.3 必须保留 v0.2、v0.2.1 和 v0.2.2 的全部评测，并新增用户总览、文件协议、Schema 归一化、决策包、引用完整性、生命周期边界、上下文属性和用户交付体验评测。
