#!/usr/bin/env python3
"""Mở rộng 3: số ngày giao hàng trung bình theo province (đơn SUCCESS).
Mapper phát: province <TAB> shipping_days"""
import sys, csv
for row in csv.DictReader(sys.stdin):
    if row.get("status") == "SUCCESS":
        print(f"{row['province']}\t{int(row['shipping_days'])}")
