# Module Overview Definition Protocol

Chinese version: [module-overview-definition.zh-CN.md](module-overview-definition.zh-CN.md)

## 1. Purpose

A module overview is the stable delivery export for one DesignHarnessAgent capability.

It solves the reading and decision experience for that capability without replacing
its source of truth:

```text
module source assets = authoritative facts, state, evidence, and audit trail
module overview = current user-facing compiled view
project delivery = cross-module composition of module overviews
```

The overview pattern is a reusable summarization skill: identify the audience,
preserve ownership boundaries, compile only from authoritative inputs, expose
open decisions, and keep every summary traceable.

## 2. Standard Module Output Skeleton

Module directories do not need identical file names, but they must expose the
same structural slots. In new projects, every delivery-participating module
should live under its own module root:

```text
<module-root>/
  README.md                 # module responsibility, boundaries, and default entry
  <MODULE_INDEX>.yml         # machine index; may mirror delivery_exports
  <MODULE_INDEX>.md          # maintainer navigation
  <MODULE_WORK_ITEMS>.md     # Work Item navigation index
  <MODULE_OVERVIEW>.md       # default module overview
  DELIVERY_EXPORTS.yml       # thin export declaration consumed by project delivery
  work-items/                # module-owned process assets
  outputs/                   # current display outputs and archive, when useful
  references/                # reference materials, when useful
  <module-domain-assets>/     # domain-specific assets with domain-specific names
```

The shared contract is the outer slot responsibility, not identical domain asset
names. Business Analysis can keep `decision-cases/`; Business Modeling can keep
`domain-objects/`, `rules/`, and `states/`; Design Engineering can keep
`project-memory/`, `reference-library/`, and `outputs/current/`.

Current canonical module roots:

```text
Business Analysis  -> docs/product/business-analysis/
Business Modeling  -> docs/product/business-modeling/
Design Engineering -> docs/design/
```

New runs must not place module Work Items in sibling module directories or shared
`docs/product/work-items/`. When reading legacy projects, legacy paths are
migration inputs only; the next persistent write should migrate or map them back
to the module-root structure.

## 3. Contract

Every capability that wants to participate in project-level delivery should define
one default module overview with:

```yaml
view_type: <module>_overview
audience: product_owner
is_default_module_delivery_view: true
is_project_delivery_entry: false
is_source_of_truth: false
generated_by: <module-owned compiler or orchestrator>
source_assets: []
open_questions_source: []
```

The module owns this contract. The project delivery layer consumes it; it does not
hard-code internal Work Item paths or decide which module files are exportable.

The same contract should be exposed in the target project's module index when a
module already has one:

```text
Business Modeling  -> docs/product/business-modeling/BUSINESS_MODEL_INDEX.yml
Business Analysis  -> docs/product/business-analysis/BUSINESS_ANALYSIS_INDEX.yml
Design Engineering -> docs/design/DELIVERY_EXPORTS.yml
```

These project-side export declarations are intentionally thin. They point to the
module overview, source-of-truth roots, open-question source, and exportable
sections; they do not duplicate the overview content.

## 4. Required Sections

Each module overview must let a non-specialist user understand:

1. what this module currently says;
2. what is confirmed, provisional, stale, or blocked;
3. what changed most recently;
4. what the user needs to decide or answer;
5. what downstream work can safely use;
6. where the authoritative source files live;
7. when the overview must be regenerated.

If there are pending decisions, the overview must include enough context for the
user to reply without opening audit files.

## 5. Compilation Rules

- Compile from module-owned source-of-truth files and module-owned Work Item records.
- Do not compile from project delivery files back into module truth.
- Do not promote draft or unapproved Work Item material into a current overview.
- Mark stale or partial overviews honestly instead of hiding missing inputs.
- Keep source paths explicit enough for `docs/project-delivery/current/SOURCE_MAP.yml`.

## 6. Project Delivery Relationship

`docs/project-delivery/` should only consume module overviews and their declared
export metadata.

It may combine, quote, link, and reorder module overview content for a project
homepage, but it must not:

- become a new source of truth;
- infer hidden module state;
- bypass a module's human-decision or completion gates;
- decide that an internal file is user-facing unless the module export contract says so.

## 7. How to Use This Method

When adding or updating a module overview:

1. Identify the module's source-of-truth roots and current user-facing pain point.
2. Define one default module overview path owned by that module.
3. Write a module-specific overview protocol that states purpose, path, owner, inputs, required sections, regeneration timing, freshness rules, and source-map expectations.
4. Add a template for the overview to the module assets and project template.
5. Add `delivery_exports` metadata to the module manifest, project-side module index, or `DELIVERY_EXPORTS.yml`.
6. Update the module runtime instructions so normal completion refreshes the overview when module state changes.
7. Let `docs/project-delivery/` consume only the overview and `delivery_exports` metadata.

Do not start by editing `docs/project-delivery/`. If the module has not declared
its export contract yet, project delivery has no stable interface to consume.
