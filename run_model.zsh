#!/usr/bin/env zsh

set -euo pipefail

script_version="1.1.0"
program_name="${0:t}"

usage() {
  print -u2 "Usage: $program_name --model MODEL [--runner RUNNER] \
[--context-window SIZEK] [--auto-compact-percent PERCENT]"
  print -u2 "Examples:"
  print -u2 "  $program_name --model qwen3.6:35b-mlx"
  print -u2 "  $program_name --model qwen3.6:35b-mlx --context-window 256K --auto-compact-percent 87%"
}

# Defaults
model=""
runner="codex"
context_size="128K"
compact_percent=85

while (( $# > 0 )); do
  case "$1" in
    --model)
      [[ $# -ge 2 ]] || { print -u2 "Error: $1 requires a value."; exit 2; }
      model="$2"; shift 2 ;;
    --runner)
      [[ $# -ge 2 ]] || { print -u2 "Error: $1 requires a value."; exit 2; }
      runner="$2"; shift 2 ;;
    --context-window)
      [[ $# -ge 2 ]] || { print -u2 "Error: $1 requires a value."; exit 2; }
      context_size="$2"
      if [[ ! "$context_size" =~ ^[1-9]+[Kk]$ ]]; then
        print -u2 "Error: --context-window must be like 128K. Got '$context_size'."
        exit 2
      fi
      shift 2 ;;
    --auto-compact-percent)
      [[ $# -ge 2 ]] || { print -u2 "Error: $1 requires a value."; exit 2; }
      val="${2}"
      # Remove % sign if present, then validate as integer 1-99
      val="${val//%/}"
      if [[ ! "$val" =~ ^[0-9]+$ ]] || (( val < 1 || val > 99 )); then
        print -u2 "Error: --auto-compact-percent must be an integer from 1 to 99. Got '$2'."
        exit 2
      fi
      compact_percent="$val"
      shift 2 ;;
    -h|--help)
      usage; exit 0 ;;
    --version)
      print "v$script_version"; exit 0 ;;
    *)
      print -u2 "Error: Unknown argument: $1"; usage; exit 2 ;;
  esac
done

# Validate model required
[[ -n "$model" ]] || { print -u2 "Error: --model is required and must not be empty."; usage; exit 2; }

# Calculate context window in tokens
context_window="${context_size%[Kk]}" # Strip K/k suffix
context_window=$(( context_window * 1024 ))

# Calculate auto compact limit
auto_compact_limit=$(( (context_window * compact_percent + 50) / 100 ))

# Check for ollama
if ! command -v ollama >/dev/null; then
  print -u2 "Error: ollama is not installed or not in PATH."
  print -u2 "Install it via brew: brew install ollama"
  exit 1
fi

exec ollama launch "$runner" --model "$model" -- \
    --disable apps \
    -c "model_context_window=$context_window" \
    -c "model_auto_compact_token_limit=$auto_compact_limit"
