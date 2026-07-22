# Core Domain Objects

> 状态：`provisional`。对象 ID、边界和责任与字典 / Schema View 保持一致。

## 工单 (`work_order`)

### Identity
- Object Name: `WorkOrder`
- Domain: `service_demand`
- Category: `process_carrier`
- Status: `provisional`

### What It Is
服务需求，不等同于执行记录。

### Core Business Attributes
- `work_order_identity` — 工单业务身份：唯一识别服务需求。
- `service_type` — 服务类型：需要执行的服务类别。
- `priority` — 优先级：业务紧急程度。
- `service_commitment` — 服务承诺：响应、到场或完成承诺。
- `desired_service_window` — 期望服务窗口：业务希望的执行时间范围。
- `estimated_effort` — 预计工作量：执行所需业务工作量。
- `related_maintainable_asset` — 关联可维护资产：本次服务对象。
- `service_location` — 服务位置：服务发生的业务位置。
- `required_capabilities` — 所需能力：完成服务所需能力集合。
- `work_order_status` — 工单状态：工单当前业务阶段。

## 可维护资产 (`maintainable_asset`)

### Identity
- Object Name: `MaintainableAsset`
- Domain: `facility_context`
- Category: `core_business_object`
- Status: `provisional`

### What It Is
被维护的设备、系统或设施构件，不包含空间位置。

### Core Business Attributes
- `asset_identity` — 资产业务身份：唯一识别被维护对象。
- `asset_name` — 资产名称：业务可理解名称。
- `facility_system` — 所属专业系统：资产所属设施系统。
- `criticality` — 重要等级：停机或故障的业务影响。
- `installed_location` — 所在位置：资产安装或作用位置。
- `service_constraints` — 服务限制：维护时必须满足的业务条件。
- `operating_status` — 运行状态：资产当前服务或故障状态。

### Identity Decision
- 本例已将旧的 `Asset / Facility` 收敛为 `MaintainableAsset`；空间由 `ServiceLocation` 表达。

## 服务位置 (`service_location`)

### Identity
- Object Name: `ServiceLocation`
- Domain: `facility_context`
- Category: `context_object`
- Status: `provisional`

### What It Is
空间与区域上下文，不固有包含到达成本。

### Core Business Attributes
- `location_name` — 位置名称：业务可识别位置。
- `location_hierarchy` — 区域层级：位置在项目空间中的层级。
- `responsibility_scope` — 责任范围：负责该区域的组织范围。
- `access_restrictions` — 通行限制：进入或服务该位置的条件。

### Context-dependent Values That Do Not Belong Here
- 预计到达成本：依赖候选资源当前位置、时间窗口和通行条件，归入 `dispatch_candidate.estimated_arrival_cost`。

## 工单要求 (`work_requirement`)

### Identity
- Object Name: `WorkRequirement`
- Domain: `service_demand`
- Category: `requirement_object`
- Status: `provisional`

### What It Is
可调度要求，不是算法特征。

### Core Business Attributes
- `requirement_source` — 要求来源：要求来自何种业务事实。
- `capability_requirements` — 能力要求：必须具备的专业能力。
- `qualification_requirements` — 资质要求：必须具备的业务资质。
- `safety_requirements` — 安全要求：必须满足的作业条件。
- `tool_requirements` — 工具要求：执行所需工具条件。
- `time_requirements` — 时间要求：需要满足的业务时限。
- `requirement_status` — 要求确认状态：要求是否已足以进入调度。

## 服务资源 (`service_resource`)

### Identity
- Object Name: `ServiceResource`
- Domain: `resource_capacity`
- Category: `participant_resource`
- Status: `provisional`

### What It Is
可承担责任的资源抽象，资源类型仍待确认。

### Core Business Attributes
- `resource_identity` — 资源身份：承担执行责任的资源身份。
- `resource_type` — 资源类型：个人、班组、岗位或外包等分类。
- `organization` — 所属组织：资源所属业务组织。
- `coverage_area` — 覆盖区域：资源可服务范围。
- `capability_set` — 能力集合：资源可承担的工作能力。
- `current_load` — 当前负载：已承诺的业务工作量。
- `work_status` — 工作状态：资源当前可服务状态。

## 能力 (`capability`)

### Identity
- Object Name: `Capability`
- Domain: `resource_capacity`
- Category: `capability_object`
- Status: `provisional`

### What It Is
胜任条件，不是证书存储。

### Core Business Attributes
- `capability_name` — 能力名称：业务能力名称。
- `capability_level` — 能力等级：胜任程度。
- `applicable_service_types` — 适用服务类型：能力适用的服务范围。
- `qualification_constraints` — 资质约束：能力成立所需资质。
- `validity_status` — 有效状态：能力当前是否有效。

## 资源可用性 (`resource_availability`)

### Identity
- Object Name: `ResourceAvailability`
- Domain: `resource_capacity`
- Category: `capacity_object`
- Status: `provisional`

### What It Is
业务可承诺容量，不是日历实现。

### Core Business Attributes
- `resource_reference` — 对应资源：可用性所属资源。
- `available_window` — 可服务时段：可被承诺的时间范围。
- `committable_capacity` — 可承诺容量：剩余可承诺工作量。
- `existing_commitments` — 已有占用：当前任务承诺。
- `unavailable_reason` — 不可用原因：不能承诺的业务原因。
- `availability_status` — 可承诺状态：整体可承诺程度。

## 调度策略 (`dispatch_policy`)

### Identity
- Object Name: `DispatchPolicy`
- Domain: `dispatch_decisioning`
- Category: `policy_object`
- Status: `provisional`

### What It Is
硬约束、排序偏好与护栏，不是算法代码。

### Core Business Attributes
- `policy_name` — 策略名称：业务可识别策略。
- `applicable_scenario` — 适用场景：策略适用条件。
- `hard_constraints` — 硬性约束：决定是否可派的条件。
- `ranking_preferences` — 排序偏好：候选之间的优先依据。
- `guardrail_metrics` — 护栏指标：优化时不能伤害的目标。
- `policy_status` — 生效状态：策略是否可用于生产或试验。

## 派工候选 (`dispatch_candidate`)

### Identity
- Object Name: `DispatchCandidate`
- Domain: `dispatch_decisioning`
- Category: `candidate_object`
- Status: `provisional`

### What It Is
工单、资源和开始窗口的可比较方案。

### Core Business Attributes
- `candidate_work_order` — 候选工单：被安排的工单。
- `candidate_resource` — 候选资源：可能承担工作的资源。
- `candidate_start_window` — 候选开始窗口：可能承诺的开始时间。
- `match_reasons` — 匹配理由：为什么该方案可行。
- `estimated_arrival_cost` — 预计到达成本：基于资源位置、服务位置和时间窗口的上下文评估。
- `business_risks` — 业务风险：采用候选方案的业务代价。
- `candidate_status` — 候选状态：是否可推荐或被排除。

## 派工决策 (`dispatch_decision`)

### Identity
- Object Name: `DispatchDecision`
- Domain: `dispatch_decisioning`
- Category: `decision_object`
- Status: `provisional`

### What It Is
推荐、确认、覆盖与提交的业务选择。

### Core Business Attributes
- `decision_work_order` — 决策对象：被决定的工单。
- `selected_resource` — 被选资源：最终选择的资源。
- `planned_start_window` — 计划开始窗口：决策中的开始承诺。
- `decision_method` — 决策方式：系统建议、人工确认或覆盖。
- `decision_reason` — 业务理由：为什么做出该选择。
- `override_reason` — 覆盖原因：人工改变建议的原因。
- `decision_status` — 决策状态：推荐、确认、覆盖、提交等阶段。

## 派工责任 (`assignment`)

### Identity
- Object Name: `Assignment`
- Domain: `dispatch_decisioning`
- Category: `commitment_object`
- Status: `provisional`

### What It Is
决策提交后形成的执行责任。

### Core Business Attributes
- `assigned_work_order` — 责任工单：责任对应工单。
- `responsible_resource` — 责任资源：承担执行责任的资源。
- `committed_start_window` — 承诺开始窗口：已形成责任的开始范围。
- `acceptance_status` — 接受状态：资源是否接受责任。
- `assignment_status` — 责任状态：创建、通知、执行、完成等状态。
- `change_reason` — 变更原因：取消或重派的业务原因。

## 执行记录 (`execution_record`)

### Identity
- Object Name: `ExecutionRecord`
- Domain: `execution_feedback`
- Category: `event_record`
- Status: `provisional`

### What It Is
实际执行事实，不替代决策与责任。

### Core Business Attributes
- `work_order_reference` — 对应工单：执行事实所属工单。
- `actual_start` — 实际开始：实际开始时间。
- `actual_completion` — 实际完成：实际结束时间。
- `execution_result` — 执行结果：业务完成结果。
- `exception_reason` — 异常原因：未按计划执行的原因。
- `quality_feedback` — 质量反馈：业务质量确认。
- `reassignment_result` — 重派情况：执行过程是否发生重派。

## 调度评估快照 (`dispatch_evaluation_snapshot`)

### Identity
- Object Name: `DispatchEvaluationSnapshot`
- Domain: `strategy_evaluation`
- Category: `evidence_object`
- Status: `provisional`

### What It Is
策略回放证据，不是普通日志。

### Core Business Attributes
- `evaluated_decision` — 评估对象：被回放的调度决策。
- `decision_context` — 决策现场：当时工单、资源和可用性上下文。
- `candidate_set` — 候选集合：当时可比较方案。
- `policy_ranking` — 策略排序：策略对候选的排序。
- `final_selection` — 最终选择：实际提交的方案。
- `execution_feedback` — 执行反馈：后续执行结果。
- `evidence_completeness` — 证据完整性：快照是否足以评估。
