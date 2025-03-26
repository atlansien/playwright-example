#!/bin/bash

# タスク名を引数から取得
TASK_NAME="$1"
if [ -z "$TASK_NAME" ]; then
  TASK_NAME="Unknown Task"
fi

# 現在のメモリ使用状況を取得
get_memory_usage() {
  echo "=== Memory Usage for: $TASK_NAME ==="
  echo "--- Time: $(date '+%Y-%m-%d %H:%M:%S') ---"
  
  # free コマンドでメモリ使用量を取得
  echo "== System Memory (free) =="
  free -h
  
  # プロセスのメモリ使用量
  echo "== Top Memory Processes =="
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 10
  
  # 総メモリ使用量と使用率
  total_mem=$(free | grep Mem | awk '{print $2}')
  used_mem=$(free | grep Mem | awk '{print $3}')
  used_percent=$(awk "BEGIN {printf \"%.2f\", ($used_mem/$total_mem)*100}")
  
  echo "== Summary =="
  echo "Total Memory: $((total_mem/1024)) MB"
  echo "Used Memory: $((used_mem/1024)) MB"
  echo "Memory Usage: ${used_percent}%"
  echo "=================================="
}

# メモリ使用状況を出力
get_memory_usage 