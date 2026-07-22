# 输出合同完整

## Given / 已知

一次 `standard` 或 `deep` 商业分析完成。

## When / 当

系统按当前分析深度和用户请求落盘。

## Then / 则

- Work Item 根目录只保存状态、消费、输出、决定、中文摘要和过程包；
- 所有过程文件位于 `artifacts/`；
- 用户请求阶段性或最终结论时，生成中文 `DECISION_SUMMARY.md`；
- `DECISION_SUMMARY.md` 绑定 Primary Case、Work Item、Assurance、证据边界和用户决定状态；
- 不得为了模板完整无条件创建全部文件；
- 不得创建第二个平行结论文件。
