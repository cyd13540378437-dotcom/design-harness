# Product Business Modeling Core Contract

This reference summarizes the non-negotiable Core contract used by the Codex Skill adapter.

## Identity

`product-business-modeling` is an Agent-neutral DesignHarnessAgent Core capability. Codex, Cursor, and Claude are runtime adapters.

The Codex Skill exists only to make the Core callable in Codex.

## Project source of truth

Long-lived business-model assets live under:

```text
docs/product/business-modeling/
```

Task-level outputs live under:

```text
docs/product/work-items/BM-xxx-<slug>/
```

Model triggers live under:

```text
docs/product/model-triggers/MT-xxx.md
```

## Business attributes, not fields

The core model uses business attributes, not database fields. Technical field mappings are downstream suggestions only.

## `schema-view.json`

The schema view is a compact business attribute structure view. It only contains:

- business objects;
- business domain;
- object category;
- business attributes;
- example content.

## Human Decision Request

When a high-impact decision is required, ask in this format:

```markdown
## 需要你确认的产品判断

### 当前理解

我目前理解为：...

### 为什么这个问题重要

这个判断会影响：

- 业务对象定义
- 对象关系
- 状态流转
- 权限规则
- 数据库设计
- UX 表达
- QA 验收

### 可选方案

#### 方案 A：...

优点：
- ...

代价：
- ...

#### 方案 B：...

优点：
- ...

代价：
- ...

### 我的推荐

推荐方案 ...

### 需要你确认

请确认：选 A / 选 B / 我补充一个规则
```

Record pending and resolved decisions in `DECISION_NOTES.md`.
