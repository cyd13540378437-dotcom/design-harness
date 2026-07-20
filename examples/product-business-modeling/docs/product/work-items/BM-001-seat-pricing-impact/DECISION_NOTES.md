# Business Modeling Decision Notes

## BMD-001 — Seat 是否为独立业务对象

### Context

计费方式已经 confirmed 为按 Seat 计费。

### Options Considered

- A：Seat 作为独立业务对象；
- B：Seat 作为 Member 的业务属性。

### Recommendation

推荐 A。

### Human Decision

Pending.

### Consequences

A 会让计费、邀请、成员占用、释放和审计更清晰，但会增加模型复杂度。

### Rejected Alternatives

Pending.

### Follow-up Updates

Pending.
