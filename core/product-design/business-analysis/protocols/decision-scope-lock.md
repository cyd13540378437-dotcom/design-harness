# Decision Scope Lock / 决策范围锁定 v0.1.4

## 1. 目的

防止一个已确认的商业选择无限下沉为实验设计、数据设计、产品设计或技术执行。

每个 Case 必须记录：

```yaml
decision_scope_id: ""
decision_scope_type: ""
decision_scope_statement: ""
decision_scope_status: provisional | locked | reopened
explicit_non_scope: []
```

## 2. 抽象层级

示例：

```text
商业决策层：选择冷启动验证路径。
路线说明层：解释 M0 / M1 / M2 分别降低什么不确定性。
实验设计层：具体表格、字段、策略数量、权重和跑表步骤。
执行层：生成样例、写脚本、运行模拟。
```

前两层可以属于当前 Case；后两层不属于。

## 3. 范围变化

用户请求进入更低层时：

```text
不修改当前 scope；
标记 boundary_status=out_of_scope_candidate；
只说明该请求与当前决定的关系；
不自动创建新 Case 或触发其他模块。
```

用户提出新的独立商业选择时，才标记 `new_decision_candidate`。
