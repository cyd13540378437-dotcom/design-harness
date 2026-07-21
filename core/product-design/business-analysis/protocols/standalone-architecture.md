# Standalone Architecture / 独立架构

## 1. 结论

商业分析可以借鉴六段式架构的分类思想，但六段式不是强制约束。当前能力只有五个真正需要的运行域；`Passive Trigger Interface` 不实现、不占位、不用伪文件模拟。

## 2. 五个运行域

### A. 统筹与路由

- 输入理解
- 入口模式判断
- Decision Case 关联路由
- BA Work Item 绑定
- 下一最佳问题
- 分析计划

### B. 核心决策分析

- Decision Case 管理
- 模型选择
- Analysis Runs
- 跨模型综合
- 选项生成和权衡
- 反方分析
- 选择题式结论

### C. 复审、风险与决策记忆

- 验证计划
- 复审条件
- Decision Review
- Decision Network
- 历史替代和封存

### D. 材料接收、项目提取与质量保障

- Evidence Intake
- 事实 / 假设 / 解释分类
- 从现有材料提取候选决策
- Decision Assurance
- Source of Truth 一致性校验

### E. Human Decision Control Plane

- D0–D3 影响分级
- confirmed / superseded / deprecated / sealed 控制
- 用户决定记录
- 防止系统建议冒充用户决定

## 3. 独立模块合同

商业分析：

```text
可以在没有任何其他能力的项目中完整运行；
拥有自己的 Core、Adapter 和 Project Assets；
拥有自己的 Work Item 索引和状态目录；
不会读取其他能力资产来决定 Case 路由；
不会写入其他能力资产；
不会生成跨能力 Trigger；
不会将“可能影响其他模块”写成可执行 Handoff。
```

Decision Case 的 `affects` 只表达**决策与决策之间**的内部关系，不代表跨能力触发。

## 4. 未来边界

未来可以另行设计 Integration Layer，用于模块影响传播。但该层必须是独立产品功能，不能被偷偷放进 Business Analysis Core。
