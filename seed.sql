USE cleaning_mini;
INSERT INTO teams (team_id, team_name)
VALUES
(1, 'Đội Hà Nội 1'),
(2, 'Đội Hà Nội 2'),
(3, 'Đội Cầu Giấy'),
(4, 'Đội Long Biên'),
(5, 'Đội Hà Đông')
 ;
INSERT INTO workers (worker_id, full_name, worker_email, worker_skill, team_id)
VALUES
(1, 'Nguyễn Văn An',  'an.nguyen@cleaning.example',  'Vệ sinh tổng quát', 1),
(2, 'Trần Thị Bình',  'binh.tran@cleaning.example',  'Lau kính',          1),
(3, 'Lê Minh Cường',  'cuong.le@cleaning.example',   'Giặt thảm',         2),
(4, 'Phạm Thu Dung',  'dung.pham@cleaning.example',  'Vệ sinh bếp',       3),
(5, 'Hoàng Quốc Em',  'em.hoang@cleaning.example',   'Vệ sinh tổng quát', 4),
(6, 'Vũ Thị Phương',  'phuong.vu@cleaning.example',  'Vệ sinh sau xây dựng', 5)
;
INSERT INTO customers (customer_id, customer_name, phone_num, address)
VALUES
(1,  'Đỗ Thị Hoa',      '0900000001', '12 Ngõ 5, Cầu Giấy, Hà Nội'),
(2,  'Bùi Văn Khánh',   '0900000002', '45 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
(3,  'Ngô Thị Lan',     '0900000003', '8 Láng Hạ, Đống Đa, Hà Nội'),
(4,  'Đặng Văn Minh',   '0900000004', '21 Trần Duy Hưng, Cầu Giấy, Hà Nội'),
(5,  'Phan Thị Ngọc',   '0900000005', '33 Kim Mã, Ba Đình, Hà Nội'),
(6,  'Lý Văn Oanh',     '0900000006', '17 Ngọc Lâm, Long Biên, Hà Nội'),
(7,  'Trịnh Thị Quyên', '0900000007', '60 Văn Quán, Hà Đông, Hà Nội'),
(8,  'Mai Văn Sơn',     '0900000008', '5 Giảng Võ, Ba Đình, Hà Nội'),
(9,  'Chu Thị Thảo',    '0900000009', '90 Hoàng Quốc Việt, Cầu Giấy, Hà Nội'),   -- chưa có lịch nào
(10, 'Dương Văn Tuấn',  '0900000010', '27 Phố Huế, Hai Bà Trưng, Hà Nội')      -- có lịch sử, chưa thanh toán
;
INSERT INTO jobs (job_id, customer_id, worker_id, scheduled_at, job_status, service_address)
VALUES
(1,  1,  1, '2025-01-05 09:00:00', 'Completed', '12 Ngõ 5, Cầu Giấy, Hà Nội'),
(2,  2,  2, '2025-01-12 08:30:00', 'Completed', '45 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
(3,  3,  3, '2025-01-20 14:00:00', 'Completed', '8 Láng Hạ, Đống Đa, Hà Nội'),
(4,  1,  1, '2025-02-10 09:00:00', 'Completed', '12 Ngõ 5, Cầu Giấy, Hà Nội'),
(5,  4,  4, '2025-02-18 13:00:00', 'Cancelled', '21 Trần Duy Hưng, Cầu Giấy, Hà Nội'),
(6,  1,  2, '2025-03-08 10:00:00', 'Completed', '12 Ngõ 5, Cầu Giấy, Hà Nội'),
(7,  5,  3, '2025-03-22 15:00:00', 'Pending',   '33 Kim Mã, Ba Đình, Hà Nội'),
(8,  1,  1, '2025-06-14 09:30:00', 'Completed', '12 Ngõ 5, Cầu Giấy, Hà Nội'),
(9,  2,  4, '2025-09-03 08:00:00', 'Completed', '45 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
(10, 6,  5, '2025-11-15 10:00:00', 'Pending',   '17 Ngọc Lâm, Long Biên, Hà Nội'),
(11, 3,  3, '2024-12-20 09:00:00', 'Completed', '8 Láng Hạ, Đống Đa, Hà Nội'),
(12, 7,  5, '2024-10-05 11:00:00', 'Completed', '60 Văn Quán, Hà Đông, Hà Nội'),
(13, 8,  6, '2024-07-01 09:00:00', 'Cancelled', '5 Giảng Võ, Ba Đình, Hà Nội'),
(14, 2,  2, '2026-02-14 09:00:00', 'Completed', '45 Nguyễn Trãi, Thanh Xuân, Hà Nội'),
(15, 10, 1, '2025-01-28 16:00:00', 'Completed', '27 Phố Huế, Hai Bà Trưng, Hà Nội');

INSERT INTO acceptance_records (record_id, job_id, work_summary, area_m2, accepted_at, cost)
VALUES
(1,  1,  'Vệ sinh tổng quát căn hộ', 60.00,  '2025-01-05 12:00:00',  800000.00),
(2,  2,  'Lau kính và vệ sinh phòng khách', 40.00,  '2025-01-12 11:00:00',  500000.00),
(3,  3,  'Giặt thảm và vệ sinh sàn', 90.00,  '2025-01-20 18:00:00', 1200000.00),
(4,  4,  'Vệ sinh tổng quát định kỳ', 55.00,  '2025-02-10 12:30:00',  700000.00),
(5,  6,  'Vệ sinh bếp và nhà tắm', 70.00,  '2025-03-08 14:00:00',  900000.00),
(6,  8,  'Vệ sinh tổng quát định kỳ', 50.00,  '2025-06-14 12:30:00',  650000.00),
(7,  9,  'Vệ sinh bếp, hút bụi sofa', 80.00,  '2025-09-03 12:00:00', 1000000.00),
(8,  11, 'Giặt thảm cuối năm', 120.00,  '2024-12-20 15:00:00', 1500000.00),
(9,  12, 'Vệ sinh tổng quát nhà phố', 45.00,  '2024-10-05 14:00:00',  600000.00),
(10, 14, 'Lau kính và vệ sinh ban công', 65.00,  '2026-02-14 13:00:00',  850000.00),
(11, 15, 'Vệ sinh tổng quát căn hộ', 48.00,  '2025-01-28 19:00:00',  600000.00);
INSERT INTO payments (payment_id, job_id, amount, payment_date, method)
VALUES
(1,  1,  800000.00,  '2025-01-06', 'Cash'),
(2,  2,  200000.00,  '2025-01-13', 'BankTransfer'),
(3,  2,  300000.00,  '2025-02-01', 'BankTransfer'),
(4,  3,  700000.00,  '2025-01-21', 'Card'),
(5,  4,  700000.00,  '2025-02-11', 'Cash'),
(6,  6,  400000.00,  '2025-03-09', 'Card'),
(7,  6,  500000.00,  '2025-04-02', 'BankTransfer'),
(8,  8,  650000.00,  '2025-06-15', 'Cash'),
(9,  9,  500000.00,  '2025-09-04', 'Card'),
(10, 11, 1500000.00, '2024-12-21', 'BankTransfer'),
(11, 12, 600000.00,  '2024-10-06', 'Cash'),
(12, 14, 850000.00,  '2026-02-15', 'Card');

-- truy vấn quan hệ trạng thái với bản ghi kết quả:
-- truy vấn phần Completed có đúng một biên bản
SELECT j.job_id, COUNT(r.record_id) AS so_bien_ban
FROM jobs j LEFT JOIN acceptance_records r ON r.job_id = j.job_id
WHERE j.job_status = 'Completed'
GROUP BY j.job_id
HAVING COUNT(r.record_id) <> 1;
-- truy vấn phần chỉ Completed mới có biên bản
SELECT j.job_id, j.job_status, r.record_id
FROM jobs j JOIN acceptance_records r ON r.job_id = j.job_id
WHERE j.status <> 'Completed';
-- truy vấn phần chỉ thu tiền khi có chi phí xác nhận
SELECT p.payment_id, p.job_id
FROM payments p LEFT JOIN acceptance_records r ON r.job_id = p.job_id
WHERE r.record_id IS NULL;

-- truy vấn phần số tiền thu không vượt chi phí:
SELECT r.job_id, r.cost, SUM(p.amount) AS tong_da_thu
FROM acceptance_records r JOIN payments p ON p.job_id = r.job_id
GROUP BY r.job_id, r.cost
HAVING SUM(p.amount) > r.cost;

-- truy vấn vấn kiểm tra khóa ngoại:
SELECT w.worker_id, w.team_id
FROM workers w LEFT JOIN teams t ON t.team_id = w.team_id
WHERE t.team_id IS NULL;

SELECT j.job_id, j.customer_id
FROM jobs j LEFT JOIN customers c ON c.customer_id = j.customer_id
WHERE c.customer_id IS NULL;

SELECT j.job_id, j.worker_id
FROM jobs j LEFT JOIN workers w ON w.worker_id = j.worker_id
WHERE w.worker_id IS NULL;

SELECT r.record_id, r.job_id
FROM acceptance_records r LEFT JOIN jobs j ON j.job_id = r.job_id
WHERE j.job_id IS NULL;

SELECT p.payment_id, p.job_id
FROM payments p LEFT JOIN jobs j ON j.job_id = p.job_id
WHERE j.job_id IS NULL;