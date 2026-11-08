# Đề 09: Quản lý dịch vụ vệ sinh gia đình (`cleaning_mini`)
Học phần: Nhập môn Cơ sở dữ liệu — Introduction to Database **(EP16.TOKT11120(126)_01)**

Đơn vị: Khoa Khoa học Dữ liệu và Trí tuệ Nhân tạo **(FDA)** — Trường Công nghệ, Đại học Kinh tế Quốc dân **(NEU)**

Giảng viên hướng dẫn: Trần Đức Minh

Sinh viên, mã sinh viên:
- Mai Trung Kiên, **MSV**: 11254033
- Nguyễn Trịnh Anh Tuấn, **MSV**: 11258690
- Vũ Duy Mạnh, **MSV**: 11255235
## 1. Giới thiệu
Dự án này thiết kế và xây dựng cơ sở dữ liệu quan hệ cho một hệ thống quản lý dịch vụ vệ sinh gia đình. Hệ thống giúp theo dõi thông tin các đội vệ sinh, nhân viên phụ trách, yêu cầu đặt lịch của khách hàng, biên bản nghiệm thu sau khi hoàn thành, và quản lý các giao dịch thanh toán công nợ.
## 2. Mục tiêu dự án
- Thiết kế cơ sở dữ liệu quan hệ chuẩn hóa.
- Thực hành viết các câu lệnh DDL (Data Definition Language) và DML (Data Manipulation Language).
- Khai thác dữ liệu với các câu truy vấn phức tạp sử dụng `JOIN`, `GROUP BY`, `HAVING`.
- Xây dựng các `VIEW` để báo cáo chi tiết, thống kê hiệu suất theo đội và theo dõi công nợ khách hàng.
## 3. Cấu trúc CSDL (Database Schema)
Cơ sở dữ liệu `cleaning_mini` bao gồm 6 bảng chính được liên kết chặt chẽ với nhau qua các khóa ngoại (Foreign Keys):   
- `teams`: Quản lý thông tin các đội vệ sinh.   
- `workers`: Thông tin nhân viên phụ trách, trực thuộc các đội vệ sinh.   
- `customers`: Thông tin khách hàng đặt dịch vụ.
- `jobs`: Lịch sử đặt dịch vụ vệ sinh (bao gồm ngày hẹn, trạng thái hợp lệ: Pending, Completed, Cancelled, nhân viên phụ trách).   
- `acceptance_records`: Biên bản nghiệm thu công việc (chỉ lập khi lịch vệ sinh đạt trạng thái Completed).
- `payments`: Chi tiết các lần thanh toán của khách hàng (Cash, BankTransfer, Card).   
## 4. Cấu trúc thư mục mã nguồn
Dự án tuân thủ yêu cầu nộp bài với 4 tệp SQL riêng biệt, cần được thực thi theo đúng thứ tự sau:
1. `schema.sql`: Chứa các lệnh tạo cơ sở dữ liệu, tạo bảng, định nghĩa các ràng buộc khóa chính (PRIMARY KEY), khóa ngoại (FOREIGN KEY), và các ràng buộc dữ liệu (CHECK, UNIQUE, ENUM).
2. `seed.sql`: Chứa các lệnh INSERT để nạp dữ liệu mẫu và các câu truy vấn kiểm thử tính toàn vẹn của dữ liệu (kiểm tra khóa ngoại, ràng buộc trạng thái, không thu tiền vượt chi phí).
3. `queries.sql`: Bao gồm 10 câu truy vấn độc lập giải quyết các bài toán thống kê nghiệp vụ phức tạp (lọc theo khoảng thời gian, tính tỷ lệ hủy, xếp hạng nhân viên, tính công nợ).
4. `views.sql`: Chứa các lệnh tạo 3 View (`v_detail`, `v_group_summary`, `v_debt`) phục vụ mục đích tổng hợp dữ liệu và lập báo cáo nhanh.
## 5. Hướng dẫn cài đặt và sử dụng
### Yêu cầu hệ thống:
- MySQL Server (phiên bản 8.0 trở lên được khuyến nghị).
- MySQL Workbench, DBeaver, hoặc bất kỳ công cụ quản lý CSDL nào hỗ trợ chạy script SQL.

### Các bước thực thi:

Để hệ thống hoạt động chính xác và không bị lỗi tham chiếu khóa ngoại, vui lòng chạy các tệp theo đúng thứ tự sau trên một CSDL mới hoàn toàn:
1. Chạy toàn bộ lệnh trong `schema.sql` để khởi tạo cấu trúc.
2. Chạy toàn bộ lệnh trong `seed.sql` để nạp dữ liệu giả lập.
3. Mở `queries.sql` và bôi đen chạy từng câu truy vấn để xem kết quả thống kê tương ứng.
4. Chạy các lệnh trong `views.sql` để khởi tạo các bảng ảo báo cáo.
## 6. Công nghệ sử dụng
- Hệ quản trị CSDL: MySQL
- Ngôn ngữ: SQL (Structured Query Language)
