# 模块总览定义协议

## 1. 目的

模块总览是一个 DesignHarnessAgent 能力模块的稳定交付出口。

它解决的是该模块的阅读、判断和交付体验，不替代模块自己的 source of truth：

```text
模块源资产 = 权威事实、状态、证据和审计记录
模块总览 = 面向用户的当前编译视图
项目交付层 = 跨模块组合多个模块总览
```

这个模式可以被视为一种可复用的总结技能：先确定读者和边界，只从权威输入编译，暴露待确认问题，并让每一段总结都可追溯。

## 2. 核心分工

每个能力模块负责定义：

- 自己的默认模块总览放在哪里；
- 哪些文件是 source of truth；
- 哪些内容可以被交付层引用；
- 哪些问题需要汇总进开放问题；
- 什么状态下总览是 current、draft、partial、stale 或 blocked；
- 总览何时必须重新编译。

项目交付层负责：

- 读取各模块声明的总览和出口元数据；
- 把多个模块出口组合成项目首页；
- 生成跨模块 `SOURCE_MAP.yml`；
- 汇总所有模块的开放问题；
- 不反写、不推断、不绕过模块 gate。

简化成一句话：

```text
模块定义“我能交付什么”
项目交付层定义“这些交付如何组合成一个项目入口”
```

## 3. 标准模块输出骨架

模块目录不要求所有文件同名，但必须有一致的结构槽位。新项目中，每个参与交付的模块都应该收束在自己的模块根目录下：

```text
<module-root>/
  README.md                 # 模块职责、边界和默认阅读入口
  <MODULE_INDEX>.yml         # 机器索引；可镜像 delivery_exports
  <MODULE_INDEX>.md          # 维护者导航
  <MODULE_WORK_ITEMS>.md     # Work Item 导航索引
  <MODULE_OVERVIEW>.md       # 默认模块总览
  DELIVERY_EXPORTS.yml       # 项目交付层消费的薄出口声明
  work-items/                # 模块自有过程资产
  outputs/                   # 当前可展示成果和归档；按模块需要使用
  references/                # 参考材料；按模块需要使用
  <module-domain-assets>/     # 模块领域资产，允许使用领域名称
```

统一的是外层槽位和职责，不是强迫领域资产使用同一名称。BA 可以继续使用 `decision-cases/`，BM 可以继续使用 `domain-objects/`、`rules/`、`states/`，Design 可以继续使用 `project-memory/`、`reference-library/` 和 `outputs/current/`。

当前三类模块根为：

```text
Business Analysis  -> docs/product/business-analysis/
Business Modeling  -> docs/product/business-modeling/
Design Engineering -> docs/design/
```

新运行不得把模块 Work Item 放入兄弟模块目录或共享的 `docs/product/work-items/`。若读取旧项目发现旧路径，只能作为 legacy/migration input，并在下一次持久写入时迁移或映射到模块根结构。

## 4. 标准合同

每个希望参与项目级交付的能力模块，都应该定义一个默认模块总览：

```yaml
view_type: <module>_overview
audience: product_owner
is_default_module_delivery_view: true
is_project_delivery_entry: false
is_source_of_truth: false
generated_by: <module-owned compiler or orchestrator>
source_assets: []
open_questions_source: []
```

模块拥有这个合同。项目交付层只能消费这个合同，不能自行硬编码模块内部 Work Item 路径，也不能替模块决定哪些文件适合给用户看。

如果目标项目里已有模块索引，同样应该在项目侧暴露出口声明：

```text
Business Modeling  -> docs/product/business-modeling/BUSINESS_MODEL_INDEX.yml
Business Analysis  -> docs/product/business-analysis/BUSINESS_ANALYSIS_INDEX.yml
Design Engineering -> docs/design/DELIVERY_EXPORTS.yml
```

这些项目侧声明故意保持很薄，只指向模块总览、权威源根目录、开放问题来源和可导出栏目；不要复制总览正文。

## 5. 模块总览必须回答什么

每份模块总览都必须让非专业用户看懂：

1. 这个模块当前的结论是什么；
2. 哪些内容已确认、暂定、过期或受阻；
3. 最近发生了什么变化；
4. 用户现在需要决定或回答什么；
5. 下游工作可以安全使用哪些内容；
6. 权威源文件在哪里；
7. 什么情况下必须重新生成总览。

如果存在待确认决定，总览必须压缩出足够上下文，让用户不用打开审计文件也能直接回复。

## 6. 编译规则

- 只从模块自有 source of truth 和模块自有 Work Item 记录编译。
- 不得从 `docs/project-delivery/` 反向编译回模块事实。
- 不得把未批准的草稿、临时原型或 Work Item 现场材料提升为 current 总览。
- 输入缺失时要诚实标记 `partial`、`provisional` 或 `stale`，不能假装完整。
- source path 必须足够明确，方便项目交付层生成 `docs/project-delivery/current/SOURCE_MAP.yml`。

## 7. 如何使用这个方法

### 7.1 给已有模块新增总览

1. 找出模块已有的 source of truth。
2. 找出用户现在最容易迷路的地方：文件太多、结论分散、待确认问题散落，还是当前入口不明确。
3. 选定一个固定模块总览路径。
4. 写模块专属总览协议，至少说明：目的、路径、写入者、编译输入、必需栏目、编译时机、新鲜度规则、失败处理和 source map。
5. 创建模块总览模板。
6. 在 manifest 或模块索引中加入 `delivery_exports`。
7. 更新 runtime / skill / adapter 规则，让模块状态变化后会重新编译总览。
8. 更新 README 或 architecture，让维护者知道该总览是模块出口，不是 source of truth。

### 7.2 给新模块设计总览

先不要设计 `docs/project-delivery/` 页面。

应该先回答：

- 这个模块的权威源在哪里？
- 用户默认应该看哪一份文件？
- 用户需要在这份文件里完成什么判断？
- 哪些内容可以被项目交付层摘录？
- 哪些内容必须只保留在审计或维护文件里？
- 哪些 gate 或人类决定不能被交付层绕过？

回答清楚后，再创建模块总览协议和模板。

### 7.3 给项目交付层使用

项目交付层只做消费和组合：

```text
读取各模块 delivery_exports
→ 读取各模块 default_module_delivery_view
→ 汇总 current 状态、关键结论和 open questions
→ 生成项目首页和 SOURCE_MAP.yml
```

项目交付层不能做：

- 直接读取某个模块的深层 Work Item 并自行总结；
- 把模块未批准内容提升成项目 current；
- 修改 Decision Case、业务模型 source of truth 或 sealed design state；
- 自行决定某个内部文件是用户可见交付物。

## 8. 当前模块出口

```text
Business Modeling:
docs/product/business-modeling/BUSINESS_MODEL_OVERVIEW.md

Business Analysis:
docs/product/business-analysis/BUSINESS_DECISION_OVERVIEW.md

Design Engineering:
docs/design/DESIGN_OVERVIEW.md
```

## 9. 验收清单

新增或修改一个模块总览时，至少检查：

- [ ] 模块总览路径固定；
- [ ] 总览声明 `is_source_of_truth: false`；
- [ ] 模块 source of truth 没有被搬进总览；
- [ ] 待用户确认的问题可以直接在总览中理解和回复；
- [ ] `delivery_exports` 已在模块 manifest、项目侧索引或 `DELIVERY_EXPORTS.yml` 中声明；
- [ ] 项目交付层可以只依赖总览和 `delivery_exports`；
- [ ] README / architecture / adapter 口径没有把模块总览误写成整个项目唯一入口。
