#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  scripts/install-agent-compat.sh <codex|claude|cursor> /path/to/target-project

Installs Design Harness files for the selected agent without deleting target files.

Examples:
  scripts/install-agent-compat.sh codex  ~/work/my-app
  scripts/install-agent-compat.sh claude ~/work/my-app
  scripts/install-agent-compat.sh cursor ~/work/my-app
USAGE
}

if [[ $# -ne 2 ]]; then
  usage
  exit 2
fi

agent="$1"
target_input="$2"
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ ! -d "$target_input" ]]; then
  echo "Target project does not exist: $target_input" >&2
  exit 1
fi

target="$(cd "$target_input" && pwd)"

copy_tree_update() {
  local src="$1"
  local dest="$2"
  mkdir -p "$dest"
  rsync -a "$src/" "$dest/"
}

copy_tree_missing_only() {
  local src="$1"
  local dest="$2"
  mkdir -p "$dest"
  rsync -a --ignore-existing "$src/" "$dest/"
}

copy_file_update() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
}

ensure_block() {
  local file="$1"
  local marker="$2"
  local fragment="$3"
  mkdir -p "$(dirname "$file")"
  touch "$file"
  if grep -Fq "<!-- BEGIN $marker -->" "$file"; then
    return
  fi
  {
    printf '\n<!-- BEGIN %s -->\n' "$marker"
    sed -n '1,$p' "$fragment"
    printf '\n<!-- END %s -->\n' "$marker"
  } >> "$file"
}

missing_count() {
  local src="$1"
  local dest="$2"
  local count=0
  local rel
  while IFS= read -r rel; do
    if [[ ! -e "$dest/${rel#./}" ]]; then
      count=$((count + 1))
    fi
  done < <(cd "$src" && find . -type f | sort)
  printf '%s' "$count"
}

require_file() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    echo "Missing required file after install: $file" >&2
    exit 1
  fi
}

install_project_docs() {
  copy_tree_missing_only "$root/templates/project/docs/design" "$target/docs/design"
}

verify_project_docs() {
  require_file "$target/docs/design/WORK_ITEMS.md"
  require_file "$target/docs/design/VISUAL_DESIGN.md"
  require_file "$target/docs/design/reference-library/product-index.yml"
  require_file "$target/docs/design/reference-library/pattern-index.yml"
  require_file "$target/docs/design/reference-library/assets/color-cards/palette-index.yml"
  require_file "$target/docs/design/work-items/REFERENCE_SELECTION.template.md"

  local missing
  missing="$(missing_count "$root/templates/project/docs/design" "$target/docs/design")"
  if [[ "$missing" != "0" ]]; then
    echo "Install warning: $missing template files are still missing under $target/docs/design" >&2
    exit 1
  fi
}

verify_skill_copy() {
  local dest="$1"
  require_file "$dest/SKILL.md"
  require_file "$dest/references/visual-workflow.md"
  require_file "$dest/references/reference-library-consumption.md"
  require_file "$dest/references/color-card-consumption.md"
  require_file "$dest/assets/visual-reference-packs/reference-index.md"

  local missing
  missing="$(missing_count "$root/skills/design-engineering" "$dest")"
  if [[ "$missing" != "0" ]]; then
    echo "Install warning: $missing skill files are still missing under $dest" >&2
    exit 1
  fi
}

install_codex() {
  local skill_dest="$HOME/.agents/skills/design-engineering"
  copy_tree_update "$root/skills/design-engineering" "$skill_dest"
  copy_file_update "$root/agents/design-state-steward.toml" "$target/.codex/agents/design-state-steward.toml"
  ensure_block "$target/AGENTS.md" "DESIGN-HARNESS" "$root/templates/project/AGENTS.fragment.md"
  install_project_docs
  verify_skill_copy "$skill_dest"
  verify_project_docs
}

install_claude() {
  local skill_dest="$HOME/.claude/skills/design-engineering"
  copy_tree_update "$root/skills/design-engineering" "$skill_dest"
  copy_file_update "$root/adapters/claude/agents/design-state-steward.md" "$target/.claude/agents/design-state-steward.md"
  ensure_block "$target/CLAUDE.md" "DESIGN-HARNESS" "$root/adapters/claude/CLAUDE.fragment.md"
  install_project_docs
  verify_skill_copy "$skill_dest"
  verify_project_docs
  require_file "$target/.claude/agents/design-state-steward.md"
}

install_cursor() {
  local skill_dest="$target/.cursor/design-harness/skills/design-engineering"
  copy_tree_update "$root/skills/design-engineering" "$skill_dest"
  copy_file_update "$root/adapters/cursor/agents/design-state-steward.md" "$target/.cursor/design-harness/agents/design-state-steward.md"
  copy_file_update "$root/adapters/cursor/rules/design-engineering.mdc" "$target/.cursor/rules/design-engineering.mdc"
  install_project_docs
  verify_skill_copy "$skill_dest"
  verify_project_docs
  require_file "$target/.cursor/rules/design-engineering.mdc"
  require_file "$target/.cursor/design-harness/agents/design-state-steward.md"
}

case "$agent" in
  codex)
    install_codex
    ;;
  claude)
    install_claude
    ;;
  cursor)
    install_cursor
    ;;
  *)
    usage
    exit 2
    ;;
esac

echo "Design Harness installed for $agent at $target"
