# 复合对象身份必须收敛或进入 Human Decision

**Given**：一个对象标签为 `Asset / Facility`，同时覆盖设备、空间、系统和公共区域，或对象名使用斜杠连接不同生命周期概念。

**When**：Domain Object Profiler 检查对象身份。

**Then**：必须拆分对象、定义明确的 umbrella concept，或创建 D2 `BMD-xxx` identity decision；不得把未决复合对象标为 confirmed。
