# v0.1 → v0.1.1 差异与增量说明

## 一句话

v0.1 建立了 UI/UX Work Item 的状态化工作流；v0.1.1 在此基础上增加结构化视觉参考库，让 Agent 能基于任务和终端提出更专业的设计方向。

## 最大变化

1. 新增 `docs/design/reference-library/` 作为长期资料层。
2. 新增 `Surface Resolution`，找参考前先明确目标终端。
3. 新增 Work Item 级 `REFERENCE_SELECTION.md`，记录本任务如何消费参考库。
4. 明确禁止 `reference-library/reference-packs/`。
5. 修正用户体验：用户不需要理解具体参考产品的设计优势，只需要确认业务方向和取舍。
6. 预留 `assets/color-cards/`，支持后续色卡图片和解释。

## 文件级增量

| 路径 | 动作 | 目的 |
|---|---|---|
| `templates/project/docs/design/reference-library/` | 新增 | 长期视觉参考资料层 |
| `templates/project/docs/design/reference-library/product-index.md` | 新增 | LLM 与人都可读的产品索引 |
| `templates/project/docs/design/reference-library/product-index.yml` | 新增 | 机器可读产品索引 |
| `templates/project/docs/design/reference-library/products/` | 新增 | 单产品结构化说明 |
| `templates/project/docs/design/reference-library/pattern-index.md` | 新增 | 设计模式总索引 |
| `templates/project/docs/design/reference-library/patterns/` | 新增 | 单模式结构化说明 |
| `templates/project/docs/design/reference-library/assets/color-cards/` | 新增 | 色卡图片和解释预留区 |
| `skills/design-engineering/assets/REFERENCE_SELECTION.template.md` | 新增 | Work Item 级参考选择模板 |
| `skills/design-engineering/assets/STATE.template.md` | 修改 | 增加终端与参考摘要小节 |
| `templates/project/AGENTS.fragment.md` | 修改 | 增加参考库消费协议 |
| `skills/design-engineering/references/reference-library-consumption.md` | 新增 | Skill 的参考库使用细则 |
| `docs/architecture.md` | 修改 | 增加 Reference Library 与 Work Item 关系 |
| `docs/manual-test-guide.md` | 修改 | 增加参考库和终端判断测试 |
| `examples/` | 修改 | 至少一个 Work Item 包含 `REFERENCE_SELECTION.md` |
| `evals/scenarios/11-13` | 新增 | Web/mobile/reference-selection 相关评测；保留 visual-workflow revision 已有 01-10 |

## 不变项

- 状态解析枚举仍是 `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`。
- Gate 枚举不变，不新增 `surface-approval`。
- `completed + sealed` 仍然只读，不可恢复执行。
- Steward 仍然只管理状态，不设计页面，不代替用户批准。
- v0.1 非目标仍然不做：CLI、Hook、Plugin、安装器、外部运行时依赖等。

## 编码重点

Codex 实现时应优先保证：

1. 没有 `reference-library/reference-packs/`；
2. Work Item 创建时可以生成 `REFERENCE_SELECTION.md`；
3. `STATE.md` 只链接和摘要，不吞掉完整参考分析；
4. 所有参考条目都含有 `surface`，能按终端过滤；
5. 色卡目录存在，后续可以直接追加图片和解释；
6. visual-workflow revision 已有 10 个评测仍成立，并追加 3 个 Reference Library 评测。
