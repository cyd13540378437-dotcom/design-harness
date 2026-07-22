# 架构决策：商业分析采用 Choice-first Decision Support

- 版本：v0.1.3
- 状态：Accepted
- 日期：2026-07-22

## 背景

v0.1.2 已经建立多轮状态续接、商业问题连续性和中央综合，但 ARCOS 真实试用中，当用户无法提供排班结构和策略规则时，系统把 Case 改成全局 `block`，最终只建议先做数据采集。

这在证据纪律上谨慎，却没有完成商业分析的第一性责任：形成真实选择、说明后果并给出当前推荐。

## 决策

商业分析采用 Choice-first 架构：

```text
问题确认
→ provisional Choice Set
→ 当前 Recommendation
→ 证据与模型更新 Choice Delta
→ Claim-level Assurance
→ Decision Closure
→ 用户接受 / 拒绝 / 修改 / 暂缓
```

## 关键结果

1. Choice Core 位于 Decision Case 顶部。
2. 阶段性结论承担 Recommendation Obligation。
3. Assurance 从 Case 级 `pass / warn / block` 改为：
   - 整体 `pass / warn / partial`
   - 声明级 `supported / provisional / conditional / blocked`
4. `blocked` 不再阻止系统给出推荐。
5. 缺少输入时执行 No Dead-End Rule。
6. 用户拒绝或修改推荐是有效 Choice Delta。
7. Standard 输出收敛为 Case、State、Workspace、Summary 与 Notes；完整审计仅 Deep。

## 不做

- 不引入 `motivation-analysis` 依赖；
- 不实现跨模块 Trigger；
- 不让 Business Analysis 读写 Business Modeling；
- 不把推荐当成人类决定。
