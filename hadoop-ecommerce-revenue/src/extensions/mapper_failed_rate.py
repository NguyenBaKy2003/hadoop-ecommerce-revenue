#!/usr/bin/env python3
"""Mở rộng 2: tỷ lệ FAILED theo channel.
Mapper phát: channel <TAB> 1 (nếu FAILED) hoặc 0 (nếu không)."""
import sys, csv
for row in csv.DictReader(sys.stdin):
    print(f"{row['channel']}\t{1 if row.get('status') == 'FAILED' else 0}")
