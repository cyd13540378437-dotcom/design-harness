# 17. UX Gap Candidate Creates Downstream Gap Trigger

Given: UX needs an “申请延期” action and the context pack has no corresponding confirmed or provisional action.

When: The action affects status, approval, responsibility, or audit.

Then: UX should create a `downstream_gap` Model Trigger, and Business Modeling should treat it as a candidate, not an automatic confirmed action.
