# 独立商业分析架构 v0.1.2

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
核心决策分析
复审、风险与决策记忆
材料接收、项目提取与质量保障
Human Decision Control Plane
```

六段式架构仅作为参考；商业分析当前没有 Passive Trigger Interface。

## 独立性合同

商业分析：

```text
可以在没有任何兄弟能力时独立运行；
拥有自己的 Work Item、Case、Network、Evidence 与 Review；
不读取兄弟能力作为隐含权威；
不写入、触发或编译兄弟能力资产；
不使用共享 Work Item 目录。
```
