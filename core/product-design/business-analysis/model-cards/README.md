# Analysis Model Card Registry

模型卡是长期可复用的专业分析知识对象。每张 ready 卡必须通过：

```text
适配条件
最低输入
Decision Relevance
七类 usage prompts
Decision Delta
误用保护
中文输出合同
```

## 运行边界

模型卡不得独立向用户输出最终结论。所有模型结果进入 Analysis Workspace，最后由中央决策综合器统一生成中文 `DECISION_SUMMARY.md`。
