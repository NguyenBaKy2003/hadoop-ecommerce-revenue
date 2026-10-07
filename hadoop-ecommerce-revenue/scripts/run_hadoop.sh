#!/usr/bin/env bash
# Chạy trên môi trường Hadoop thật (vd. LabEx). Chạy từ thư mục gốc của project.
set -euo pipefail
BASE=/user/student/ecommerce
IN=$BASE/input
OUT=$BASE/output/revenue_by_category

JAR=$(find "${HADOOP_HOME:-/usr/local/hadoop}" -name 'hadoop-streaming*.jar' 2>/dev/null | head -1 || true)
[ -z "$JAR" ] && JAR=$(find / -name 'hadoop-streaming*.jar' 2>/dev/null | head -1)
echo "Streaming jar: $JAR"

# Bước 1: tạo thư mục + upload
hadoop fs -mkdir -p "$IN"
hadoop fs -put -f data/orders_2026_09.csv "$IN/"
hadoop fs -ls "$IN"
hadoop fs -cat "$IN/orders_2026_09.csv" | head -5

# Bước 3: chạy job (xóa output cũ vì Hadoop không cho ghi đè)
hadoop fs -rm -r -f "$OUT"
hadoop jar "$JAR" \
  -files src/mapper_revenue.py,src/reducer_revenue.py \
  -mapper  "python3 mapper_revenue.py" \
  -reducer "python3 reducer_revenue.py" \
  -input "$IN" -output "$OUT"

# Bước 4: kiểm tra + tải kết quả
hadoop fs -ls "$OUT"
hadoop fs -cat "$OUT/part-*"
hadoop fs -get -f "$OUT/part-*" ./result_revenue_by_category.txt
sort -k2 -nr result_revenue_by_category.txt | head -3
