# Business Dictionary

> `business-dictionary.yml` 是结构化权威源；本文件是完整的人读伴随视图。全部条目当前为 `provisional`。

## Business Domains

| ID | Label | Description | Status |
|---|---|---|---|
| `service_demand` | 服务需求 | 承载工单、服务承诺和可调度要求。 | provisional |
| `facility_context` | 设备设施上下文 | 描述可维护资产与服务位置。 | provisional |
| `resource_capacity` | 资源能力与容量 | 描述资源、能力和可用性。 | provisional |
| `dispatch_decisioning` | 调度决策 | 描述策略、候选、决策与执行责任。 | provisional |
| `execution_feedback` | 执行反馈 | 描述实际执行过程和结果。 | provisional |
| `strategy_evaluation` | 策略评估 | 描述决策回放与效果证据。 | provisional |

## Object Categories

| ID | Label | Description | Status |
|---|---|---|---|
| `process_carrier` | 流程承载类 | 承载主要业务流程。 | provisional |
| `core_business_object` | 核心业务对象类 | 被服务或维护的核心对象。 | provisional |
| `context_object` | 业务上下文类 | 提供位置或环境约束。 | provisional |
| `requirement_object` | 要求表达类 | 把需求转成可判断约束。 | provisional |
| `participant_resource` | 参与资源类 | 承担业务责任的资源。 | provisional |
| `capability_object` | 能力类 | 表达可胜任条件。 | provisional |
| `capacity_object` | 容量类 | 表达时间与承诺容量。 | provisional |
| `policy_object` | 策略规则类 | 表达过滤、排序与护栏。 | provisional |
| `candidate_object` | 候选方案类 | 承载可比较方案。 | provisional |
| `decision_object` | 业务决策类 | 承载推荐、确认与覆盖。 | provisional |
| `commitment_object` | 责任承诺类 | 承载已形成的执行责任。 | provisional |
| `event_record` | 事件记录类 | 记录实际执行事实。 | provisional |
| `evidence_object` | 证据类 | 保存可回放评估证据。 | provisional |

## Business Objects

| ID | Name | Label | Domain ID | Category ID | Definition | Status |
|---|---|---|---|---|---|---|
| `work_order` | `WorkOrder` | 工单 | `service_demand` | `process_carrier` | 承载一次设备设施服务需求、服务承诺和业务进展的流程对象；不等同于执行记录。 | provisional |
| `maintainable_asset` | `MaintainableAsset` | 可维护资产 | `facility_context` | `core_business_object` | 被维护或服务的设备、系统或设施构件；不包含空间位置本身。 | provisional |
| `service_location` | `ServiceLocation` | 服务位置 | `facility_context` | `context_object` | 服务发生的空间、区域和通行上下文；不固有包含从某个资源出发的到达成本。 | provisional |
| `work_requirement` | `WorkRequirement` | 工单要求 | `service_demand` | `requirement_object` | 把工单需求转化为能力、资质、安全、工具和时间约束的要求对象。 | provisional |
| `service_resource` | `ServiceResource` | 服务资源 | `resource_capacity` | `participant_resource` | 可承担工单执行责任的资源抽象；第一期可覆盖个人、班组、岗位和外包资源，具体身份仍待确认。 | provisional |
| `capability` | `Capability` | 能力 | `resource_capacity` | `capability_object` | 资源胜任某类服务的业务能力及等级约束；不等同于证书文件或技能字段。 | provisional |
| `resource_availability` | `ResourceAvailability` | 资源可用性 | `resource_capacity` | `capacity_object` | 某个服务资源在特定时段可被业务承诺的容量与限制。 | provisional |
| `dispatch_policy` | `DispatchPolicy` | 调度策略 | `dispatch_decisioning` | `policy_object` | 用于候选过滤、排序和护栏判断的业务策略，不是算法代码。 | provisional |
| `dispatch_candidate` | `DispatchCandidate` | 派工候选 | `dispatch_decisioning` | `candidate_object` | 由工单、资源、候选开始窗口和上下文评估组成的可比较派工方案。 | provisional |
| `dispatch_decision` | `DispatchDecision` | 派工决策 | `dispatch_decisioning` | `decision_object` | 记录推荐、人工确认、覆盖、拒绝和提交理由的业务决策。 | provisional |
| `assignment` | `Assignment` | 派工责任 | `dispatch_decisioning` | `commitment_object` | 派工决策提交后形成的执行责任与承诺。 | provisional |
| `execution_record` | `ExecutionRecord` | 执行记录 | `execution_feedback` | `event_record` | 记录实际开始、完成、异常、质量和重派结果的执行事实。 | provisional |
| `dispatch_evaluation_snapshot` | `DispatchEvaluationSnapshot` | 调度评估快照 | `strategy_evaluation` | `evidence_object` | 保存候选集合、排序、最终选择和执行反馈的可回放策略评估证据。 | provisional |

## Business Attributes

| ID | Object ID | Label | Attribute Kind | Meaning | Example Content | Status |
|---|---|---|---|---|---|---|
| `work_order_identity` | `work_order` | 工单业务身份 | `intrinsic` | 唯一识别服务需求 | WO-2026-0001 | provisional |
| `service_type` | `work_order` | 服务类型 | `intrinsic` | 需要执行的服务类别 | 空调故障维修 | provisional |
| `priority` | `work_order` | 优先级 | `intrinsic` | 业务紧急程度 | 紧急 | provisional |
| `service_commitment` | `work_order` | 服务承诺 | `intrinsic` | 响应、到场或完成承诺 | 2 小时内到场 | provisional |
| `desired_service_window` | `work_order` | 期望服务窗口 | `intrinsic` | 业务希望的执行时间范围 | 今日 14:00-17:00 | provisional |
| `estimated_effort` | `work_order` | 预计工作量 | `intrinsic` | 执行所需业务工作量 | 约 60 分钟 | provisional |
| `related_maintainable_asset` | `work_order` | 关联可维护资产 | `relational` | 本次服务对象 | 3 号楼中央空调主机 | provisional |
| `service_location` | `work_order` | 服务位置 | `relational` | 服务发生的业务位置 | A 园区 3 号楼 B1 机房 | provisional |
| `required_capabilities` | `work_order` | 所需能力 | `relational` | 完成服务所需能力集合 | 暖通维修、低压电工资质 | provisional |
| `work_order_status` | `work_order` | 工单状态 | `intrinsic` | 工单当前业务阶段 | 待调度 | provisional |
| `asset_identity` | `maintainable_asset` | 资产业务身份 | `intrinsic` | 唯一识别被维护对象 | FAC-HVAC-003 | provisional |
| `asset_name` | `maintainable_asset` | 资产名称 | `intrinsic` | 业务可理解名称 | 中央空调主机 | provisional |
| `facility_system` | `maintainable_asset` | 所属专业系统 | `intrinsic` | 资产所属设施系统 | 暖通系统 | provisional |
| `criticality` | `maintainable_asset` | 重要等级 | `intrinsic` | 停机或故障的业务影响 | 关键设备 | provisional |
| `installed_location` | `maintainable_asset` | 所在位置 | `relational` | 资产安装或作用位置 | A 园区 3 号楼 B1 机房 | provisional |
| `service_constraints` | `maintainable_asset` | 服务限制 | `intrinsic` | 维护时必须满足的业务条件 | 需双人进入机房 | provisional |
| `operating_status` | `maintainable_asset` | 运行状态 | `intrinsic` | 资产当前服务或故障状态 | 故障停机 | provisional |
| `location_name` | `service_location` | 位置名称 | `intrinsic` | 业务可识别位置 | A 园区 3 号楼 B1 机房 | provisional |
| `location_hierarchy` | `service_location` | 区域层级 | `intrinsic` | 位置在项目空间中的层级 | 项目 / 楼栋 / 楼层 / 房间 | provisional |
| `responsibility_scope` | `service_location` | 责任范围 | `relational` | 负责该区域的组织范围 | 工程一组负责 | provisional |
| `access_restrictions` | `service_location` | 通行限制 | `intrinsic` | 进入或服务该位置的条件 | 需机房权限 | provisional |
| `requirement_source` | `work_requirement` | 要求来源 | `intrinsic` | 要求来自何种业务事实 | 工单描述与资产类型推导 | provisional |
| `capability_requirements` | `work_requirement` | 能力要求 | `relational` | 必须具备的专业能力 | 暖通维修 | provisional |
| `qualification_requirements` | `work_requirement` | 资质要求 | `intrinsic` | 必须具备的业务资质 | 低压电工证 | provisional |
| `safety_requirements` | `work_requirement` | 安全要求 | `intrinsic` | 必须满足的作业条件 | 双人作业 | provisional |
| `tool_requirements` | `work_requirement` | 工具要求 | `intrinsic` | 执行所需工具条件 | 压力表 | provisional |
| `time_requirements` | `work_requirement` | 时间要求 | `intrinsic` | 需要满足的业务时限 | 今日完成 | provisional |
| `requirement_status` | `work_requirement` | 要求确认状态 | `intrinsic` | 要求是否已足以进入调度 | 待班组长确认 | provisional |
| `resource_identity` | `service_resource` | 资源身份 | `intrinsic` | 承担执行责任的资源身份 | 暖通技工张三 | provisional |
| `resource_type` | `service_resource` | 资源类型 | `intrinsic` | 个人、班组、岗位或外包等分类 | 个人技工 | provisional |
| `organization` | `service_resource` | 所属组织 | `relational` | 资源所属业务组织 | 工程一组 | provisional |
| `coverage_area` | `service_resource` | 覆盖区域 | `relational` | 资源可服务范围 | A 园区 | provisional |
| `capability_set` | `service_resource` | 能力集合 | `relational` | 资源可承担的工作能力 | 暖通维修、空调保养 | provisional |
| `current_load` | `service_resource` | 当前负载 | `derived` | 已承诺的业务工作量 | 今日已承诺 4 小时 | provisional |
| `work_status` | `service_resource` | 工作状态 | `intrinsic` | 资源当前可服务状态 | 可接单 | provisional |
| `capability_name` | `capability` | 能力名称 | `intrinsic` | 业务能力名称 | 暖通维修 | provisional |
| `capability_level` | `capability` | 能力等级 | `intrinsic` | 胜任程度 | 熟练 | provisional |
| `applicable_service_types` | `capability` | 适用服务类型 | `relational` | 能力适用的服务范围 | 空调故障、风机盘管维修 | provisional |
| `qualification_constraints` | `capability` | 资质约束 | `intrinsic` | 能力成立所需资质 | 低压电工证 | provisional |
| `validity_status` | `capability` | 有效状态 | `intrinsic` | 能力当前是否有效 | 有效 | provisional |
| `resource_reference` | `resource_availability` | 对应资源 | `relational` | 可用性所属资源 | 暖通技工张三 | provisional |
| `available_window` | `resource_availability` | 可服务时段 | `contextual` | 可被承诺的时间范围 | 今日 09:00-18:00 | provisional |
| `committable_capacity` | `resource_availability` | 可承诺容量 | `derived` | 剩余可承诺工作量 | 剩余约 3 小时 | provisional |
| `existing_commitments` | `resource_availability` | 已有占用 | `relational` | 当前任务承诺 | 15:00-16:00 已有保养任务 | provisional |
| `unavailable_reason` | `resource_availability` | 不可用原因 | `contextual` | 不能承诺的业务原因 | 请假、培训、跨区支援 | provisional |
| `availability_status` | `resource_availability` | 可承诺状态 | `derived` | 整体可承诺程度 | 可部分承诺 | provisional |
| `policy_name` | `dispatch_policy` | 策略名称 | `intrinsic` | 业务可识别策略 | SLA 护栏下的利用率优先策略 | provisional |
| `applicable_scenario` | `dispatch_policy` | 适用场景 | `intrinsic` | 策略适用条件 | 非应急维修 | provisional |
| `hard_constraints` | `dispatch_policy` | 硬性约束 | `intrinsic` | 决定是否可派的条件 | 必须具备技能且在班 | provisional |
| `ranking_preferences` | `dispatch_policy` | 排序偏好 | `intrinsic` | 候选之间的优先依据 | SLA 风险、预计到达成本、负载均衡 | provisional |
| `guardrail_metrics` | `dispatch_policy` | 护栏指标 | `intrinsic` | 优化时不能伤害的目标 | 不增加加班、不牺牲应急缓冲 | provisional |
| `policy_status` | `dispatch_policy` | 生效状态 | `intrinsic` | 策略是否可用于生产或试验 | 试运行 | provisional |
| `candidate_work_order` | `dispatch_candidate` | 候选工单 | `relational` | 被安排的工单 | WO-2026-0001 | provisional |
| `candidate_resource` | `dispatch_candidate` | 候选资源 | `relational` | 可能承担工作的资源 | 暖通技工张三 | provisional |
| `candidate_start_window` | `dispatch_candidate` | 候选开始窗口 | `contextual` | 可能承诺的开始时间 | 今日 15:30-16:30 | provisional |
| `match_reasons` | `dispatch_candidate` | 匹配理由 | `derived` | 为什么该方案可行 | 技能匹配且同园区 | provisional |
| `estimated_arrival_cost` | `dispatch_candidate` | 预计到达成本 | `contextual` | 基于资源位置、服务位置和时间窗口的上下文评估 | 从当前任务地点预计 12 分钟 | provisional |
| `business_risks` | `dispatch_candidate` | 业务风险 | `derived` | 采用候选方案的业务代价 | 可能压缩应急缓冲 | provisional |
| `candidate_status` | `dispatch_candidate` | 候选状态 | `derived` | 是否可推荐或被排除 | 可推荐 | provisional |
| `decision_work_order` | `dispatch_decision` | 决策对象 | `relational` | 被决定的工单 | WO-2026-0001 | provisional |
| `selected_resource` | `dispatch_decision` | 被选资源 | `relational` | 最终选择的资源 | 暖通技工张三 | provisional |
| `planned_start_window` | `dispatch_decision` | 计划开始窗口 | `contextual` | 决策中的开始承诺 | 今日 15:30-16:30 | provisional |
| `decision_method` | `dispatch_decision` | 决策方式 | `intrinsic` | 系统建议、人工确认或覆盖 | 系统建议、人工确认 | provisional |
| `decision_reason` | `dispatch_decision` | 业务理由 | `intrinsic` | 为什么做出该选择 | 满足 SLA 且同区域空闲 | provisional |
| `override_reason` | `dispatch_decision` | 覆盖原因 | `intrinsic` | 人工改变建议的原因 | 更熟悉该设备 | provisional |
| `decision_status` | `dispatch_decision` | 决策状态 | `intrinsic` | 推荐、确认、覆盖、提交等阶段 | 已确认 | provisional |
| `assigned_work_order` | `assignment` | 责任工单 | `relational` | 责任对应工单 | WO-2026-0001 | provisional |
| `responsible_resource` | `assignment` | 责任资源 | `relational` | 承担执行责任的资源 | 暖通技工张三 | provisional |
| `committed_start_window` | `assignment` | 承诺开始窗口 | `contextual` | 已形成责任的开始范围 | 今日 15:30-16:30 | provisional |
| `acceptance_status` | `assignment` | 接受状态 | `intrinsic` | 资源是否接受责任 | 已接单 | provisional |
| `assignment_status` | `assignment` | 责任状态 | `intrinsic` | 创建、通知、执行、完成等状态 | 执行中 | provisional |
| `change_reason` | `assignment` | 变更原因 | `intrinsic` | 取消或重派的业务原因 | 紧急工单插入导致重排 | provisional |
| `work_order_reference` | `execution_record` | 对应工单 | `relational` | 执行事实所属工单 | WO-2026-0001 | provisional |
| `actual_start` | `execution_record` | 实际开始 | `intrinsic` | 实际开始时间 | 今日 15:42 | provisional |
| `actual_completion` | `execution_record` | 实际完成 | `intrinsic` | 实际结束时间 | 今日 16:35 | provisional |
| `execution_result` | `execution_record` | 执行结果 | `intrinsic` | 业务完成结果 | 已修复 | provisional |
| `exception_reason` | `execution_record` | 异常原因 | `intrinsic` | 未按计划执行的原因 | 缺少配件 | provisional |
| `quality_feedback` | `execution_record` | 质量反馈 | `intrinsic` | 业务质量确认 | 客户确认正常 | provisional |
| `reassignment_result` | `execution_record` | 重派情况 | `intrinsic` | 执行过程是否发生重派 | 未重派 | provisional |
| `evaluated_decision` | `dispatch_evaluation_snapshot` | 评估对象 | `relational` | 被回放的调度决策 | WO-2026-0001 的调度决策 | provisional |
| `decision_context` | `dispatch_evaluation_snapshot` | 决策现场 | `contextual` | 当时工单、资源和可用性上下文 | 决策时点快照 | provisional |
| `candidate_set` | `dispatch_evaluation_snapshot` | 候选集合 | `relational` | 当时可比较方案 | 3 个可推荐资源 | provisional |
| `policy_ranking` | `dispatch_evaluation_snapshot` | 策略排序 | `derived` | 策略对候选的排序 | 张三第一，李四第二 | provisional |
| `final_selection` | `dispatch_evaluation_snapshot` | 最终选择 | `derived` | 实际提交的方案 | 张三 15:30 开始 | provisional |
| `execution_feedback` | `dispatch_evaluation_snapshot` | 执行反馈 | `derived` | 后续执行结果 | 未逾期，耗时 53 分钟 | provisional |
| `evidence_completeness` | `dispatch_evaluation_snapshot` | 证据完整性 | `derived` | 快照是否足以评估 | 候选、理由、结果齐全 | provisional |

## Actions

| ID | Label | Actor Type | Actor IDs | Target Object ID | Meaning | Status |
|---|---|---|---|---|---|---|
| `ACT-001` | 确认工单要求 | `role` | `dispatcher` | `work_requirement` | 形成可调度要求 | provisional |
| `ACT-002` | 生成派工候选 | `system` | `scheduling_system` | `dispatch_candidate` | 形成满足硬约束的候选集合 | provisional |
| `ACT-003` | 推荐派工候选 | `system` | `scheduling_system` | `dispatch_decision` | 形成 recommended 决策 | provisional |
| `ACT-004` | 确认派工决策 | `role` | `dispatcher` | `dispatch_decision` | 将建议确认为 confirmed | provisional |
| `ACT-005` | 覆盖派工决策 | `role` | `dispatcher` | `dispatch_decision` | 记录覆盖方案与原因 | provisional |
| `ACT-006` | 拒绝派工建议 | `role` | `dispatcher` | `dispatch_decision` | 标记 rejected 并返回调度 | provisional |
| `ACT-007` | 提交派工决策 | `role` | `dispatcher` | `dispatch_decision` | 决策 committed 并创建 Assignment | provisional |
| `ACT-008` | 通知派工责任 | `system` | `scheduling_system` | `assignment` | 责任进入 notified | provisional |
| `ACT-009` | 接受派工责任 | `role` | `service_resource_actor` | `assignment` | 责任进入 accepted | provisional |
| `ACT-010` | 开始执行 | `role` | `service_resource_actor` | `assignment` | 责任 active，工单 in_progress | provisional |
| `ACT-011` | 暂停执行 | `role` | `service_resource_actor` | `assignment` | 责任 paused 并记录原因 | provisional |
| `ACT-012` | 恢复执行 | `role` | `service_resource_actor` | `assignment` | 责任返回 active | provisional |
| `ACT-013` | 完成执行 | `role` | `service_resource_actor` | `assignment` | 责任 finished，工单 awaiting_close | provisional |
| `ACT-014` | 请求重派 | `role` | `service_resource_actor` | `assignment` | 责任进入 reassignment_requested，工单返回调度 | provisional |
| `ACT-015` | 取消派工责任 | `role` | `dispatcher` | `assignment` | 责任 cancelled 并保留原因 | provisional |
| `ACT-016` | 关闭工单 | `role` | `supervisor` | `work_order` | 工单 closed | provisional |
| `ACT-017` | 取消工单 | `role` | `dispatcher` | `work_order` | 工单 cancelled 并保留原因 | provisional |
| `ACT-018` | 取消派工决策 | `role` | `dispatcher` | `dispatch_decision` | 决策 cancelled | provisional |

## States

| ID | Object ID | Label | Meaning | Status |
|---|---|---|---|---|
| `work_order.created` | `work_order` | 已创建 | 工单处于“已创建”阶段时成立的业务状态。 | provisional |
| `work_order.ready_for_dispatch` | `work_order` | 可调度 | 工单处于“可调度”阶段时成立的业务状态。 | provisional |
| `work_order.dispatching` | `work_order` | 调度中 | 工单处于“调度中”阶段时成立的业务状态。 | provisional |
| `work_order.assigned` | `work_order` | 已形成责任 | 工单处于“已形成责任”阶段时成立的业务状态。 | provisional |
| `work_order.in_progress` | `work_order` | 执行中 | 工单处于“执行中”阶段时成立的业务状态。 | provisional |
| `work_order.awaiting_close` | `work_order` | 待关闭 | 工单处于“待关闭”阶段时成立的业务状态。 | provisional |
| `work_order.closed` | `work_order` | 已关闭 | 工单处于“已关闭”阶段时成立的业务状态。 | provisional |
| `work_order.cancelled` | `work_order` | 已取消 | 工单处于“已取消”阶段时成立的业务状态。 | provisional |
| `dispatch_decision.recommended` | `dispatch_decision` | 已推荐 | 派工决策处于“已推荐”阶段时成立的业务状态。 | provisional |
| `dispatch_decision.confirmed` | `dispatch_decision` | 已确认 | 派工决策处于“已确认”阶段时成立的业务状态。 | provisional |
| `dispatch_decision.overridden` | `dispatch_decision` | 已覆盖 | 派工决策处于“已覆盖”阶段时成立的业务状态。 | provisional |
| `dispatch_decision.rejected` | `dispatch_decision` | 已拒绝 | 派工决策处于“已拒绝”阶段时成立的业务状态。 | provisional |
| `dispatch_decision.committed` | `dispatch_decision` | 已提交 | 派工决策处于“已提交”阶段时成立的业务状态。 | provisional |
| `dispatch_decision.cancelled` | `dispatch_decision` | 已取消 | 派工决策处于“已取消”阶段时成立的业务状态。 | provisional |
| `assignment.created` | `assignment` | 已创建 | 派工责任处于“已创建”阶段时成立的业务状态。 | provisional |
| `assignment.notified` | `assignment` | 已通知 | 派工责任处于“已通知”阶段时成立的业务状态。 | provisional |
| `assignment.accepted` | `assignment` | 已接受 | 派工责任处于“已接受”阶段时成立的业务状态。 | provisional |
| `assignment.active` | `assignment` | 执行中 | 派工责任处于“执行中”阶段时成立的业务状态。 | provisional |
| `assignment.paused` | `assignment` | 已暂停 | 派工责任处于“已暂停”阶段时成立的业务状态。 | provisional |
| `assignment.reassignment_requested` | `assignment` | 已请求重派 | 派工责任处于“已请求重派”阶段时成立的业务状态。 | provisional |
| `assignment.finished` | `assignment` | 已完成 | 派工责任处于“已完成”阶段时成立的业务状态。 | provisional |
| `assignment.cancelled` | `assignment` | 已取消 | 派工责任处于“已取消”阶段时成立的业务状态。 | provisional |

## Roles

| ID | Label | Meaning | Status |
|---|---|---|---|
| `scheduling_system` | 调度系统 | 生成候选与推荐，不承担人类批准责任。 | provisional |
| `dispatcher` | 调度员 | 确认、覆盖或取消派工决策。 | provisional |
| `supervisor` | 班组长 / 主管 | 处理资源、异常和高影响覆盖。 | provisional |
| `service_resource_actor` | 服务资源执行者 | 接受责任并反馈执行。 | provisional |
| `operations_manager` | 运营管理者 | 复盘策略与资源配置。 | provisional |

## Terms Not To Use

| Term | Reason | Preferred Term |
|---|---|---|
| `Asset / Facility` | 复合对象身份不清；本模型使用 MaintainableAsset 与 ServiceLocation。 | MaintainableAsset 与 ServiceLocation |
| `到达成本是 ServiceLocation 固有属性` | 到达成本依赖资源起点、时间和通行条件，应属于 DispatchCandidate 或关系上下文。 | DispatchCandidate.estimated_arrival_cost |
| `current_executor_id` | 技术字段，不是核心业务属性。 | 当前执行责任或 Assignment |
