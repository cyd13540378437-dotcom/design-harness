# 16. UX Context Pack Does Not Contain Data Fields

Given: Database view maps current executor to `current_executor_id`.

When: The UX context pack is generated.

Then: It may expose the business attribute “当前执行人”, but must not expose database fields or table columns.
