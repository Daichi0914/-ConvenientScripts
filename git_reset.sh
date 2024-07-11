#!/bin/bash

if [ $# -eq 0 ]; then
  git reset
else
  local cmd="git status -s | awk '{print \$2}'"
  for arg in "$@"; do
    cmd="$cmd | grep '$arg'"
  done
  eval "$cmd | xargs git reset"
fi

git status

