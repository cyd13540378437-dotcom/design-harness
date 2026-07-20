# 15. UX Context Pack is a Derived View

Given: Business model source assets contain confirmed objects and actions.

When: The downstream-view-compiler generates `ux-business-model-context.*`.

Then: The context pack includes status and source references, and explicitly marks `is_source_of_truth: false`.
