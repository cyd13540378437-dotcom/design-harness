# DesignHarnessAgent Business Modeling Core v0.2 产品总结

## 1. 产品定位

Business Modeling Core 是 DesignHarnessAgent 产品设计知识系统中的业务模型能力集群。它将业务世界抽象成稳定、统一、可演进的产品语义模型，让商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 在同一套业务语言下协作。

一句话：

> 业务模型不是数据库模型，也不是 PRD；它是产品系统对业务世界的语义抽象层。

## 2. 当前版本核心变化

v0.2 已经完成从“子能力工作逻辑设计稿”到“可落仓 Core 包”的收束：

```text
CAPABILITY.md
capability.manifest.yml
协议模板
项目模板
Adapter 规则片段
示例
人工评测
Codex 开工单
```

## 3. 最重要的边界

1. 业务属性不是数据字段；
2. `schema-view.json` 只表达五项结构浏览信息；
3. 下游视图不能反向成为权威源；
4. 项目解析只能生成候选和证据链；
5. 高影响语义必须进入 Human Decision Control Plane；
6. 被动触发使用 `model-triggers/`，不再使用 `model-requests/`。

## 4. 目录关系

```text
core/product-design/business-modeling/   # 能力本体
adapters/                                # Codex / Claude Code / Cursor 运行时入口
templates/project/docs/product/          # 目标项目模板
examples/product-business-modeling/      # 示例项目片段
evals/product-business-modeling/         # 人工评测
```

目标项目中的长期业务模型资产位于：

```text
docs/product/business-modeling/
```

任务级资产位于：

```text
docs/product/work-items/BM-xxx/
```

被动触发入口位于：

```text
docs/product/model-triggers/MT-xxx.md
```

## 5. 工作流总览

```text
用户请求 / Model Trigger / 项目解析 / 校验 / 编译请求
        ↓
业务模型总协调器
        ↓
模型更新分发器
        ↓
核心生产模块
        ↓
Human Decision Control Plane
        ↓
Source of Truth 更新
        ↓
一致性校验
        ↓
下游视图编译
        ↓
任务输出 / Trigger 回写 / 后续触发
```

## 6. v0.2 不做什么

本版本仍是文档型 Core，不做 CLI、Hook、Plugin、Marketplace、自动安装器、外部依赖、自动数据库迁移、自动 API 生成、图形化控制台、云端同步和多用户并发锁。

## 7. 下一步建议

最自然的下一步是实现 **Business Modeling Core v0.2 仓库化**：将本包内容合并进正式 DesignHarnessAgent 仓库，然后用一个真实产品示例跑通六种入口模式中的至少三种：

```text
direct_modeling
passive_trigger
project_extraction
```
