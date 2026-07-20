# 27 — Runtime Adapter Does Not Own Core

## Given

A runtime adapter Skill contains a business modeling instruction that seems to conflict with `core/product-design/business-modeling/CAPABILITY.md`.

## When

The agent performs business modeling.

## Then

The Core wins. Runtime adapter files are treated as invocation wrappers only, and business model source of truth remains under `docs/product/**`.
