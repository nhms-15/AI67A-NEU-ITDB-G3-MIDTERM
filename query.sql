USE cleaning_mini;

-- "1. Liệt kê các lịch vệ sinh Completed trong tháng 01/2025, kèm khách hàng, nhân viên phụ trách và ngày nghiệp vụ scheduled_at."
SELECT j.job_id, c.customer_id, c.customer_name, w.worker_id, w.full_name, j.scheduled_at
FROM jobs j
JOIN customers c ON j.customer_id = c.customer_id
JOIN workers w ON j.worker_id = w.worker_id
WHERE j.job_status = 'Completed' AND YEAR(j.scheduled_at) = 2025 AND MONTH(j.scheduled_at) = 1;

-- "2. Đếm tổng số lịch vệ sinh theo từng đội vệ sinh trong quý I/2025, tính mọi trạng thái; hiển thị cả nhóm có số lượng bằng 0."
SELECT t.team_id, t.team_name, COUNT(j.job_id) AS total_jobs
FROM teams t
LEFT JOIN workers w ON t.team_id = w.team_id
LEFT JOIN jobs j ON w.worker_id = j.worker_id AND YEAR(j.scheduled_at) = 2025 AND MONTH(j.scheduled_at) IN (1, 2, 3)
GROUP BY t.team_id, t.team_name;

-- "3. Liệt kê các khách hàng có ít nhất một lịch vệ sinh chưa có biên bản nghiệm thu, loại trừ Cancelled. Mỗi người chỉ xuất hiện một lần."
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers c
JOIN jobs j ON c.customer_id = j.customer_id
LEFT JOIN acceptance_records r ON j.job_id = r.job_id
WHERE j.job_status <> 'Cancelled' AND r.record_id IS NULL;

-- "4. Tính phí vệ sinh trung bình trên một giao dịch Completed của từng đội vệ sinh, xét toàn bộ thời gian; chỉ lấy nhóm đã phát sinh chi phí."
SELECT t.team_id, t.team_name, AVG(r.cost) AS avg_completed_cost
FROM teams t
JOIN workers w ON t.team_id = w.team_id
JOIN jobs j ON w.worker_id = j.worker_id
JOIN acceptance_records r ON j.job_id = r.job_id
WHERE j.job_status = 'Completed'
GROUP BY t.team_id, t.team_name;

-- "5. Liệt kê 3 nhân viên phụ trách có nhiều lịch vệ sinh Completed nhất trong năm 2025. Nếu bằng nhau, ưu tiên mã worker_id tăng dần; chỉ lấy đối tượng có giao dịch."
SELECT w.worker_id, w.full_name, COUNT(j.job_id) AS total_completed_jobs
FROM workers w
JOIN jobs j ON w.worker_id = j.worker_id
WHERE j.job_status = 'Completed' AND YEAR(j.scheduled_at) = 2025
GROUP BY w.worker_id, w.full_name
ORDER BY total_completed_jobs DESC, w.worker_id ASC
LIMIT 3;

-- "6. Tính tổng số tiền từng khách hàng đã thanh toán trong năm 2025 theo payment_date; hiển thị cả người chưa trả tiền với tổng bằng 0."
SELECT c.customer_id, c.customer_name, COALESCE(SUM(p.amount), 0) AS total_paid_2025
FROM customers c
LEFT JOIN jobs j ON c.customer_id = j.customer_id
LEFT JOIN payments p ON j.job_id = p.job_id AND YEAR(p.payment_date) = 2025
GROUP BY c.customer_id, c.customer_name;

-- "7. Liệt kê các khách hàng chưa có bất kỳ bản ghi thanh toán nào trong toàn bộ dữ liệu, kể cả người chưa có giao dịch."
SELECT customer_id, customer_name
FROM customers 
WHERE customer_id NOT IN (
    SELECT DISTINCT j.customer_id 
    FROM jobs j 
    JOIN payments p ON j.job_id = p.job_id
);

-- "8. Liệt kê toàn bộ khách hàng theo tổng phí vệ sinh đã xác nhận giảm dần, không phụ thuộc đã thanh toán hay chưa; nếu bằng nhau, sắp theo mã tăng dần."
SELECT c.customer_id, c.customer_name, COALESCE(SUM(r.cost), 0) AS total_confirmed_cost
FROM customers c
LEFT JOIN jobs j ON c.customer_id = j.customer_id
LEFT JOIN acceptance_records r ON j.job_id = r.job_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_confirmed_cost DESC, c.customer_id ASC;

-- "9. Tính tỷ lệ hủy của từng nhân viên phụ trách trong năm 2025: số lịch vệ sinh Cancelled chia tổng số lịch vệ sinh của năm, nhân 100. Làm tròn 2 chữ số thập phân; trả NULL nếu tổng bằng 0."
SELECT w.worker_id, w.full_name, ROUND((SUM(CASE WHEN j.job_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(j.job_id), 0)) * 100, 2) AS cancel_rate
FROM workers w
LEFT JOIN jobs j ON w.worker_id = j.worker_id AND YEAR(j.scheduled_at) = 2025
GROUP BY w.worker_id, w.full_name;

-- "10. Liệt kê các khách hàng có hơn 3 lịch vệ sinh Completed trong năm 2025, kèm số lần; sắp số lần giảm dần."
SELECT c.customer_id, c.customer_name, COUNT(j.job_id) AS completed_count
FROM customers c
JOIN jobs j ON c.customer_id = j.customer_id
WHERE j.job_status = 'Completed' AND YEAR(j.scheduled_at) = 2025
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(j.job_id) > 3
ORDER BY completed_count DESC;