# Nội dung nộp bài – MSSV_HoTen_HadoopLab

1. **Ảnh tạo thư mục HDFS + upload:** `docs/screenshots/01_hdfs_upload.png` (lệnh `hadoop fs -mkdir -p`, `hadoop fs -put`)
2. **Ảnh xem dữ liệu:** `docs/screenshots/02_hdfs_view.png` (`hadoop fs -ls`, `hadoop fs -cat ... | head`)
3. **Kết quả MapReduce:** `results/result_revenue_by_category.txt` (và ảnh `03_mapreduce_result.png`)
4. **Top 3 + nhận xét:** xem README.md, mục "Thành quả"
5. **Mô tả ngắn:** Mapper đọc từng dòng CSV, nếu `status = SUCCESS` thì phát sinh cặp key-value `category → amount`. Reducer nhận các cặp đã được gom và sắp xếp theo category, cộng tổng amount của từng category và ghi ra `category<TAB>tổng doanh thu`.
