#!/usr/bin/env zsh

model="${1:-qwen3.6:35b-mlx}"
context_window="${2:-262144}"
auto_compact_limit="${3:-229376}"

(( $# > 0 )) && shift
(( $# > 0 )) && shift
(( $# > 0 )) && shift

exec ollama launch codex --model "$model" -- \
  --disable apps \
  -c "model_context_window=$context_window" \
  -c "model_auto_compact_token_limit=$auto_compact_limit" \
  "$@"
