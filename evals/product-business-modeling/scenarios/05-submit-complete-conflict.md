# 横向“提交 / 完成”冲突

Given: 产品表达把“提交”写成“完成”。

When: 业务模型中提交与完成是两个不同状态转换。

Then: 创建 `cross_cluster_conflict` Trigger，生成影响分析或一致性报告，不得静默改写任一 confirmed 语义。
