# Color Cards

这是为后续“色卡图片 + 配色解释”预留的资料区。

当前先创建结构，不预填具体色卡。后续新聊天可以直接往这里追加图片和解释，不需要重新讨论目录设计。

## 推荐结构

```text
color-cards/
├── README.md
├── palette-index.md
├── color-card.schema.yml
├── images/
│   └── .gitkeep
├── palettes/
│   └── .gitkeep
└── annotations/
    └── .gitkeep
```

## 使用方式

1. 把色卡图片放入 `images/`。
2. 每张色卡创建一份 `palettes/<palette-id>.md`。
3. 如果需要对图片局部做说明，把详细解释放入 `annotations/`。
4. 在 `palette-index.md` 中维护索引。

## 命名建议

```text
images/CLR-001-warm-neutral-workspace.png
palettes/CLR-001-warm-neutral-workspace.md
annotations/CLR-001-warm-neutral-workspace.annotation.md
```

## 解释重点

每张色卡至少说明：

- 主色、辅助色、背景色、文字色、边框色；
- 情绪关键词；
- 适合的产品类型和终端；
- 不适合的场景；
- 可转化成哪些 design tokens；
- 无障碍和对比度风险。
