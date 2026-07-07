#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  scripts/install-agent-compat.sh <codex|claude|cursor|doctor> /path/to/target-project

Installs Design Harness files for the selected agent without deleting target files.
Use doctor to inspect an existing project and report missing Design Harness files.

Examples:
  scripts/install-agent-compat.sh codex  ~/work/my-app
  scripts/install-agent-compat.sh claude ~/work/my-app
  scripts/install-agent-compat.sh cursor ~/work/my-app
  scripts/install-agent-compat.sh doctor ~/work/my-app
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

file_count() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    printf '0'
    return
  fi
  find "$dir" -type f | wc -l | tr -d ' '
}

print_summary() {
  local installed_agent="$1"
  echo
  echo "Installed surfaces:"
  echo "- Project state/templates: $target/docs/design ($(file_count "$target/docs/design") files)"
  case "$installed_agent" in
    codex)
      echo "- Codex project agent: $target/.codex/agents/design-state-steward.toml"
      echo "- Codex user skill: $HOME/.agents/skills/design-engineering ($(file_count "$HOME/.agents/skills/design-engineering") files)"
      ;;
    claude)
      echo "- Claude project agent: $target/.claude/agents/design-state-steward.md"
      echo "- Claude project rules: $target/CLAUDE.md"
      echo "- Claude user skill: $HOME/.claude/skills/design-engineering ($(file_count "$HOME/.claude/skills/design-engineering") files)"
      ;;
    cursor)
      echo "- Cursor rule: $target/.cursor/rules/design-engineering.mdc"
      echo "- Cursor steward rules: $target/.cursor/design-harness/agents/design-state-steward.md"
      echo "- Cursor vendored skill: $target/.cursor/design-harness/skills/design-engineering ($(file_count "$target/.cursor/design-harness/skills/design-engineering") files)"
      ;;
  esac
  echo
  echo "Note: .cursor/design-harness is only the Cursor adapter and vendored skill."
  echo "The project Work Items, Project Memory, Outputs, reference library, color cards, and visual baseline live under docs/design."
  echo "To inspect later, run: scripts/install-agent-compat.sh doctor \"$target\""
}

report_file() {
  local label="$1"
  local file="$2"
  if [[ -f "$file" ]]; then
    echo "OK      $label"
    return 0
  fi
  echo "MISSING $label -> $file"
  return 1
}

report_tree() {
  local label="$1"
  local src="$2"
  local dest="$3"
  local expected
  local actual
  local missing
  expected="$(file_count "$src")"
  actual="$(file_count "$dest")"
  if [[ ! -d "$dest" ]]; then
    echo "MISSING $label -> $dest (expected $expected files)"
    return 1
  fi
  missing="$(missing_count "$src" "$dest")"
  if [[ "$missing" == "0" ]]; then
    echo "OK      $label -> $dest ($actual files)"
    return 0
  fi
  echo "MISSING $label -> $dest ($missing of $expected expected files absent; $actual files present)"
  return 1
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
  require_file "$target/docs/design/project-memory/README.md"
  require_file "$target/docs/design/project-memory/PRODUCT_DESIGN.md"
  require_file "$target/docs/design/project-memory/DECISIONS.md"
  require_file "$target/docs/design/outputs/index.yml"
  require_file "$target/docs/design/outputs/current/index.yml"
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
  require_file "$dest/references/lifecycle-event-id.md"
  require_file "$dest/references/project-memory-and-artifacts.md"
  require_file "$dest/references/context-bound-final-review.md"
  require_file "$dest/references/product-design-events.md"
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
  copy_file_update "$root/adapters/cursor/README.md" "$target/.cursor/design-harness/README.md"
  copy_file_update "$root/adapters/cursor/rules/design-engineering.mdc" "$target/.cursor/rules/design-engineering.mdc"
  install_project_docs
  verify_skill_copy "$skill_dest"
  verify_project_docs
  require_file "$target/.cursor/rules/design-engineering.mdc"
  require_file "$target/.cursor/design-harness/agents/design-state-steward.md"
  require_file "$target/.cursor/design-harness/README.md"
}

doctor() {
  local failures=0
  echo "Design Harness doctor for: $target"
  echo
  report_tree "project docs/design template" "$root/templates/project/docs/design" "$target/docs/design" || failures=$((failures + 1))
  report_file "project WORK_ITEMS.md" "$target/docs/design/WORK_ITEMS.md" || failures=$((failures + 1))
  report_file "project VISUAL_DESIGN.md" "$target/docs/design/VISUAL_DESIGN.md" || failures=$((failures + 1))
  report_file "project Project Memory" "$target/docs/design/project-memory/README.md" || failures=$((failures + 1))
  report_file "project outputs index" "$target/docs/design/outputs/index.yml" || failures=$((failures + 1))
  report_file "project color-card registry" "$target/docs/design/reference-library/assets/color-cards/palette-index.yml" || failures=$((failures + 1))
  report_file "project reference-selection template" "$target/docs/design/work-items/REFERENCE_SELECTION.template.md" || failures=$((failures + 1))

  echo
  if [[ -d "$target/.cursor" ]]; then
    report_file "Cursor rule" "$target/.cursor/rules/design-engineering.mdc" || failures=$((failures + 1))
    report_file "Cursor steward rules" "$target/.cursor/design-harness/agents/design-state-steward.md" || failures=$((failures + 1))
    report_file "Cursor adapter README" "$target/.cursor/design-harness/README.md" || failures=$((failures + 1))
    report_tree "Cursor vendored skill" "$root/skills/design-engineering" "$target/.cursor/design-harness/skills/design-engineering" || failures=$((failures + 1))
  else
    echo "SKIP    Cursor adapter: $target/.cursor does not exist"
  fi

  if [[ -d "$target/.claude" || -f "$target/CLAUDE.md" ]]; then
    report_file "Claude project agent" "$target/.claude/agents/design-state-steward.md" || failures=$((failures + 1))
    report_file "Claude project rules" "$target/CLAUDE.md" || failures=$((failures + 1))
  else
    echo "SKIP    Claude project adapter not detected"
  fi

  if [[ -d "$target/.codex" || -f "$target/AGENTS.md" ]]; then
    report_file "Codex project agent" "$target/.codex/agents/design-state-steward.toml" || failures=$((failures + 1))
    report_file "Codex project rules" "$target/AGENTS.md" || failures=$((failures + 1))
  else
    echo "SKIP    Codex project adapter not detected"
  fi

  echo
  echo "Expected split:"
  echo "- .cursor/design-harness: Cursor adapter + vendored skill only"
  echo "- docs/design: Work Items, Project Memory, Outputs, VISUAL_DESIGN.md, Reference Library, Color Card Registry"

  if [[ "$failures" != "0" ]]; then
    echo
    echo "Doctor found $failures missing item(s). Re-run the installer for the agent you use."
    exit 1
  fi

  echo
  echo "Doctor found no missing required files."
}

case "$agent" in
  codex)
    install_codex
    print_summary codex
    ;;
  claude)
    install_claude
    print_summary claude
    ;;
  cursor)
    install_cursor
    print_summary cursor
    ;;
  doctor)
    doctor
    ;;
  *)
    usage
    exit 2
    ;;
esac

if [[ "$agent" != "doctor" ]]; then
  echo "Design Harness installed for $agent at $target"
fi
