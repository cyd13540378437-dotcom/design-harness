# 独立商业分析架构 v0.1.4

## 三层

```text
Core
↓
Runtime Adapters
↓
Project Knowledge Assets
```

## 五个运行域

```text
统筹与路由
Choice-first 核心决策分析
复审、风险与决策记忆
材料接收、专业分析与质量保障
Human Decision Control Plane
```

v0.1.4 在统筹与质量保障中新增混合轮次、Scope Lock、Choice Closure、Artifact Boundary 和 No Execution Offer；不新增 Passive Trigger Interface。

## 独立性合同

商业分析独立运行，不读取、写入、触发或编译兄弟能力资产；不依赖共享动机分析能力；不使用共享 Work Item 目录；不自动移交越界实施请求。
