# Trigger 去重

Given: 已存在 `MT-001`，dedupe_key 为 `pricing-model-seat-change`。

When: 另一下游模块提出同样缺口。

Then: 不创建重复 Trigger；应关联到 `MT-001` 或同一 BM Work Item。
