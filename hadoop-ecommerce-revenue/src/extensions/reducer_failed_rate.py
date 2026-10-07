#!/usr/bin/env python3
"""Reducer cho tỷ lệ FAILED: đếm tổng đơn và số đơn FAILED theo key.
Output: channel <TAB> failed <TAB> total <TAB> rate(%)"""
import sys
def emit(k, failed, total):
    print(f"{k}\t{failed}\t{total}\t{failed / total * 100:.2f}")
cur, failed, total = None, 0, 0
for line in sys.stdin:
    key, val = line.rstrip("\n").split("\t")
    if key != cur:
        if cur is not None:
            emit(cur, failed, total)
        cur, failed, total = key, 0, 0
    failed += int(val)
    total += 1
if cur is not None:
    emit(cur, failed, total)
