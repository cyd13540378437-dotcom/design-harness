# State Lifecycle Model

> Each lifecycle belongs to exactly one business object. All object, state and action references use stable IDs from the business dictionary and action catalog.

## Object State Catalog

| Object ID | State ID | State Label | Meaning | Status |
|---|---|---|---|---|

## State Transitions

| Object ID | From State ID | Trigger Action ID | To State ID | Conditions | Status |
|---|---|---|---|---|---|

## Cross-object Materialization

When an action on one object creates another object, keep the lifecycles separate and describe the link here.

| Source Object ID | Trigger Action ID | Created Object ID | Initial State ID | Meaning |
|---|---|---|---|---|

Example boundary:

```text
Dispatch Decision: recommended → confirmed / overridden / rejected
Commit Dispatch Decision action creates Assignment
Assignment: created → notified → accepted → active → finished
```

Do not place `recommended` or `confirmed` inside the Assignment lifecycle merely because a confirmed decision later creates an Assignment.

## Missing Transition Actions

## Cross-object Lifecycle Mixing Issues

## Human Decisions Required
