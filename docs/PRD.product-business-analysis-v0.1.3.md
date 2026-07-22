# DesignHarnessAgent — Product Business Analysis Core PRD

- 版本：v0.1.3-alpha
- 状态：Codex 可执行规范
- Capability ID：`product-business-analysis`
- 产品名称：商业分析能力集群
- 架构：Agent-neutral standalone Core
- 本次主题：Choice-first Decision Support

## 1. 产品定义

商业分析的第一性工作不是生产报告，也不是启动下游生产线，而是围绕用户业务问题建立和维护可审查、可验证、可复审的 Decision Case，并把它纳入 Decision Network。

它最终帮助用户看清：

```text
当前要选择什么；
现实选项是什么；
每个选项的后果；
系统当前推荐什么；
什么会改变推荐；
用户现在要接受、拒绝、修改还是暂缓。
```

## 2. v0.1.3 修正的问题

ARCOS 回归暴露：

1. v0.1.2 在缺少排班结构和策略规则时，将整个 Case 改为 `block`；
2. Assurance 替代了 Recommendation；
3. 用户只得到“先采数据”，没有现实 Choice Set 和当前方案；
4. 选项出现得太晚，证据与流程成为主角；
5. 用户无法通过吐槽、拒绝或修改建议推动 Case 成长；
6. Standard 分析产生过多过程文件。

## 3. 必须实现的 Choice-first 流程

```text
1. 保留原始输入并确认业务问题
2. 路由 Case 与选择分析深度
3. 建立 provisional Choice Set
4. 给出 provisional / conditional Recommendation
5. 只问会改变 Choice Set 或 Recommendation 的问题
6. 证据与专业模型产生 Choice Delta
7. 执行反方分析
8. 执行 Claim-level Assurance
9. 执行 No Dead-End Rule
10. 中央综合形成 Decision Closure
11. 用户接受 / 拒绝 / 修改 / 暂缓
12. 更新 Case、Notes、Network 与 Review 条件
```

## 4. Choice Core

Decision Case 顶部必须包含：

```text
当前决策问题
Choice Set 及生命周期
当前推荐
推荐状态
接受的代价
证据边界
改变推荐的条件
用户决定状态
Claim-level Assurance 摘要
```

## 5. 选项生命周期

```text
proposed
viable
conditionally_viable
eliminated
selected
rejected
deferred
superseded
```

## 6. Recommendation Obligation

阶段性结论必须给出当前最佳推荐。允许：

```text
provisional
conditional
user_confirmed
```

证据不足只能降低推荐强度，不能免除推荐责任。

## 7. Assurance

整体成熟度：

```text
pass | warn | partial
```

声明状态：

```text
supported | provisional | conditional | blocked
```

Case 级全局 `block` 不再作为新输出。

## 8. No Dead-End Rule

不得只输出：

```text
信息不足
无法判断
请补材料
先采数据再说
```

必须比较可继续路径，并推荐一个：provisional 假设、缩小范围、补关键证据、低成本替代或暂缓。

## 9. Decision Closure

`DECISION_SUMMARY.md` 必须包含：

```text
当前选择
现实选项
当前推荐
收益、代价和风险
为什么不优先其他方案
Claim-level Assurance
证据边界
改变推荐的条件
用户可接受 / 拒绝 / 修改 / 暂缓
下一次决策点
```

## 10. Model Cards

- 26 张 ready 卡：10 Core + 16 Professional；
- 新增 `runtime_role`；
- 新增 `choice-set-construction`；
- 7 个 usage prompts 保持；
- 所有运行要求 Choice Delta；
- Core Controls 默认不单独落 Analysis Run；
- Professional Analysis 写入 `ANALYSIS_WORKSPACE.md`；
- 只有中央综合器向用户收尾。

## 11. Output Contract

### 长期资产

```text
Decision Case
Decision Network
Evidence Ledger
Decision Review
```

### Standard Work Item 核心

```text
STATE.md
ANALYSIS_WORKSPACE.md（按需）
DECISION_SUMMARY.md
DECISION_NOTES.md（按需）
```

### Deep / Audit 按需

```text
ANALYSIS_CONSUMPTION.md
ANALYSIS_OUTPUT.md
DECISION_PROCESS_PACKAGE.md
artifacts/*
```

## 12. 中文输出

所有用户可见和项目人读 Markdown 必须有完整简体中文版本。英文只用于运行时、稳定 ID、文件名、枚举和机器字段。

## 13. 独立性

商业分析必须独立运行；不依赖 `motivation-analysis`；不读写、触发或编译业务模型等兄弟能力；不创建共享 Work Item、Trigger 或 Downstream View。

## 14. ARCOS 必过回归

在没有历史数据、排班结构和策略规则时，系统必须比较至少以下路径：

```text
A 先采真实数据
B 纯合成场景实验台
C 规则测试台
D 双轨冷启动：合成实验台 + 最小真实可观测性
```

当前推荐应是 D（除非新证据改变排序）。

声明级 Assurance 示例：

```text
通用实验台设计 = supported
合成场景相对比较 = provisional
当前策略比较 = conditional
真实业务效果已证明 = blocked
```

不得以全局 block 结尾。

## 15. Definition of Done

- Choice Core 在 Case / STATE / Summary 中一致；
- Choice Set 生命周期完整；
- Recommendation Obligation 生效；
- No Dead-End 生效；
- Claim-level Assurance 生效；
- 用户拒绝 / 修改 / 暂缓可更新 Case；
- Decision Closure 完整；
- 26 张模型卡通过 runtime_role + 7 prompts + Choice Delta 校验；
- Standard 不机械生成完整审计包；
- 所有人读输出有中文；
- ARCOS 回归通过；
- 模块独立；
- 无 CLI、Hook、Plugin、Installer 或外部依赖。
