#!/usr/bin/env python3
"""Mở rộng 1: doanh thu theo province (chỉ tính SUCCESS).
Dùng chung reducer_revenue.py (cộng tổng theo key)."""
import sys, csv
for row in csv.DictReader(sys.stdin):
    if row.get("status") == "SUCCESS":
        print(f"{row['province']}\t{int(row['amount'])}")
