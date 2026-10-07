#!/usr/bin/env python3
"""Đối chiếu kết quả MapReduce với Pandas (mở rộng #5).
Chạy: python3 tests/verify_with_pandas.py   (cần chạy scripts/run_local.sh trước)"""
import pandas as pd, sys
df = pd.read_csv("data/orders_2026_09.csv")
expected = df[df.status == "SUCCESS"].groupby("category").amount.sum().to_dict()
got = {}
for line in open("results/result_revenue_by_category.txt"):
    k, v = line.rstrip("\n").split("\t"); got[k] = int(v)
if got == expected:
    print(f"OK: MapReduce == Pandas ({len(got)} category, tổng {sum(got.values()):,})")
else:
    print("KHÁC NHAU!")
    for k in set(got) | set(expected):
        if got.get(k) != expected.get(k): print(k, got.get(k), expected.get(k))
    sys.exit(1)
