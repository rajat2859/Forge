#!/usr/bin/env bash
set -euo pipefail

forge_archive="https://github.com/rajat2859/Forge/archive/refs/heads/main.zip"
temporary_root="$(mktemp -d)"
archive_path="$temporary_root/forge.zip"
extract_path="$temporary_root/source"

cleanup() {
  rm -rf "$temporary_root"
}

trap cleanup EXIT

command_available() {
  command -v "$1" >/dev/null 2>&1
}

install_forge_skill() {
  local source_root="$1"
  local target_path="$2"
  local target_parent
  local staging_path
  local backup_path=""

  target_parent="$(dirname "$target_path")"
  staging_path="\${target_path}.staging-$$"

  mkdir -p "$target_parent"
  mkdir -p "$staging_path"

  cp "$source_root/SKILL.md" "$staging_path/SKILL.md"
  cp -R "$source_root/rules" "$staging_path/rules"
  cp "$source_root/VERSION" "$staging_path/VERSION"

  if [[ -e "$target_path" ]]; then
    backup_path="\${target_path}.backup-$(date +%Y%m%d-%H%M%S)"
    mv "$target_path" "$backup_path"
  fi

  if ! mv "$staging_path" "$target_path"; then
    if [[ -n "$backup_path" && -e "$backup_path" && ! -e "$target_path" ]]; then
      mv "$backup_path" "$target_path"
    fi
    return 1
  fi

  if [[ -n "$backup_path" ]]; then
    printf '%s\n' "$backup_path"
  fi
}

declare -a agent_names=()
declare -a agent_paths=()
declare -a agent_invocations=()

if command_available claude; then
  agent_names+=("Claude Code")
  agent_paths+=("$HOME/.claude/skills/forge")
  agent_invocations+=("/forge")
fi

if command_available agy; then
  agent_names+=("Antigravity CLI")
  agent_paths+=("$HOME/.gemini/antigravity-cli/skills/forge")
  agent_invocations+=("/forge")
fi

if command_available codex; then
  codex_home="\${CODEX_HOME:-$HOME/.codex}"
  agent_names+=("Codex")
  agent_paths+=("$codex_home/skills/forge")
  agent_invocations+=("\$forge")
fi

if command_available opencode; then
  agent_names+=("OpenCode")
  agent_paths+=("$HOME/.config/opencode/skills/forge")
  agent_invocations+=("/forge")
fi

if [[ "\${#agent_names[@]}" -eq 0 ]]; then
  printf '\nForge did not detect a supported coding-agent CLI in PATH.\n'
  printf 'Supported targets: claude, agy, codex, opencode.\n'
  printf 'Install or expose the desired CLI in PATH, then run this installer again.\n'
  exit 1
fi

printf '\nForge installer\n\nDetected:\n'
for agent_name in "\${agent_names[@]}"; do
  printf '  - %s\n' "$agent_name"
done

mkdir -p "$extract_path"

if command_available curl; then
  curl -fsSL "$forge_archive" -o "$archive_path"
elif command_available wget; then
  wget -q "$forge_archive" -O "$archive_path"
else
  printf 'Forge requires curl or wget to download the package.\n' >&2
  exit 1
fi

if command_available unzip; then
  unzip -q "$archive_path" -d "$extract_path"
else
  printf 'Forge requires unzip to extract the package.\n' >&2
  exit 1
fi

source_root="$extract_path/Forge-main"

if [[ ! -f "$source_root/SKILL.md" ]]; then
  printf 'Downloaded Forge package does not contain SKILL.md.\n' >&2
  exit 1
fi

forge_version="$(tr -d '\r\n' < "$source_root/VERSION")"

printf '\nInstalling Forge %s...\n' "$forge_version"

for index in "\${!agent_names[@]}"; do
  backup_path="$(install_forge_skill "$source_root" "\${agent_paths[$index]}")"
  printf '  [OK] %s -> %s\n' "\${agent_names[$index]}" "\${agent_paths[$index]}"

  if [[ -n "$backup_path" ]]; then
    printf '       Previous Forge installation backed up to %s\n' "$backup_path"
  fi
done

printf '\nForge %s installed.\n' "$forge_version"
printf 'Restart any open coding-agent sessions so they rediscover the skill.\n'
printf '\nInvoke Forge with:\n'

for index in "\${!agent_names[@]}"; do
  printf '  %s: %s\n' "\${agent_names[$index]}" "\${agent_invocations[$index]}"
done
