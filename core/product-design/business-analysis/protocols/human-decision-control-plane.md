# 人类决策控制层（Human Decision Control Plane）v0.1.4

## 1. 影响等级

```text
D0 机械同步
D1 可逆、局部、低代价判断
D2 影响客户、收入、成本、流程或责任的核心选择
D3 战略、重大财务、合规、不可逆或高代价选择
```

## 2. AI 权限

AI 可以形成 Choice Set、提出 provisional / conditional 推荐、记录 acknowledged，并设计验证与复审条件。

AI 不可以把推荐写成用户决定，把泛化知悉写成 confirmed，自动确认 D2 / D3，或在决定确认后继续代替用户设计和执行方案。

## 3. 决定信号

```text
“好的 / 知道了” → acknowledged
“就按 B” → confirmed
“其他的都没问题，只想问清 X” → confirmed + clarification
“我不接受，因为……” → rejected 或 revised
“先不做” → deferred（语义明确时）
```

## 4. 确认后的动作

D2 / D3 的 confirmed、rejected、revised、deferred 进入 `DECISION_NOTES.md`。confirmed 必须关闭 Choice Loop；后续普通澄清不得重新打开。
