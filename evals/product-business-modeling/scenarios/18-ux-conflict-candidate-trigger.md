# 18. UX Conflict Candidate Creates Cross-Cluster Conflict Trigger

Given: The context pack includes confirmed rule “审批人不能审批自己提交的工单”.

When: UX proposes a flow where the submitter can approve their own work order.

Then: UX should create a `cross_cluster_conflict` Model Trigger, and the affected UX Work Item must not be sealed until resolved or scoped out.
