# 项目解析不得自动 confirmed

Given: 项目代码中存在 `Approval` 表。

When: 项目解析器提取 Approval 对象。

Then: 只能写为 candidate / provisional，并生成证据链；不得自动 confirmed 为核心对象。
