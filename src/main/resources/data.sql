-- =====================================================
-- Sample Data for RecruitPro Recruitment System
-- Database: recruitment_db
-- =====================================================

-- Clear existing data (in correct order due to foreign keys)
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM notifications;
DELETE FROM interviews;
DELETE FROM applications;
DELETE FROM job_skills;
DELETE FROM job_postings;
DELETE FROM candidate_profiles;
DELETE FROM companies;
DELETE FROM users;
DELETE FROM job_fields;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- JOB FIELDS (Ngành nghề)
-- =====================================================
INSERT INTO job_fields (id, name, description, created_at, updated_at) VALUES
(1, 'Công nghệ thông tin', 'Phần mềm, IT, viễn thông, an ninh mạng', NOW(), NOW()),
(2, 'Kế toán - Tài chính', 'Kế toán, kiểm toán, tài chính, ngân hàng', NOW(), NOW()),
(3, 'Marketing - Quảng cáo', 'Marketing, digital marketing, PR, quảng cáo', NOW(), NOW()),
(4, 'Kinh doanh - Bán hàng', 'Kinh doanh, bán hàng, chăm sóc khách hàng', NOW(), NOW()),
(5, 'Thực phẩm - Đồ uống', 'Sản xuất, chế biến, kiểm soát chất lượng thực phẩm', NOW(), NOW()),
(6, 'Nhân sự - Hành chính', 'Nhân sự, hành chính, văn phòng', NOW(), NOW()),
(7, 'Kỹ thuật - Cơ khí', 'Kỹ thuật, cơ khí, điện, điện tử', NOW(), NOW()),
(8, 'Giáo dục - Đào tạo', 'Giáo dục, đào tạo, nghiên cứu', NOW(), NOW()),
(9, 'Y tế - Dược phẩm', 'Y tế, dược phẩm, chăm sóc sức khỏe', NOW(), NOW()),
(10, 'Thiết kế - Sáng tạo', 'Thiết kế đồ họa, nội thất, thời trang', NOW(), NOW()),
(11, 'Khoa học - Nghiên cứu', 'Nghiên cứu, khoa học, phát triển sản phẩm', NOW(), NOW()),
(12, 'Logistics - Vận tải', 'Kho vận, vận tải, xuất nhập khẩu', NOW(), NOW()),
(13, 'Bất động sản - Xây dựng', 'Bất động sản, xây dựng, kiến trúc', NOW(), NOW()),
(14, 'Du lịch - Khách sạn', 'Du lịch, khách sạn, nhà hàng', NOW(), NOW()),
(15, 'Pháp luật - Luật', 'Pháp luật, tư vấn pháp lý, thương mại', NOW(), NOW());

-- =====================================================
-- USERS
-- =====================================================
INSERT INTO users (id, email, password, role, is_active, created_at, updated_at) VALUES
(1, 'recruiter@techviet.com', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'RECRUITER', true, NOW(), NOW()),
(2, 'recruiter2@techviet.com', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'RECRUITER', true, NOW(), NOW()),
(3, 'candidate@email.com', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'CANDIDATE', true, NOW(), NOW()),
(4, 'candidate2@email.com', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'CANDIDATE', true, NOW(), NOW()),
(5, 'candidate3@email.com', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'CANDIDATE', true, NOW(), NOW()),
(6, 'admin@recruitpro.com', '$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW', 'ADMIN', true, NOW(), NOW());

-- Note: Password for all users is 'password123' (BCrypt hashed)

-- =====================================================
-- COMPANIES
-- =====================================================
INSERT INTO companies (id, user_id, name, logo_url, website, industry, company_size, description) VALUES
(1, 1, 'TechViet Solutions', 'https://ui-avatars.com/api/?name=TV&background=0D8ABC&color=fff&size=150', 'https://techviet.com.vn', 'Công nghệ thông tin', '201-500', 
'TechViet Solutions là công ty hàng đầu về phát triển phần mềm và giải pháp công nghệ tại Việt Nam.'),
(2, 2, 'GreenLife Foods', 'https://ui-avatars.com/api/?name=GL&background=28a745&color=fff&size=150', 'https://greenlifefoods.vn', 'Thực phẩm & Đồ uống', '51-200',
'GreenLife Foods chuyên sản xuất và phân phối các sản phẩm thực phẩm sạch, hữu cơ.');

-- =====================================================
-- CANDIDATE PROFILES
-- =====================================================
INSERT INTO candidate_profiles (id, user_id, full_name, headline, phone, avatar_url, date_of_birth, gender, address, summary) VALUES
(1, 3, 'Nguyễn Văn Minh', 'Senior Java Developer', '0901234567', 'https://ui-avatars.com/api/?name=Nguyen+Van+Minh&background=6f42c1&color=fff&size=150', '1995-03-15', 'Nam', 'TP. Hồ Chí Minh',
'5 năm kinh nghiệm phát triển Java. Kỹ năng Java Spring Boot, Hibernate, Microservices.'),
(2, 4, 'Trần Thị Lan', 'Frontend Developer', '0912345678', 'https://ui-avatars.com/api/?name=Tran+Thi+Lan&background=fd7e14&color=fff&size=150', '1997-07-22', 'Nữ', 'Hà Nội',
'3 năm kinh nghiệm phát triển Frontend. Chuyên về ReactJS, Vue.js, TypeScript.'),
(3, 5, 'Lê Hoàng Nam', 'Full Stack Developer', '0923456789', 'https://ui-avatars.com/api/?name=Le+Hoang+Nam&background=20c997&color=fff&size=150', '1996-11-08', 'Nam', 'Đà Nẵng',
'4 năm kinh nghiệm Full Stack. Kỹ năng Node.js, React, MongoDB, PostgreSQL.');

-- =====================================================
-- JOB POSTINGS
-- =====================================================
INSERT INTO job_postings (id, company_id, job_field_id, title, description, requirements, location, salary_min, salary_max, job_type, status, expired_at, created_at) VALUES
(1, 1, 1, 'Senior Java Developer', 'Tuyển Senior Java Developer cho dự án khách hàng Nhật Bản. Tham gia phát triển các giải pháp Enterprise sử dụng Java Spring Boot, microservices architecture. Làm việc trong môi trường Agile/Scrum với đội ngũ chuyên nghiệp.', '5 năm kinh nghiệm Java, Spring Boot, Hibernate, Microservices. Có kinh nghiệm với Kubernetes, Docker, CI/CD.', 'TP. Hồ Chí Minh', 15000000, 25000000, 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 30 DAY), NOW()),
(2, 1, 1, 'Frontend Developer (ReactJS)', 'Tuyển Frontend Developer có kinh nghiệm ReactJS. Phát triển giao diện người dùng cho các ứng dụng web hiện đại. Làm việc chặt chẽ với team Backend và UI/UX Designer.', '2 năm kinh nghiệm ReactJS, HTML, CSS, JavaScript. Biết TypeScript là lợi thế.', 'TP. Hồ Chí Minh', 10000000, 18000000, 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 25 DAY), NOW()),
(3, 1, 1, 'Backend Developer (Node.js)', 'Phát triển API và dịch vụ server cho nền tảng recruitment. Xây dựng các microservice bằng Node.js, Express, MongoDB. Tối ưu hóa hiệu suất và mở rộng hệ thống.', '3 năm kinh nghiệm Node.js, Express, MongoDB. Có kinh nghiệm với Redis, RabbitMQ.', 'TP. Hồ Chí Minh', 12000000, 20000000, 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 20 DAY), NOW()),
(4, 2, 3, 'Nhân viên Marketing', 'Phát triển chiến lược marketing digital. Quản lý các chiến dịch quảng cáo trên Facebook Ads, Google Ads. Phân tích dữ liệu và tối ưu hóa chiến dịch.', '2 năm kinh nghiệm marketing, Facebook Ads, Google Ads. Biết SEO là lợi thế.', 'Hà Nội', 8000000, 15000000, 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 15 DAY), NOW()),
(5, 2, 2, 'Kế toán viên', 'Quản lý hồ sơ kế toán, lập báo cáo tài chính. Thực hiện các nghiệp vụ kế toán theo quy định. Phối hợp với kiểm toán nội bộ và bên ngoài.', 'Tốt nghiệp ĐH Kế toán, kinh nghiệm MISA, Fast. Có chứng chỉ CPA là lợi thế.', 'Hà Nội', 7000000, 12000000, 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 20 DAY), NOW());

-- =====================================================
-- APPLICATIONS
-- =====================================================
INSERT INTO applications (id, candidate_id, job_id, cover_letter, status, applied_at) VALUES
(1, 1, 1, 'Tôi rất quan tâm đến vị trí Senior Java Developer tại TechViet Solutions. Với 5 năm kinh nghiệm trong lĩnh vực này, tôi tin rằng mình có thể đóng góp tích cực cho đội ngũ.', 'APPLIED', NOW()),
(2, 2, 2, 'Tôi muốn ứng tuyển vị trí Frontend Developer tại TechViet. Tôi đã làm việc với ReactJS trong 3 năm qua và rất hứng thú với các dự án của công ty.', 'SHORTLISTED', NOW()),
(3, 3, 3, 'Tôi phù hợp với vị trí Backend Developer (Node.js) tại công ty. Kinh nghiệm với MongoDB và Node.js của tôi sẽ giúp ích cho team.', 'APPLIED', NOW()),
(4, 1, 2, 'Ngoài Java, tôi cũng có kiến thức về ReactJS và muốn thử sức với vị trí này.', 'REJECTED', NOW()),
(5, 2, 1, 'Dù vị trí này yêu cầu 5 năm kinh nghiệm, nhưng tôi tin kỹ năng của mình có thể bù đắp.', 'REJECTED', NOW());

-- =====================================================
-- INTERVIEWS
-- Note: type must be ONLINE or OFFLINE (not ONSITE)
-- result must be PASS, FAIL, or PENDING
-- =====================================================
INSERT INTO interviews (id, application_id, scheduled_at, type, location_or_link, interviewer_note, result) VALUES
(1, 1, DATE_ADD(NOW(), INTERVAL 3 DAY), 'ONLINE', 'https://meet.google.com/abc-defg-hij', 'Verify kỹ năng Java, Spring Boot, System Design', 'PENDING'),
(2, 2, DATE_ADD(NOW(), INTERVAL 5 DAY), 'OFFLINE', 'Tòa nhà TechViet Tower, Lầu 15, Quận 1, TP.HCM', 'Thực hành coding ReactJS, JavaScript', 'PENDING'),
(3, 3, DATE_ADD(NOW(), INTERVAL 7 DAY), 'ONLINE', 'https://zoom.us/j/123456789', 'Review portfolio, Node.js skills assessment', 'PENDING');

-- =====================================================
-- NOTIFICATIONS
-- =====================================================
INSERT INTO notifications (id, user_id, title, message, is_read) VALUES
(1, 1, 'Ứng viên mới ứng tuyển', 'Nguyễn Văn Minh đã ứng tuyển vị trí Senior Java Developer', false),
(2, 1, 'Lịch phỏng vấn', 'Bạn có lịch phỏng vấn vào ngày mai với ứng viên Nguyễn Văn Minh', false),
(3, 3, 'Trạng thái đơn ứng tuyển', 'Đơn ứng tuyển Senior Java Developer của bạn đang được xem xét', false);


