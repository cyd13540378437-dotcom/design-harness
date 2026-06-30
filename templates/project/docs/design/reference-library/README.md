# Product Visual Reference Library

这是项目级的长期视觉参考资料层，用于帮助 Agent 在 UI/UX 任务中做专业判断。

它不是某个 Work Item 的状态，也不是让用户背诵“哪个产品有什么设计优势”的资料库。正确用法是：Agent 先根据任务目标、终端、页面类型、用户成熟度、内容密度和交互复杂度检索资料库，再把结果压缩成用户能判断的产品方向。

## 核心边界

- `reference-library/` 保存长期、跨任务可复用的资料。
- 每个 Work Item 的实际参考选择应写入该 Work Item 下的 `REFERENCE_SELECTION.md`。
- `STATE.md` 只记录本任务采用的终端、参考选择摘要、批准决定和链接。
- 不在 `reference-library/` 内创建 `reference-packs/`，避免把长期资料层和任务级消费结果混在一起。

## 推荐检索顺序

1. 先明确目标终端：`web-app`、`mobile-app`、`responsive-web`、`desktop-app`、`tablet`、`multi-surface`。
2. 优先匹配同终端。
3. 再匹配页面类型：dashboard、editor、search、detail、checkout、onboarding、settings 等。
4. 再匹配任务类型：任务推进、内容发现、AI 问答、数据分析、协作、交易、健康陪伴等。
5. 最后才考虑行业、视觉标签和知名产品名称。

## 跨终端借鉴规则

跨终端参考只能用于抽象模式，不得直接用于布局、密度、手势、导航或视觉比例。

例如：

- Web 工作台任务可以借鉴移动 App 的“激励反馈”或“空状态文案”，但不能照搬底部导航和卡片比例。
- Mobile App 任务可以借鉴 Web 产品的“对象关系”和“业务流程”，但不能照搬侧边栏、多列布局和表格密度。
- Responsive Web 任务必须同时考虑桌面 Web 和移动 Web，不能用 native mobile app 截图替代移动 Web 判断。

## 文件说明

- `product-index.md`：面向人和 LLM 的产品总索引。
- `product-index.yml`：机器可读的产品索引。
- `products/`：每个产品一份结构化说明。
- `pattern-index.md`：设计模式索引。
- `patterns/`：每个设计模式一份结构化说明。
- `source-manifest.yml`：截图和参考来源清单。
- `llm-usage-guide.md`：Agent 如何检索、筛选和生成本任务参考选择。
- `assets/screenshots/`：项目内截图素材存放区。
- `assets/color-cards/`：色卡图片与解释的预留区。
- `schemas/`：资料条目的字段约定。

## 版权与使用边界

第三方截图、商标、图标、插画和文案只用于内部研究和模式抽象。不要在产品界面、官网、宣传材料或公开文档中直接复用第三方品牌资产或完整页面布局。
