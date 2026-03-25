-- =====================================================
-- Sample Data for RecruitPro Recruitment System
-- Database: recruitment_db
-- =====================================================

-- Clear existing data (in correct order due to foreign keys)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE interviews;
TRUNCATE TABLE applications;
TRUNCATE TABLE job_postings;
TRUNCATE TABLE candidate_profiles;
TRUNCATE TABLE companies;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- USERS
-- =====================================================
INSERT INTO users (id, email, password, role, is_active, created_at, updated_at) VALUES
(1, 'recruiter@techviet.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'RECRUITER', true, NOW(), NOW()),
(2, 'recruiter2@techviet.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'RECRUITER', true, NOW(), NOW()),
(3, 'candidate@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'CANDIDATE', true, NOW(), NOW()),
(4, 'candidate2@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'CANDIDATE', true, NOW(), NOW()),
(5, 'candidate3@email.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'CANDIDATE', true, NOW(), NOW());

-- Note: Password for all users is 'password123' (BCrypt hashed)

-- =====================================================
-- COMPANIES
-- =====================================================
INSERT INTO companies (id, user_id, name, logo_url, website, industry, company_size, description, created_at, updated_at) VALUES
(1, 1, 'TechViet Solutions', 'https://ui-avatars.com/api/?name=TV&background=0D8ABC&color=fff&size=150', 'https://techviet.com.vn', 'Công nghệ thông tin', '201-500', 
'TechViet Solutions là công ty hàng đầu về phát triển phần mềm và giải pháp công nghệ tại Việt Nam. Chúng tôi chuyên cung cấp các sản phẩm và dịch vụ CNTT cho các doanh nghiệp trong và ngoài nước.',
NOW(), NOW()),
(2, 2, 'GreenLife Foods', 'https://ui-avatars.com/api/?name=GL&background=28a745&color=fff&size=150', 'https://greenlifefoods.vn', 'Thực phẩm & Đồ uống', '51-200',
'GreenLife Foods chuyên sản xuất và phân phối các sản phẩm thực phẩm sạch, hữu cơ. Chúng tôi cam kết mang đến cho người tiêu dùng những sản phẩm an toàn và chất lượng cao.',
NOW(), NOW());

-- =====================================================
-- CANDIDATE PROFILES
-- =====================================================
INSERT INTO candidate_profiles (id, user_id, full_name, headline, phone, avatar_url, date_of_birth, gender, address, summary, created_at, updated_at) VALUES
(1, 3, 'Nguyễn Văn Minh', 'Senior Java Developer', '0901234567', 'https://ui-avatars.com/api/?name=Nguyen+Van+Minh&background=6f42c1&color=fff&size=150', '1995-03-15', 'Nam', 'TP. Hồ Chí Minh',
'5 năm kinh nghiệm phát triển Java. Kỹ năng Java Spring Boot, Hibernate, Microservices. Đã làm việc với các dự án quy mô lớn cho khách hàng Nhật Bản.',
NOW(), NOW()),
(2, 4, 'Trần Thị Lan', 'Frontend Developer', '0912345678', 'https://ui-avatars.com/api/?name=Tran+Thi+Lan&background=fd7e14&color=fff&size=150', '1997-07-22', 'Nữ', 'Hà Nội',
'3 năm kinh nghiệm phát triển Frontend. Chuyên về ReactJS, Vue.js, TypeScript. Đam mê tạo giao diện người dùng đẹp và thân thiện.',
NOW(), NOW()),
(3, 5, 'Lê Hoàng Nam', 'Full Stack Developer', '0923456789', 'https://ui-avatars.com/api/?name=Le+Hoang+Nam&background=20c997&color=fff&size=150', '1996-11-08', 'Nam', 'Đà Nẵng',
'4 năm kinh nghiệm Full Stack. Kỹ năng Node.js, React, MongoDB, PostgreSQL. Có khả năng làm việc độc lập và theo nhóm hiệu quả.',
NOW(), NOW());

-- =====================================================
-- JOB POSTINGS
-- =====================================================
INSERT INTO job_postings (id, company_id, title, description, requirements, salary_min, salary_max, location, job_type, status, expired_at, created_at) VALUES
(1, 1, 'Senior Java Developer', 
'Chúng tôi đang tìm kiếm Senior Java Developer để tham gia phát triển các dự án cho khách hàng Nhật Bản. Bạn sẽ làm việc trong môi trường Agile, tham gia thiết kế kiến trúc hệ thống và hướng dẫn các developer junior.',
'Yêu cầu:
- Tối thiểu 5 năm kinh nghiệm với Java
- Thành thạo Spring Boot, Hibernate, Microservices
- Có kinh nghiệm với PostgreSQL, MongoDB
- Giao tiếp tiếng Anh tốt
- Có khả năng làm việc nhóm và quản lý thời gian',
15000000, 25000000, 'TP. Hồ Chí Minh', 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 30 DAY), NOW()),

(2, 1, 'Frontend Developer (ReactJS)',
'Tuyển Frontend Developer có kinh nghiệm với ReactJS. Tham gia phát triển giao diện người dùng cho các ứng dụng web hiện đại.',
'Yêu cầu:
- Tối thiểu 2 năm kinh nghiệm với ReactJS hoặc VueJS
- Thành thạo HTML, CSS, JavaScript (ES6+)
- Có kinh nghiệm với Redux hoặc Vuex
- Hiểu biết về responsive design và UX/UI',
10000000, 18000000, 'TP. Hồ Chí Minh', 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 25 DAY), NOW()),

(3, 1, 'Backend Developer (Node.js)',
'Mời gia nhập đội ngũ Backend để phát triển các API và dịch vụ phía server cho nền tảng recruitment.',
'Yêu cầu:
- Tối thiểu 3 năm kinh nghiệm với Node.js
- Kinh nghiệm với Express.js, NestJS
- Thành thạo MongoDB hoặc PostgreSQL
- Có kinh nghiệm Redis, RabbitMQ là điểm cộng',
12000000, 20000000, 'TP. Hồ Chí Minh', 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 20 DAY), NOW()),

(4, 2, 'Nhân viên Marketing',
'Phụ trách hoạt động marketing cho sản phẩm thực phẩm sạch của công ty. Phát triển chiến lược marketing digital và quản lý các chiến dịch quảng cáo.',
'Yêu cầu:
- Tối thiểu 2 năm kinh nghiệm trong marketing
- Kinh nghiệm với Facebook Ads, Google Ads
- Khả năng viết content hấp dẫn
- Sáng tạo, năng động và có khả năng làm việc dưới áp lực',
8000000, 15000000, 'Hà Nội', 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 15 DAY), NOW()),

(5, 2, 'Kế toán viên',
'Tuyển kế toán viên để quản lý hồ sơ kế toán, lập báo cáo tài chính và hỗ trợ kiểm toán nội bộ.',
'Yêu cầu:
- Tốt nghiệp Đại học chuyên ngành Kế toán
- Có chứng chỉ Kế toán viên là điểm cộng
- Kinh nghiệm sử dụng phần mềm kế toán (MISA, Fast)
- Cẩn thận, trung thực và có trách nhiệm',
7000000, 12000000, 'Hà Nội', 'FULL_TIME', 'OPEN', DATE_ADD(NOW(), INTERVAL 20 DAY), NOW());

-- =====================================================
-- APPLICATIONS
-- =====================================================
INSERT INTO applications (id, candidate_id, job_id, cover_letter, status, applied_at) VALUES
(1, 1, 1, 'Tôi rất quan tâm đến vị trí Senior Java Developer tại TechViet Solutions. Với 5 năm kinh nghiệm làm việc với Java và Spring Boot, tôi tin rằng mình có thể đóng góp tích cực cho đội ngũ của bạn.', 'REVIEWING', NOW()),
(2, 2, 2, 'Tôi muốn ứng tuyển vị trí Frontend Developer. Tôi có 3 năm kinh nghiệm với ReactJS và rất hào hứng được làm việc trong môi trường chuyên nghiệp tại TechViet.', 'SHORTLISTED', NOW()),
(3, 3, 3, 'Với kinh nghiệm 4 năm làm Full Stack Developer, tôi nghĩ mình phù hợp với vị trí Backend Developer (Node.js) tại công ty. Tôi mong muốn được phát triển sự nghiệp cùng TechViet.', 'APPLIED', NOW()),
(4, 1, 2, 'Ngoài Java, tôi cũng có kiến thức về ReactJS và muốn thử sức với vị trí Frontend Developer.', 'REJECTED', NOW()),
(5, 2, 1, 'Dù vị trí này yêu cầu 5 năm kinh nghiệm, nhưng tôi tin rằng kỹ năng và đam mê của mình có thể bù đắp được.', 'REJECTED', NOW());

-- =====================================================
-- INTERVIEWS
-- =====================================================
INSERT INTO interviews (id, application_id, scheduled_at, type, location_or_link, interviewer_note, result, created_at) VALUES
(1, 1, DATE_ADD(NOW(), INTERVAL 3 DAY), 'ONLINE', 'https://meet.google.com/abc-defg-hij', 'Liên hệ trước 30 phút để verify kỹ năng Java', 'PENDING', NOW()),
(2, 2, DATE_ADD(NOW(), INTERVAL 5 DAY), 'ONSITE', 'Tòa nhà TechViet Tower, Lầu 15, Quận 1, TP.HCM', 'Chuẩn bị laptop để thực hành coding', 'PENDING', NOW()),
(3, 3, DATE_ADD(NOW(), INTERVAL 7 DAY), 'ONLINE', 'https://zoom.us/j/123456789', 'Review portfolio trước buổi phỏng vấn', 'PENDING', NOW());

-- =====================================================
-- NOTIFICATIONS
-- =====================================================
INSERT INTO notifications (id, user_id, title, message, is_read, created_at) VALUES
(1, 1, 'Ứng viên mới ứng tuyển', 'Nguyễn Văn Minh đã ứng tuyển vị trí Senior Java Developer', false, NOW()),
(2, 1, 'Lịch phỏng vấn', 'Bạn có lịch phỏng vấn vào ngày mai với ứng viên Nguyễn Văn Minh', false, NOW()),
(3, 3, 'Trạng thái đơn ứng tuyển', 'Đơn ứng tuyển Senior Java Developer của bạn đang được xem xét', false, NOW());

-- =====================================================
-- Verify data
-- =====================================================
SELECT 'Users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'Companies', COUNT(*) FROM companies
UNION ALL
SELECT 'Candidate Profiles', COUNT(*) FROM candidate_profiles
UNION ALL
SELECT 'Job Postings', COUNT(*) FROM job_postings
UNION ALL
SELECT 'Applications', COUNT(*) FROM applications
UNION ALL
SELECT 'Interviews', COUNT(*) FROM interviews;
