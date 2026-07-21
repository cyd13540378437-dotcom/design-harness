# Validation and Evals

## 1. 静态检查

- YAML 可解析；
- 所有 ready 模型卡有六个非空 usage prompts；
- 模型卡 index 路径存在且 ID 唯一；
- Decision Case 只存在一个权威位置；
- 项目模板没有共享 `docs/product/work-items/`；
- 项目模板没有 `model-triggers/` 或 downstream views；
- 所有 BA Work Item 文件均位于模块根目录下；
- 示例索引、Case、State、Network 和 Evidence 一致。

## 2. 行为评测

Given / When / Then 场景至少覆盖：原始输入、理解前置、路由、旧 Case 新证据、复审、证据越界、模型选择、模型误用、Analysis Run、反方分析、质量 block、选择题、人类决定、单一权威、独立目录和零跨模块改动。
