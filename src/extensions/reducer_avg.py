#!/usr/bin/env python3
"""Reducer tính trung bình theo key. Output: key <TAB> avg <TAB> count.
Lưu ý: reducer này KHÔNG dùng làm combiner được (trung bình của trung bình sai);
muốn combiner phải truyền (sum, count)."""
import sys
cur, s, n = None, 0, 0
for line in sys.stdin:
    key, val = line.rstrip("\n").split("\t")
    if key != cur:
        if cur is not None:
            print(f"{cur}\t{s / n:.2f}\t{n}")
        cur, s, n = key, 0, 0
    s += int(val); n += 1
if cur is not None:
    print(f"{cur}\t{s / n:.2f}\t{n}")
