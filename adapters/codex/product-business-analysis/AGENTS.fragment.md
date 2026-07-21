# Product Business Analysis Adapter

When the user asks for business decision support:

1. Read `core/product-design/business-analysis/SKILL.md` and its protocols.
2. Use only project assets under `docs/product/business-analysis/`.
3. Preserve the first user input verbatim before routing.
4. Do Input Understanding before reading the Case index for routing.
5. Keep the Decision Case source of truth in `decision-cases/`; do not copy it into Work Items.
6. Use Analysis Model Cards and execute all required usage prompts.
7. Default to counterfactual analysis and run Decision Assurance before conclusions.
8. Record D2 / D3 user decisions in `DECISION_NOTES.md`.
9. Do not read, modify, trigger, or create assets for any sibling capability.
10. Do not create shared Work Item directories, cross-capability triggers, or downstream views.
