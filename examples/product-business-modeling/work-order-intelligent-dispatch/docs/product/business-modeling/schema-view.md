# Business Schema View

> `schema-view.json` 是结构视图权威源。本文件仅展示对象、领域、分类、业务属性和示例内容。

## 服务需求

### 工单 (`work_order`)

- Object Name: `WorkOrder`
- Category: `process_carrier`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `work_order_identity` | 工单业务身份 | WO-2026-0001 |
| `service_type` | 服务类型 | 空调故障维修 |
| `priority` | 优先级 | 紧急 |
| `service_commitment` | 服务承诺 | 2 小时内到场 |
| `desired_service_window` | 期望服务窗口 | 今日 14:00-17:00 |
| `estimated_effort` | 预计工作量 | 约 60 分钟 |
| `related_maintainable_asset` | 关联可维护资产 | 3 号楼中央空调主机 |
| `service_location` | 服务位置 | A 园区 3 号楼 B1 机房 |
| `required_capabilities` | 所需能力 | 暖通维修、低压电工资质 |
| `work_order_status` | 工单状态 | 待调度 |

### 工单要求 (`work_requirement`)

- Object Name: `WorkRequirement`
- Category: `requirement_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `requirement_source` | 要求来源 | 工单描述与资产类型推导 |
| `capability_requirements` | 能力要求 | 暖通维修 |
| `qualification_requirements` | 资质要求 | 低压电工证 |
| `safety_requirements` | 安全要求 | 双人作业 |
| `tool_requirements` | 工具要求 | 压力表 |
| `time_requirements` | 时间要求 | 今日完成 |
| `requirement_status` | 要求确认状态 | 待班组长确认 |

## 设备设施上下文

### 可维护资产 (`maintainable_asset`)

- Object Name: `MaintainableAsset`
- Category: `core_business_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `asset_identity` | 资产业务身份 | FAC-HVAC-003 |
| `asset_name` | 资产名称 | 中央空调主机 |
| `facility_system` | 所属专业系统 | 暖通系统 |
| `criticality` | 重要等级 | 关键设备 |
| `installed_location` | 所在位置 | A 园区 3 号楼 B1 机房 |
| `service_constraints` | 服务限制 | 需双人进入机房 |
| `operating_status` | 运行状态 | 故障停机 |

### 服务位置 (`service_location`)

- Object Name: `ServiceLocation`
- Category: `context_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `location_name` | 位置名称 | A 园区 3 号楼 B1 机房 |
| `location_hierarchy` | 区域层级 | 项目 / 楼栋 / 楼层 / 房间 |
| `responsibility_scope` | 责任范围 | 工程一组负责 |
| `access_restrictions` | 通行限制 | 需机房权限 |

## 资源能力与容量

### 服务资源 (`service_resource`)

- Object Name: `ServiceResource`
- Category: `participant_resource`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `resource_identity` | 资源身份 | 暖通技工张三 |
| `resource_type` | 资源类型 | 个人技工 |
| `organization` | 所属组织 | 工程一组 |
| `coverage_area` | 覆盖区域 | A 园区 |
| `capability_set` | 能力集合 | 暖通维修、空调保养 |
| `current_load` | 当前负载 | 今日已承诺 4 小时 |
| `work_status` | 工作状态 | 可接单 |

### 能力 (`capability`)

- Object Name: `Capability`
- Category: `capability_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `capability_name` | 能力名称 | 暖通维修 |
| `capability_level` | 能力等级 | 熟练 |
| `applicable_service_types` | 适用服务类型 | 空调故障、风机盘管维修 |
| `qualification_constraints` | 资质约束 | 低压电工证 |
| `validity_status` | 有效状态 | 有效 |

### 资源可用性 (`resource_availability`)

- Object Name: `ResourceAvailability`
- Category: `capacity_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `resource_reference` | 对应资源 | 暖通技工张三 |
| `available_window` | 可服务时段 | 今日 09:00-18:00 |
| `committable_capacity` | 可承诺容量 | 剩余约 3 小时 |
| `existing_commitments` | 已有占用 | 15:00-16:00 已有保养任务 |
| `unavailable_reason` | 不可用原因 | 请假、培训、跨区支援 |
| `availability_status` | 可承诺状态 | 可部分承诺 |

## 调度决策

### 调度策略 (`dispatch_policy`)

- Object Name: `DispatchPolicy`
- Category: `policy_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `policy_name` | 策略名称 | SLA 护栏下的利用率优先策略 |
| `applicable_scenario` | 适用场景 | 非应急维修 |
| `hard_constraints` | 硬性约束 | 必须具备技能且在班 |
| `ranking_preferences` | 排序偏好 | SLA 风险、预计到达成本、负载均衡 |
| `guardrail_metrics` | 护栏指标 | 不增加加班、不牺牲应急缓冲 |
| `policy_status` | 生效状态 | 试运行 |

### 派工候选 (`dispatch_candidate`)

- Object Name: `DispatchCandidate`
- Category: `candidate_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `candidate_work_order` | 候选工单 | WO-2026-0001 |
| `candidate_resource` | 候选资源 | 暖通技工张三 |
| `candidate_start_window` | 候选开始窗口 | 今日 15:30-16:30 |
| `match_reasons` | 匹配理由 | 技能匹配且同园区 |
| `estimated_arrival_cost` | 预计到达成本 | 从当前任务地点预计 12 分钟 |
| `business_risks` | 业务风险 | 可能压缩应急缓冲 |
| `candidate_status` | 候选状态 | 可推荐 |

### 派工决策 (`dispatch_decision`)

- Object Name: `DispatchDecision`
- Category: `decision_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `decision_work_order` | 决策对象 | WO-2026-0001 |
| `selected_resource` | 被选资源 | 暖通技工张三 |
| `planned_start_window` | 计划开始窗口 | 今日 15:30-16:30 |
| `decision_method` | 决策方式 | 系统建议、人工确认 |
| `decision_reason` | 业务理由 | 满足 SLA 且同区域空闲 |
| `override_reason` | 覆盖原因 | 更熟悉该设备 |
| `decision_status` | 决策状态 | 已确认 |

### 派工责任 (`assignment`)

- Object Name: `Assignment`
- Category: `commitment_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `assigned_work_order` | 责任工单 | WO-2026-0001 |
| `responsible_resource` | 责任资源 | 暖通技工张三 |
| `committed_start_window` | 承诺开始窗口 | 今日 15:30-16:30 |
| `acceptance_status` | 接受状态 | 已接单 |
| `assignment_status` | 责任状态 | 执行中 |
| `change_reason` | 变更原因 | 紧急工单插入导致重排 |

## 执行反馈

### 执行记录 (`execution_record`)

- Object Name: `ExecutionRecord`
- Category: `event_record`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `work_order_reference` | 对应工单 | WO-2026-0001 |
| `actual_start` | 实际开始 | 今日 15:42 |
| `actual_completion` | 实际完成 | 今日 16:35 |
| `execution_result` | 执行结果 | 已修复 |
| `exception_reason` | 异常原因 | 缺少配件 |
| `quality_feedback` | 质量反馈 | 客户确认正常 |
| `reassignment_result` | 重派情况 | 未重派 |

## 策略评估

### 调度评估快照 (`dispatch_evaluation_snapshot`)

- Object Name: `DispatchEvaluationSnapshot`
- Category: `evidence_object`

| Attribute ID | 业务属性 | 示例 |
|---|---|---|
| `evaluated_decision` | 评估对象 | WO-2026-0001 的调度决策 |
| `decision_context` | 决策现场 | 决策时点快照 |
| `candidate_set` | 候选集合 | 3 个可推荐资源 |
| `policy_ranking` | 策略排序 | 张三第一，李四第二 |
| `final_selection` | 最终选择 | 张三 15:30 开始 |
| `execution_feedback` | 执行反馈 | 未逾期，耗时 53 分钟 |
| `evidence_completeness` | 证据完整性 | 候选、理由、结果齐全 |
