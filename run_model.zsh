#!/usr/bin/env zsh

model="${1:-qwen3.6:35b-mlx}"
(( $# > 0 )) && shift

exec ollama launch codex --model "$model" -- --disable apps "$@"
