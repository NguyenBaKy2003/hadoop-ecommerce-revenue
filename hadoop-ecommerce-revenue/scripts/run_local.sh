#!/usr/bin/env bash
# Mô phỏng Hadoop Streaming trên máy local: cat | mapper | sort | reducer
set -euo pipefail
cd "$(dirname "$0")/.."
export LC_ALL=C
TAB="$(printf '\t')"
mkdir -p results
python3 src/mapper_revenue.py < data/orders_2026_09.csv \
  | sort \
  | python3 src/reducer_revenue.py > results/result_revenue_by_category.txt
echo "== Doanh thu theo category =="; cat results/result_revenue_by_category.txt
sort -t "$TAB" -k2,2nr results/result_revenue_by_category.txt | head -3 > results/top3.txt
echo; echo "== Top 3 =="; cat results/top3.txt
