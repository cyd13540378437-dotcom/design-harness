# 人类决策控制层（Human Decision Control Plane）v0.1.2

## 1. 影响等级

```text
D0 机械同步，不改变业务含义
D1 可逆、局部、低代价判断
D2 核心业务选择，影响客户、收入、成本、流程或责任
D3 战略、重大财务、合规、不可逆或高代价选择
```

## 2. AI 权限

AI 可以：

```text
生成 draft / provisional 分析
比较选项
提出推荐
记录 acknowledged
设计验证和复审条件
```

AI 不可以：

```text
把系统推荐写成用户决定
把 acknowledged 写成 confirmed
自动确认 D2 / D3
自动 supersede / deprecate / seal 高影响决定
```

## 3. 用户决定状态

```text
not_requested  尚未请求决定
pending        正等待用户选择
acknowledged   用户表示理解，但未明确选择
confirmed      用户明确选择并接受关键代价
rejected       用户拒绝推荐或选项
revised        用户修改了原选择
```

## 4. Human Decision Request

必须用中文说明：

```text
当前商业问题
为什么需要用户决定
真实业务选项
每项价值、代价和风险
系统推荐
证据边界
需要用户确认的具体选择
```

## 5. 写入位置

D2 / D3 confirmed、rejected、revised 进入 `DECISION_NOTES.md`，并更新 Decision Case、STATE 和必要的 Review 条件。
