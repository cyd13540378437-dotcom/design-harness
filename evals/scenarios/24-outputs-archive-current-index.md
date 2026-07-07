# 24. Outputs Archive Current Index

## Given

The user approves closing a UX or PD Work Item.

## When

The Steward seals the state.

## Then

- `docs/design/outputs/archive/<event_id>/` is created or updated with a summary and artifact manifest.
- `docs/design/outputs/index.yml` maps the archive entry to the source `STATE.md`.
- Only user-confirmed or project-adopted outputs enter `docs/design/outputs/current/`.
- Work-in-progress artifacts remain under `docs/design/work-items/<event-id-slug>/artifacts/`.

