# 中文输出合同（Output Language Contract）

## 1. 默认语言

所有用户可见回复和项目级人读 Markdown 输出默认使用简体中文。

## 2. 英文可用范围

允许使用英文：

```text
文件名
稳定 ID
状态枚举
YAML / JSON key
模型 ID
内部运行时 Prompt
可选英文 companion 文件
```

英文运行时内容不能替代中文用户输出或中文项目资产。

## 3. 用户明确要求英文时

仍须保留中文版本，并可额外生成 `.en.md` 或同文件中的完整英文镜像章节。

## 4. 模板要求

所有 Markdown 输出模板必须：

```text
中文标题和说明完整
适用时 frontmatter 包含 language: zh-CN
英文标识符只作为稳定字段名或括注
```

## 5. 质量检查

缺少中文主输出时，Decision Assurance 至少为 `warn`；用户明确要求中文却缺失时为 `block`。
