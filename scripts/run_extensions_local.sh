#!/usr/bin/env bash
# Chạy 3 bài mở rộng + đo hiệu quả combiner trên máy local
set -euo pipefail
cd "$(dirname "$0")/.."
export LC_ALL=C
TAB="$(printf '\t')"
IN=data/orders_2026_09.csv; OUT=results/extensions; mkdir -p "$OUT"
python3 src/extensions/mapper_province.py < $IN | sort | python3 src/reducer_revenue.py \
  | sort -t "$TAB" -k2,2nr > $OUT/revenue_by_province.txt
python3 src/extensions/mapper_failed_rate.py < $IN | sort | python3 src/extensions/reducer_failed_rate.py > $OUT/failed_rate_by_channel.txt
python3 src/extensions/mapper_shipping.py < $IN | sort | python3 src/extensions/reducer_avg.py \
  | sort -t "$TAB" -k2,2n > $OUT/avg_shipping_by_province.txt
# Combiner: gộp cục bộ ở phía mapper trước khi shuffle (dùng lại reducer vì phép cộng có tính kết hợp)
RAW=$(python3 src/mapper_revenue.py < $IN | wc -l)
COMB=$(python3 src/mapper_revenue.py < $IN | sort | python3 src/reducer_revenue.py | wc -l)
printf "Không combiner: %s dòng qua shuffle\nCó combiner:    %s dòng qua shuffle\n" "$RAW" "$COMB" > $OUT/combiner_effect.txt
for f in $OUT/*.txt; do echo "== $f =="; cat "$f"; echo; done
