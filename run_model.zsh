#!/usr/bin/env zsh

set -eu

script_version="1.1.0"
program_name="${0:t}"

usage() {
  print -u2 "Usage: $program_name --model MODEL [--context-window SIZE] [--auto-compact-percent PERCENT]"
  print -u2 "Example: $program_name --model qwen3.6:35b-mlx --context-window 256K --auto-compact-percent 87%"
}

model=""
runner="codex"
context_size="128K"
compact_input="85%"

while (( $# > 0 )); do
  case "$1" in
     --model|--runner|--context-window|--auto-compact-percent)
      if (( $# < 2 )); then
        print -u2 "Error: $1 requires a value."
        usage
        exit 2
      fi

      option="$1"
      value="$2"
      case "$option" in
         --model) model="$value" ;;
         --runner) runner="$value" ;;
         --context-window) context_size="${value:u}" ;;
         --auto-compact-percent) compact_input="$value" ;;
      esac
      shift 2
       ;;
     -h|--help)
      usage
      exit 0
       ;;
     --version)
      print "$program_name version $script_version"
      exit 0
       ;;
     *)
      print -u2 "Error: unknown argument: $1"
      usage
      exit 2
       ;;
  esac
done

compact_percent="${compact_input%%%}"

if [[ -z "$model" ]]; then
  print -u2 "Error: --model is required and must not be empty."
  usage
  exit 2
fi

if [[ "$context_size" =~ '^([1-9][0-9]*)K$' ]]; then
  context_window=$(( match[1] * 1024 ))
else
  print -u2 "Error: --context-window must use K notation, such as 128K."
  exit 2
fi

if [[ "$compact_input" != *% || "$compact_percent" != <-> ]] ||
   (( compact_percent < 1 || compact_percent > 99 )); then
  print -u2 "Error: --auto-compact-percent must be an integer from 1% to 99%."
  exit 2
fi

auto_compact_limit=$(( (context_window * compact_percent + 50) / 100 ))

command -v ollama || { print -u2 "Error: ollama is not installed or not in PATH."; exit 1; }

exec ollama launch "$runner" --model "$model" -- \
   --disable apps \
   -c "model_context_window=$context_window" \
   -c "model_auto_compact_token_limit=$auto_compact_limit"
