# Decision Case Contract v0.1.2

Decision Case 是一个业务选择的长期权威容器，不是聊天记录，也不是一次 Work Item 的复制品。

## 1. 顶部 Decision Anchor

每个 Case 顶部维护：

```text
原始商业问题
已确认商业问题
决策人
受影响参与者
期望业务结果
当前业务选项
关键未知
证据边界
Assurance 状态
用户决定状态
```

## 2. 固定 16 个字段

```text
0. 原始输入
1. 当前问题
2. 为什么现在需要处理
3. 决策范围
4. 关键线索
5. 已知事实
6. 重要假设
7. 相关证据
8. 专业分析工作区
9. 可选方案
10. 主要权衡
11. 反方观点 / 不做会怎样
12. 当前结论
13. 验证方式
14. 复审条件
15. 关联决策
```

字段固定，填充深度动态。

## 3. 原始输入

第一次输入必须 verbatim 保存。系统理解后的“当前问题”不得替代原文。

## 4. 专业分析工作区

每个 Analysis Run 必须包含 Decision Delta。模型名称不能替代分析内容。

## 5. 当前结论

必须区分：

```text
系统推荐
结论状态
Assurance
用户决定
用户决定状态
证据边界
```

## 6. 历史保护

confirmed 或 sealed 内容不能静默改写。新证据通过 Review、needs_review、superseded 或新 Work Item 表达。
