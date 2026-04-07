-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: recruitment_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `applied_at` datetime(6) DEFAULT NULL,
  `candidate_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_id` bigint NOT NULL,
  `cover_letter` text COLLATE utf8mb4_unicode_ci,
  `status` enum('APPLIED','INTERVIEWING','OFFERED','REJECTED','SHORTLISTED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKafjbp7mjswoqo9dnnt02cql97` (`candidate_id`),
  KEY `FKskjjnjxbf1ir89jh5ts9mh0p4` (`job_id`),
  CONSTRAINT `FKafjbp7mjswoqo9dnnt02cql97` FOREIGN KEY (`candidate_id`) REFERENCES `candidate_profiles` (`id`),
  CONSTRAINT `FKskjjnjxbf1ir89jh5ts9mh0p4` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES ('2026-04-06 23:25:02.000000',1,1,1,'Tôi rất quan tâm đến vị trí Senior Java Developer tại TechViet Solutions. Với 5 năm kinh nghiệm trong lĩnh vực này, tôi tin rằng mình có thể đóng góp tích cực cho đội ngũ.','APPLIED'),('2026-04-06 23:25:02.000000',2,2,2,'Tôi muốn ứng tuyển vị trí Frontend Developer tại TechViet. Tôi đã làm việc với ReactJS trong 3 năm qua và rất hứng thú với các dự án của công ty.','SHORTLISTED'),('2026-04-06 23:25:02.000000',3,3,3,'Tôi phù hợp với vị trí Backend Developer (Node.js) tại công ty. Kinh nghiệm với MongoDB và Node.js của tôi sẽ giúp ích cho team.','APPLIED'),('2026-04-06 23:25:02.000000',1,4,2,'Ngoài Java, tôi cũng có kiến thức về ReactJS và muốn thử sức với vị trí này.','REJECTED'),('2026-04-06 23:25:02.000000',2,5,1,'Dù vị trí này yêu cầu 5 năm kinh nghiệm, nhưng tôi tin kỹ năng của mình có thể bù đắp.','REJECTED');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blogs` (
  `author_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt8g0udj2fq40771g38t2t011n` (`author_id`),
  CONSTRAINT `FKt8g0udj2fq40771g38t2t011n` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blogs`
--

LOCK TABLES `blogs` WRITE;
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` VALUES (6,'2026-04-06 23:10:47.000000',1,'2026-04-06 23:10:47.000000','<h3>1. Hệ sinh thái TypeScript & Các Framework cốt lõi</h3>\n <p>Không chỉ dừng lại ở JavaScript cơ bản, TypeScript đã trở thành tiêu chuẩn bắt buộc cho các dự án lớn. Khả năng kiểm soát kiểu dữ liệu (Type-safe) của nó giúp giảm thiểu tối đa bug ngay từ lúc viết code. Bên cạnh đó, việc thành thạo ít nhất một framework hiện đại như React, Vue, hoặc Angular, kết hợp với các meta-framework như Next.js hay Nuxt.js là điều kiện tiên quyết để xây dựng các ứng dụng web phức tạp.</p>\n <h3>2. Thiết kế Cơ sở dữ liệu (Database Design) & Tối ưu hóa SQL</h3>\n <p>Dù có nhiều công nghệ mới, dữ liệu vẫn là trái tim của mọi ứng dụng. Một lập trình viên xuất sắc trong năm 2026 phải biết cách thiết kế database một cách chuẩn hóa, hiểu rõ về Indexing, và biết cách viết các câu query SQL tối ưu. Việc hiểu khi nào nên dùng Relational DB (SQL Server, PostgreSQL) và khi nào dùng NoSQL (MongoDB, Redis) sẽ quyết định hiệu năng của hệ thống.</p>\n <h3>3. Điện toán đám mây (Cloud Computing) & Microservices</h3>\n <p>Việc làm chủ AWS, Azure hay Google Cloud không còn là tùy chọn. Xu hướng Serverless Architecture và Microservices đang giúp doanh nghiệp tối ưu chi phí và tăng tốc độ triển khai ứng dụng. Bạn cần làm quen với việc chia nhỏ ứng dụng monolithic thành các services độc lập, giao tiếp với nhau qua REST API hoặc gRPC.</p>\n <h3>4. Kỹ năng cộng tác với AI (AI-Augmented Development)</h3>\n <p>Đừng sợ AI cướp việc, hãy sợ người biết dùng AI. Lập trình viên giỏi năm 2026 là người biết sử dụng GitHub Copilot, ChatGPT hoặc Gemini để sinh ra các đoạn boilerplate code, viết unit test tự động, và tìm ra các edge cases trong logic, từ đó dành 80% thời gian cho tư duy kiến trúc hệ thống thay vì gõ phím cơ học.</p>\n <h3>5. Quản lý dự án (Project Management) cho Developer</h3>\n <p>Không chỉ PM mới cần quản lý dự án. Việc lập trình viên tự biết cách chia nhỏ task, ước lượng thời gian (estimation) chính xác, và cập nhật tiến độ liên tục qua Jira/Trello giúp toàn bộ vòng đời phát triển phần mềm (SDLC) diễn ra trơn tru và chuyên nghiệp hơn.</p>','https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=800','Đứng trước làn sóng AI mạnh mẽ, lập trình viên cần trang bị những gì để không bị đào thải? Khám phá ngay bộ kỹ năng then chốt năm 2026.','Lộ trình làm chủ 10 Kỹ Năng \"Sống Còn\" cho Lập trình viên năm 2026'),(6,'2026-04-06 23:10:47.000000',2,'2026-04-06 23:10:47.000000','<h3>1. Tối ưu hóa cho hệ thống ATS (Applicant Tracking System)</h3>\n <p>Các công ty lớn hiện nay đều dùng AI để lọc CV trước khi tới tay con người. Để vượt qua vòng này, bạn cần sử dụng các từ khóa chuyên môn (Keywords) sát với Job Description. Tuyệt đối tránh các định dạng CV quá màu mè, có đồ thị dạng hình ảnh, bảng biểu lồng nhau hoặc chia quá nhiều cột gây nhiễu trình quét. Hãy giữ layout đơn giản, text-based là tốt nhất.</p>\n <h3>2. Áp dụng Công thức STAR trong phần Kinh nghiệm</h3>\n <p>Thay vì liệt kê các công việc nhàm chán như \"Tham gia code backend\", hãy viết theo cấu trúc: <strong>Situation (Tình huống) - Task (Nhiệm vụ) - Action (Hành động) - Result (Kết quả)</strong>.</p>\n <ul>\n    <li><em>Ví dụ chưa tốt:</em> Có kinh nghiệm làm web bán hàng.</li>\n    <li><em>Ví dụ chuẩn STAR:</em> Tối ưu hóa Database Design và viết lại các query SQL cho website bán bánh online (Action), giúp giải quyết tình trạng nghẽn cổ chai dữ liệu (Situation), kết quả làm giảm 40% thời gian tải trang và tăng 15% tỷ lệ chuyển đổi (Result).</li>\n </ul>\n <h3>3. Chứng minh năng lực qua GitHub Profile</h3>\n <p>Một link GitHub với các commit xanh đều đặn có giá trị hơn ngàn lời nói. Tuy nhiên, đừng chỉ để code \"chết\" ở đó. Mỗi repository nổi bật cần phải có một file README.md chỉn chu, bao gồm: Giới thiệu dự án, Công nghệ sử dụng (Java, C#, JavaScript...), Cách cài đặt (How to run), và một vài ảnh chụp màn hình hoặc link Demo trực tiếp.</p>\n <h3>4. Điều chỉnh Mục tiêu Nghề nghiệp (Objective) thật sắc nét</h3>\n <p>Đừng dùng chung một câu mục tiêu cho mọi công ty. Nếu bạn đang ứng tuyển vị trí thực tập, hãy viết rõ ràng: <em>\"Là một sinh viên IT năm cuối với nền tảng vững chắc về Web Development, tôi mong muốn tìm kiếm cơ hội thực tập để áp dụng kiến thức OOP, quy trình Agile và đóng góp vào các sản phẩm thực tế của công ty.\"</em></p>','https://images.unsplash.com/photo-1586281380349-632531db7ed4?w=800','Làm thế nào để CV của bạn vượt qua hệ thống quét tự động (ATS) và lọt vào mắt xanh của các Tech Lead khó tính? Đây là câu trả lời.','Bí quyết viết CV IT \"bách chiến bách thắng\" năm 2026'),(6,'2026-04-06 23:10:47.000000',3,'2026-04-06 23:10:47.000000','<h3>1. Sự lên ngôi của các hệ thống thông minh và Data</h3>\n <p>Nhu cầu về kỹ sư phần mềm biết tích hợp AI vào sản phẩm truyền thống đang bùng nổ. Các công ty không chỉ cần ứng dụng CRUD (Create, Read, Update, Delete) thông thường nữa, họ cần những hệ thống có khả năng phân tích dữ liệu người dùng, gợi ý nội dung (Recommendation Systems) và tự động hóa quy trình nghiệp vụ.</p>\n <h3>2. Chất lượng ứng viên thay thế cho Số lượng</h3>\n <p>Giai đoạn tăng trưởng nóng đã qua. Giờ đây, các công ty sẵn sàng trả lương rất cao cho một \"10x Developer\" (Lập trình viên xuất sắc) thay vì thuê 10 lập trình viên trung bình. Điều này đồng nghĩa với việc bạn phải nắm cực vững kiến thức nền tảng như Mạng máy tính (Networking), Cấu trúc dữ liệu, Hệ điều hành, thay vì chỉ biết dùng Framework một cách rập khuôn.</p>\n <h3>3. Chú trọng văn hóa DevOps và Kiểm thử tự động</h3>\n <p>Ranh giới giữa Developer (Phát triển) và Operation (Vận hành) ngày càng mờ nhạt. Nhà tuyển dụng ưu tiên những ứng viên có tư duy \"You build it, you run it\". Bạn cần biết cách viết Unit Test, Automation Test, và thiết lập luồng CI/CD (Continuous Integration / Continuous Deployment) để đưa code từ máy cá nhân lên server một cách an toàn và tự động.</p>\n <h3>4. Hybrid Work và Yêu cầu khắt khe về kỹ năng mềm</h3>\n <p>Khi mô hình làm việc kết hợp (Hybrid) trở thành tiêu chuẩn, khả năng giao tiếp bất đồng bộ (Asynchronous Communication) qua văn bản là tối quan trọng. Khả năng viết tài liệu kỹ thuật (Documentation) mạch lạc, mô tả bug rõ ràng và review code tinh tế sẽ giúp bạn tỏa sáng trong mắt nhà tuyển dụng.</p>','https://images.unsplash.com/photo-1521737711867-e3b97375f902?w=800','Thị trường IT đang chuyển dịch từ \"thừa số lượng\" sang \"tinh chất lượng\". Những vị trí nào đang khát nhân lực nhất hiện nay?','Phân tích xu hướng tuyển dụng IT 2026: Kỷ nguyên của sự thích nghi'),(6,'2026-04-06 23:10:47.000000',4,'2026-04-06 23:10:47.000000','<h3>1. Cửa ải Thuật toán và Cấu trúc dữ liệu (DSA)</h3>\n <p>Dù có nhiều tranh cãi về tính thực tiễn, DSA vẫn là thước đo tư duy logic cơ bản nhất được các tập đoàn lớn áp dụng. Bạn không cần phải học thuộc lòng các bài toán Olympic, nhưng bắt buộc phải hiểu rõ độ phức tạp thời gian/không gian (Big O Notation) của các thao tác trên Array, HashMap, Tree, và Graph. Hãy luyện tập thường xuyên trên LeetCode hoặc HackerRank.</p>\n <h3>2. Live Coding: Đừng vội vàng gõ code</h3>\n <p>Lỗi lớn nhất của ứng viên khi Live Coding là lập tức cắm mặt vào gõ code. Hãy nhớ, người phỏng vấn quan tâm đến <strong>cách bạn suy nghĩ và giải quyết vấn đề</strong> hơn là một đoạn code chạy được nhưng lộn xộn. Quy trình chuẩn nên là:</p>\n <ul>\n    <li>Đặt câu hỏi làm rõ các ranh giới của bài toán (Edge cases).</li>\n    <li>Trình bày hướng tiếp cận (Approach) và trao đổi với người phỏng vấn.</li>\n    <li>Bắt đầu implement bằng ngôn ngữ thế mạnh của bạn (Java, C#, JS...).</li>\n    <li>Tự nhẩm lại (Dry run) code của mình với một vài test case thực tế trước khi báo hoàn thành.</li>\n </ul>\n <h3>3. Kiến thức chuyên môn theo Stack (Domain Knowledge)</h3>\n <p>Nếu bạn phỏng vấn vị trí Backend, hãy chuẩn bị tinh thần bị hỏi xoáy đáp xoay về Database. Ví dụ: Sự khác biệt giữa N+1 Query là gì? Làm sao để tối ưu hóa nó? Cơ chế hoạt động của Garbage Collection trong Java/C#? Các giao thức mạng TCP/UDP khác nhau thế nào?</p>\n <h3>4. Phỏng vấn sự phù hợp văn hóa (Culture Fit)</h3>\n <p>Kỹ năng code giỏi đến mấy mà thái độ không hợp tác cũng sẽ bị loại. Hãy chuẩn bị các câu chuyện thực tế về cách bạn xử lý khi bất đồng quan điểm với đồng nghiệp, cách bạn vượt qua áp lực deadline, hoặc cách bạn chủ động học hỏi một công nghệ mới.</p>','https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=800','Đừng để những câu hỏi hóc búa làm khó bạn. Hãy cùng bóc tách quy trình phỏng vấn tại các công ty công nghệ.','Chinh phục phỏng vấn Technical: Từ thuật toán đến tư duy hệ thống'),(6,'2026-04-06 23:10:47.000000',5,'2026-04-06 23:10:47.000000','<h3>1. Bức tranh toàn cảnh thu nhập theo cấp bậc</h3>\n <p>Năm 2026 chứng kiến sự ổn định trở lại của thị trường lương thưởng sau những biến động. Theo các báo cáo mới nhất:</p>\n <ul>\n    <li><strong>Fresher/Intern (Dưới 1 năm):</strong> 8.000.000 - 15.000.000 VNĐ. Sự cạnh tranh ở mức độ này cực kỳ gay gắt.</li>\n    <li><strong>Junior (1-3 năm):</strong> 15.000.000 - 25.000.000 VNĐ. Mức lương bắt đầu tăng tốc nhanh nếu ứng viên chứng minh được khả năng làm việc độc lập.</li>\n    <li><strong>Mid-level (3-5 năm):</strong> 25.000.000 - 45.000.000 VNĐ. Đây là lực lượng nòng cốt của các công ty.</li>\n    <li><strong>Senior/Lead (Trên 5 năm):</strong> 50.000.000 - 100.000.000+ VNĐ. Đối với những chuyên gia có khả năng giải quyết các bài toán hóc búa về kiến trúc hệ thống quy mô lớn.</li>\n </ul>\n <h3>2. Sự phân hóa lương theo nền tảng công nghệ (Tech Stack)</h3>\n <p>Sự chênh lệch mức lương giữa các công nghệ không quá lớn ở level thấp, nhưng rõ rệt ở level cao. Lập trình viên thông thạo các ngôn ngữ strongly-typed dành cho hệ thống lớn như Java (Spring Boot) hoặc C# (.NET) thường có lộ trình thăng tiến ổn định trong môi trường Enterprise. Trong khi đó, các kỹ sư làm mảng Cloud/DevOps, Security và AI/Data Science đang nhận được mức đãi ngộ premium cao hơn khoảng 20-30% so với lập trình viên web thông thường.</p>\n <h3>3. Ngoại ngữ: \"Bàn đạp\" nhân đôi thu nhập</h3>\n <p>Sự thật mất lòng: Cùng một năng lực kỹ thuật, một lập trình viên có khả năng giao tiếp tiếng Anh trôi chảy (làm việc trực tiếp với khách hàng Âu Mỹ) hoặc tiếng Nhật (chuẩn N3, N2) có thể nhận mức lương cao gấp rưỡi so với người chỉ làm việc trong team nội địa. Đầu tư vào ngoại ngữ chính là khoản đầu tư có ROI (Tỷ suất hoàn vốn) cao nhất đối với dân IT.</p>','https://images.unsplash.com/photo-1554224155-6726b3ff858f?w=800','Mức lương ngành lập trình tại Việt Nam đang có sự phân hóa mạnh mẽ. Đâu là ngách \"hái ra tiền\" trong năm nay?','Báo cáo lương IT Việt Nam 2026: Những con số biết nói'),(6,'2026-04-06 23:10:47.000000',6,'2026-04-06 23:10:47.000000','<h3>1. Mặt trái của sự tự do (Remote Work)</h3>\n <p>Làm việc từ xa (Remote work) thường được ca ngợi vì tính linh hoạt, tiết kiệm hàng giờ đồng hồ kẹt xe khói bụi mỗi ngày. Bạn có thể setup một góc làm việc hoàn hảo với 2 màn hình 4K và cà phê tự pha. Tuy nhiên, ranh giới giữa công việc và cuộc sống cá nhân (Work-life blur) rất dễ bị xóa nhòa. Nhiều lập trình viên cho biết họ thậm chí còn làm việc nhiều giờ hơn khi ở nhà. Sự thiếu hụt các tương tác xã hội (những cuộc tán gẫu nhỏ) cũng là nguyên nhân chính dẫn đến cảm giác cô đơn và burnout.</p>\n <h3>2. Sức mạnh của sự tương tác trực tiếp (Office Work)</h3>\n <p>Dù có nhiều công cụ họp trực tuyến, không gì thay thế được việc cùng nhau đứng trước bảng trắng (whiteboard) để vẽ và tranh luận về một sơ đồ Database Design phức tạp. Đối với Fresher/Junior, văn phòng là môi trường tuyệt vời nhất để học hỏi thụ động. Bạn học được cách các Senior phản ứng với lỗi hệ thống (production incident), cách họ giao tiếp qua điện thoại, và dễ dàng nhờ sự trợ giúp chỉ bằng cách gõ nhẹ vào vai họ.</p>\n <h3>3. Hybrid Model: Điểm cân bằng lý tưởng</h3>\n <p>Nhận thấy nhược điểm của cả hai thái cực, hầu hết các công ty công nghệ hàng đầu năm 2026 đang áp dụng mô hình Hybrid (Ví dụ: 3 ngày lên công ty, 2 ngày làm ở nhà). Những ngày ở nhà sẽ dành cho \"Deep Work\" – những công việc đòi hỏi sự tập trung cao độ như code một tính năng khó. Những ngày lên công ty sẽ dành cho các cuộc họp quan trọng, lên kế hoạch dự án (Sprint Planning), và kết nối tình cảm đồng đội.</p>','https://images.unsplash.com/photo-1521898284481-a5ec348cb555?w=800','Làm việc tự do tại nhà hay đến văn phòng để kết nối? Cùng phân tích sâu về tác động đến hiệu suất, sức khỏe tinh thần và sự nghiệp của bạn.','Remote Work vs Office: Đâu là lựa chọn tối ưu cho Developer?'),(6,'2026-04-06 23:10:47.000000',7,'2026-04-06 23:10:47.000000','<h3>1. Chọn dự án \"thực tế\", đừng làm lại bản sao</h3>\n <p>Nhà tuyển dụng đã quá chán ngán với các dự án Todo List hay clone giao diện Instagram đơn giản. Hãy xây dựng những ứng dụng giải quyết một bài toán nghiệp vụ (business logic) cụ thể. Ví dụ:</p>\n <ul>\n    <li><strong>Website Web xem phim trực tuyến:</strong> Xử lý tính năng stream video, phân quyền user (VIP/Free), xây dựng chức năng tìm kiếm phim theo nhiều bộ lọc, thiết kế database lưu trữ lịch sử xem phim.</li>\n    <li><strong>Hệ thống bán hàng trực tuyến (VD: Web bán bánh):</strong> Tích hợp giỏ hàng phức tạp, quản lý tồn kho, xử lý luồng thanh toán, và xuất hóa đơn.</li>\n    <li><strong>Ứng dụng Đặt lịch khám phòng khám:</strong> Xử lý logic trùng lịch hẹn, thông báo qua email/SMS, dashboard thống kê cho bác sĩ.</li>\n </ul>\n <h3>2. Trình bày Portfolio như một câu chuyện</h3>\n <p>Đừng chỉ vứt link web và link code. Mỗi dự án trong Portfolio cần có một trang giới thiệu chi tiết (Case Study), trong đó nêu rõ: Công nghệ sử dụng, Vai trò của bạn, Thách thức lớn nhất bạn gặp phải và Cách bạn vượt qua nó. Ví dụ: \"Làm sao để hệ thống xử lý hàng ngàn đơn hàng cùng lúc trong dịp Flash Sale?\". Câu trả lời của bạn sẽ cho thấy chiều sâu kỹ thuật.</p>\n <h3>3. Tinh tế trong từng dòng code (Clean Code)</h3>\n <p>Hãy nhớ rằng các Tech Lead sẽ thực sự mở mã nguồn của bạn ra đọc. Code phải sạch, biến và hàm phải được đặt tên có ý nghĩa (bằng tiếng Anh), tổ chức thư mục (Folder structure) chuẩn mực, và đặc biệt là phải có file README.md hướng dẫn cách khởi chạy dự án cực kỳ chi tiết.</p>','https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800','Một CV chỉ nói lên bạn là ai, nhưng một Portfolio chất lượng sẽ chứng minh năng lực thực chiến của bạn với nhà tuyển dụng.','Xây dựng Portfolio \"độc bản\": Biến dự án cá nhân thành tấm vé vàng'),(6,'2026-04-06 23:10:47.000000',8,'2026-04-06 23:10:47.000000','<h3>1. Giai đoạn Tích lũy (Junior đến Mid-Level)</h3>\n <p>Trong 1-3 năm đầu, mục tiêu số một của bạn là sự thuần thục về mặt kỹ thuật (Technical Mastery). Hãy code thật nhiều, nhưng phải code một cách có ý thức. Đừng chỉ copy-paste từ StackOverflow. Khi một đoạn code chạy được, hãy tìm hiểu tại sao nó chạy. Hãy học cách viết Unit Test, áp dụng các Design Patterns cơ bản, và thấu hiểu các nguyên lý SOLID. Đây là giai đoạn để xây dựng phần móng thật vững chắc.</p>\n <h3>2. Bước ngoặt Seniority: Không chỉ là kỹ thuật</h3>\n <p>Sự khác biệt lớn nhất giữa Mid-level và Senior không nằm ở việc ai biết nhiều syntax hơn. Một Senior Developer là người có khả năng nhìn thấy bức tranh tổng thể (Big Picture). Họ biết cách cân bằng giữa sự hoàn hảo của code và deadline của kinh doanh (Business value). Ở giai đoạn này, bạn sẽ tham gia nhiều hơn vào việc thiết kế kiến trúc, review code của các bạn Junior, và đánh giá tính khả thi của dự án.</p>\n <h3>3. Rẽ nhánh: Quản lý (Management) vs Chuyên gia (Individual Contributor - IC)</h3>\n <p>Khoảng năm thứ 5-7, bạn sẽ đứng trước một ngã rẽ quan trọng:</p>\n <ul>\n    <li><strong>Track Quản lý (Engineering Manager/Tech Lead):</strong> Nếu bạn thích giao tiếp, thích giải quyết các vấn đề về quy trình, phát triển con người, phân bổ nguồn lực và đảm bảo team đi đúng hướng.</li>\n    <li><strong>Track Chuyên gia (Staff/Principal Engineer):</strong> Nếu bạn vẫn đam mê giải quyết những bài toán kỹ thuật hóc búa nhất, thiết kế những hệ thống phục vụ hàng triệu user, và đóng vai trò cố vấn công nghệ cho toàn công ty.</li>\n </ul>','https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=800','Sự nghiệp IT không chỉ có một đường thẳng. Bạn muốn trở thành một chuyên gia kỹ thuật bậc thầy hay một nhà quản lý tài ba?','Lộ trình thăng tiến: Từ gõ code đến dẫn dắt đội ngũ'),(6,'2026-04-06 23:10:47.000000',9,'2026-04-06 23:10:47.000000','<h3>1. Kỹ năng giao tiếp và Dịch thuật \"Ngôn ngữ Tech\"</h3>\n <p>Code chỉ là công cụ để giải quyết bài toán của con người. Lập trình viên xuất sắc là người có khả năng giải thích một vấn đề kỹ thuật phức tạp (như lỗi bất đồng bộ của Database) cho một khách hàng, một người làm Marketing hay Giám đốc kinh doanh một cách dễ hiểu nhất, không dùng thuật ngữ (jargon), để họ hiểu được rủi ro và đồng tình với giải pháp.</p>\n <h3>2. Nghệ thuật Review Code và Làm việc nhóm</h3>\n <p>Code review không phải là nơi để thể hiện cái tôi hay chê bai người khác. Một lập trình viên có EQ cao sẽ để lại những comment mang tính chất xây dựng, gợi ý giải pháp thay vì chỉ trích lỗi sai. Đồng thời, họ cũng biết cách đón nhận feedback một cách cởi mở, không tự ái khi code của mình bị yêu cầu sửa đổi.</p>\n <h3>3. Quản lý kỳ vọng (Expectation Management) và Nói \"Không\"</h3>\n <p>Một trong những kỹ năng khó nhất là việc từ chối những tính năng vô lý hoặc những deadline bất khả thi từ phía Product Manager một cách chuyên nghiệp. Thay vì nói \"Không làm được\", hãy đưa ra sự lựa chọn: \"Chúng ta có thể hoàn thành kịp deadline thứ 6 này, nhưng phải cắt giảm 2 tính năng phụ này, hoặc chúng ta cần thêm 1 tuần để hoàn thiện toàn bộ. Bạn muốn ưu tiên phương án nào?\".</p>','https://images.unsplash.com/photo-1552664730-d307ca884978?w=800','Tại sao những lập trình viên mang lại giá trị cao nhất cho công ty thường không phải là người code nhanh nhất?','Soft Skills - \"Vũ khí bí mật\" của những Developer xuất chúng'),(6,'2026-04-06 23:10:47.000000',10,'2026-04-06 23:10:47.000000','<h3>1. Khởi đầu với sự đơn giản trước khi mở rộng</h3>\n <p>Trong mọi buổi phỏng vấn thiết kế hệ thống, sai lầm phổ biến là cố gắng nhồi nhét Kafka, Kubernetes, Microservices vào ngay từ đầu. Hãy bắt đầu với một thiết kế Monolithic đơn giản nhất (1 Web Server + 1 Database Server) để giải quyết logic nghiệp vụ. Sau đó, dựa trên các yêu cầu về hiệu năng (QPS - Queries Per Second) và lưu lượng dữ liệu, mới bắt đầu bóc tách các điểm nghẽn (bottleneck).</p>\n <h3>2. Case Study thực tế: Nền tảng Web xem phim trực tuyến</h3>\n <p>Giả sử bạn phải thiết kế hệ thống giống Netflix. Đây là lúc tư duy kiến trúc lên tiếng:</p>\n <ul>\n    <li><strong>Lưu trữ Video:</strong> Video file lớn không thể lưu trong Database thường. Bạn sẽ cần Object Storage (như Amazon S3) và kết hợp với mạng phân phối nội dung CDN (Content Delivery Network) để người dùng ở các khu vực địa lý khác nhau tải video nhanh nhất.</li>\n    <li><strong>Database Design:</strong> Dữ liệu về metadata phim (tên, đạo diễn, năm sản xuất) có thể lưu ở cơ sở dữ liệu quan hệ (Relational DB) để dễ dàng query. Nhưng dữ liệu về lượt xem, lượt thích, lịch sử tương tác liên tục của hàng triệu user nên được đẩy vào NoSQL hoặc Cache (Redis) để đảm bảo tốc độ phản hồi tính bằng mili-giây.</li>\n </ul>\n <h3>3. Hiểu về các Trade-offs (Sự đánh đổi)</h3>\n <p>Trong System Design, không có giải pháp \"đúng\" hay \"sai\" tuyệt đối, chỉ có giải pháp \"phù hợp\" với bối cảnh kinh doanh. Định lý CAP (Consistency, Availability, Partition Tolerance) chỉ ra rằng trong một hệ thống phân tán, bạn phải đánh đổi. Ví dụ: Với hệ thống hiển thị lượt Like trên Facebook, hệ thống ưu tiên tính sẵn sàng (Availability) - người dùng có thể thấy số Like hơi chậm một chút cũng không sao. Nhưng với hệ thống giao dịch ngân hàng, tính nhất quán (Consistency) phải được đặt lên hàng đầu, dữ liệu phải chính xác tuyệt đối ở mọi thời điểm.</p>','https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800','Phân tích cách các \"ông lớn\" công nghệ thiết kế hệ thống chịu tải hàng triệu người dùng đồng thời.','Luyện kỹ năng System Design: Tư duy như Kiến trúc sư');
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_experiences`
--

DROP TABLE IF EXISTS `candidate_experiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_experiences` (
  `end_date` date DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `candidate_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjpevwfb6c4phklll16a8wu0dj` (`candidate_id`),
  CONSTRAINT `FKjpevwfb6c4phklll16a8wu0dj` FOREIGN KEY (`candidate_id`) REFERENCES `candidate_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_experiences`
--

LOCK TABLES `candidate_experiences` WRITE;
/*!40000 ALTER TABLE `candidate_experiences` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_experiences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_profiles`
--

DROP TABLE IF EXISTS `candidate_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_profiles` (
  `date_of_birth` date DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `headline` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resume_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKm7asead9kaplln9cdupjat1cq` (`user_id`),
  CONSTRAINT `FKn7b2se0y378uox9e3aw2bjg13` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_profiles`
--

LOCK TABLES `candidate_profiles` WRITE;
/*!40000 ALTER TABLE `candidate_profiles` DISABLE KEYS */;
INSERT INTO `candidate_profiles` VALUES ('1995-03-15',1,3,'TP. Hồ Chí Minh','https://ui-avatars.com/api/?name=Nguyen+Van+Minh&background=6f42c1&color=fff&size=150','Nguyễn Văn Minh','Nam','Senior Java Developer','0901234567',NULL,'5 năm kinh nghiệm phát triển Java. Kỹ năng Java Spring Boot, Hibernate, Microservices.'),('1997-07-22',2,4,'Hà Nội','https://ui-avatars.com/api/?name=Tran+Thi+Lan&background=fd7e14&color=fff&size=150','Trần Thị Lan','Nữ','Frontend Developer','0912345678',NULL,'3 năm kinh nghiệm phát triển Frontend. Chuyên về ReactJS, Vue.js, TypeScript.'),('1996-11-08',3,5,'Đà Nẵng','https://ui-avatars.com/api/?name=Le+Hoang+Nam&background=20c997&color=fff&size=150','Lê Hoàng Nam','Nam','Full Stack Developer','0923456789',NULL,'4 năm kinh nghiệm Full Stack. Kỹ năng Node.js, React, MongoDB, PostgreSQL.');
/*!40000 ALTER TABLE `candidate_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `candidate_skills`
--

DROP TABLE IF EXISTS `candidate_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidate_skills` (
  `candidate_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK13xo0mq175kdpsauy73xhhol2` (`candidate_id`),
  CONSTRAINT `FK13xo0mq175kdpsauy73xhhol2` FOREIGN KEY (`candidate_id`) REFERENCES `candidate_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidate_skills`
--

LOCK TABLES `candidate_skills` WRITE;
/*!40000 ALTER TABLE `candidate_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidate_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `company_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK5xg6ed73n32iai9psir68pia9` (`user_id`),
  CONSTRAINT `FK9l5d0fem75e59uwf9upwuf9du` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,1,'201-500','TechViet Solutions là công ty hàng đầu về phát triển phần mềm và giải pháp công nghệ tại Việt Nam.','Công nghệ thông tin','https://ui-avatars.com/api/?name=TV&background=0D8ABC&color=fff&size=150','TechViet Solutions','https://techviet.com.vn'),(2,2,'51-200','GreenLife Foods chuyên sản xuất và phân phối các sản phẩm thực phẩm sạch, hữu cơ.','Thực phẩm & Đồ uống','https://ui-avatars.com/api/?name=GL&background=28a745&color=fff&size=150','GreenLife Foods','https://greenlifefoods.vn');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interviews`
--

DROP TABLE IF EXISTS `interviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interviews` (
  `application_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `scheduled_at` datetime(6) DEFAULT NULL,
  `interviewer_note` text COLLATE utf8mb4_unicode_ci,
  `location_or_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` enum('FAIL','PASS','PENDING') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` enum('OFFLINE','ONLINE') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKok2bail5ls3jjbjgl5c6nt620` (`application_id`),
  CONSTRAINT `FKok2bail5ls3jjbjgl5c6nt620` FOREIGN KEY (`application_id`) REFERENCES `applications` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interviews`
--

LOCK TABLES `interviews` WRITE;
/*!40000 ALTER TABLE `interviews` DISABLE KEYS */;
INSERT INTO `interviews` VALUES (1,1,'2026-04-09 23:25:02.000000','Verify kỹ năng Java, Spring Boot, System Design','https://meet.google.com/abc-defg-hij','PENDING','ONLINE'),(2,2,'2026-04-11 23:25:02.000000','Thực hành coding ReactJS, JavaScript','Tòa nhà TechViet Tower, Lầu 15, Quận 1, TP.HCM','PENDING','OFFLINE'),(3,3,'2026-04-13 23:25:02.000000','Review portfolio, Node.js skills assessment','https://zoom.us/j/123456789','PENDING','ONLINE');
/*!40000 ALTER TABLE `interviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_alerts`
--

DROP TABLE IF EXISTS `job_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_alerts` (
  `is_active` bit(1) DEFAULT NULL,
  `min_salary` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_field_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbil0ni82aunlcl4xfft8scbid` (`job_field_id`),
  KEY `FKksse6bosg98oau3dd0emt4cnn` (`user_id`),
  CONSTRAINT `FKbil0ni82aunlcl4xfft8scbid` FOREIGN KEY (`job_field_id`) REFERENCES `job_fields` (`id`),
  CONSTRAINT `FKksse6bosg98oau3dd0emt4cnn` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_alerts`
--

LOCK TABLES `job_alerts` WRITE;
/*!40000 ALTER TABLE `job_alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_fields`
--

DROP TABLE IF EXISTS `job_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_fields` (
  `created_at` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_fields`
--

LOCK TABLES `job_fields` WRITE;
/*!40000 ALTER TABLE `job_fields` DISABLE KEYS */;
INSERT INTO `job_fields` VALUES ('2026-04-06 23:25:02.000000',1,'2026-04-06 23:25:02.000000','Công nghệ thông tin','Phần mềm, IT, viễn thông, an ninh mạng'),('2026-04-06 23:25:02.000000',2,'2026-04-06 23:25:02.000000','Kế toán - Tài chính','Kế toán, kiểm toán, tài chính, ngân hàng'),('2026-04-06 23:25:02.000000',3,'2026-04-06 23:25:02.000000','Marketing - Quảng cáo','Marketing, digital marketing, PR, quảng cáo'),('2026-04-06 23:25:02.000000',4,'2026-04-06 23:25:02.000000','Kinh doanh - Bán hàng','Kinh doanh, bán hàng, chăm sóc khách hàng'),('2026-04-06 23:25:02.000000',5,'2026-04-06 23:25:02.000000','Thực phẩm - Đồ uống','Sản xuất, chế biến, kiểm soát chất lượng thực phẩm'),('2026-04-06 23:25:02.000000',6,'2026-04-06 23:25:02.000000','Nhân sự - Hành chính','Nhân sự, hành chính, văn phòng'),('2026-04-06 23:25:02.000000',7,'2026-04-06 23:25:02.000000','Kỹ thuật - Cơ khí','Kỹ thuật, cơ khí, điện, điện tử'),('2026-04-06 23:25:02.000000',8,'2026-04-06 23:25:02.000000','Giáo dục - Đào tạo','Giáo dục, đào tạo, nghiên cứu'),('2026-04-06 23:25:02.000000',9,'2026-04-06 23:25:02.000000','Y tế - Dược phẩm','Y tế, dược phẩm, chăm sóc sức khỏe'),('2026-04-06 23:25:02.000000',10,'2026-04-06 23:25:02.000000','Thiết kế - Sáng tạo','Thiết kế đồ họa, nội thất, thời trang'),('2026-04-06 23:25:02.000000',11,'2026-04-06 23:25:02.000000','Khoa học - Nghiên cứu','Nghiên cứu, khoa học, phát triển sản phẩm'),('2026-04-06 23:25:02.000000',12,'2026-04-06 23:25:02.000000','Logistics - Vận tải','Kho vận, vận tải, xuất nhập khẩu'),('2026-04-06 23:25:02.000000',13,'2026-04-06 23:25:02.000000','Bất động sản - Xây dựng','Bất động sản, xây dựng, kiến trúc'),('2026-04-06 23:25:02.000000',14,'2026-04-06 23:25:02.000000','Du lịch - Khách sạn','Du lịch, khách sạn, nhà hàng'),('2026-04-06 23:25:02.000000',15,'2026-04-06 23:25:02.000000','Pháp luật - Luật','Pháp luật, tư vấn pháp lý, thương mại');
/*!40000 ALTER TABLE `job_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_postings`
--

DROP TABLE IF EXISTS `job_postings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_postings` (
  `salary_max` int DEFAULT NULL,
  `salary_min` int DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expired_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_field_id` bigint DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requirements` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job_type` enum('FULL_TIME','PART_TIME','REMOTE') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('CLOSED','DRAFT','OPEN') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsqi8bt5rigxvxpos31t4eonss` (`company_id`),
  KEY `FKcn2naap2lt9yp035st9tx6o6c` (`job_field_id`),
  CONSTRAINT `FKcn2naap2lt9yp035st9tx6o6c` FOREIGN KEY (`job_field_id`) REFERENCES `job_fields` (`id`),
  CONSTRAINT `FKsqi8bt5rigxvxpos31t4eonss` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_postings`
--

LOCK TABLES `job_postings` WRITE;
/*!40000 ALTER TABLE `job_postings` DISABLE KEYS */;
INSERT INTO `job_postings` VALUES (25000000,15000000,1,'2026-04-06 23:25:02.000000','2026-05-06 23:25:02.000000',1,1,NULL,'Tuyển Senior Java Developer cho dự án khách hàng Nhật Bản. Tham gia phát triển các giải pháp Enterprise sử dụng Java Spring Boot, microservices architecture. Làm việc trong môi trường Agile/Scrum với đội ngũ chuyên nghiệp.','TP. Hồ Chí Minh','5 năm kinh nghiệm Java, Spring Boot, Hibernate, Microservices. Có kinh nghiệm với Kubernetes, Docker, CI/CD.','Senior Java Developer','FULL_TIME','OPEN'),(18000000,10000000,1,'2026-04-06 23:25:02.000000','2026-05-01 23:25:02.000000',2,1,NULL,'Tuyển Frontend Developer có kinh nghiệm ReactJS. Phát triển giao diện người dùng cho các ứng dụng web hiện đại. Làm việc chặt chẽ với team Backend và UI/UX Designer.','TP. Hồ Chí Minh','2 năm kinh nghiệm ReactJS, HTML, CSS, JavaScript. Biết TypeScript là lợi thế.','Frontend Developer (ReactJS)','FULL_TIME','OPEN'),(20000000,12000000,1,'2026-04-06 23:25:02.000000','2026-04-26 23:25:02.000000',3,1,NULL,'Phát triển API và dịch vụ server cho nền tảng recruitment. Xây dựng các microservice bằng Node.js, Express, MongoDB. Tối ưu hóa hiệu suất và mở rộng hệ thống.','TP. Hồ Chí Minh','3 năm kinh nghiệm Node.js, Express, MongoDB. Có kinh nghiệm với Redis, RabbitMQ.','Backend Developer (Node.js)','FULL_TIME','OPEN'),(15000000,8000000,2,'2026-04-06 23:25:02.000000','2026-04-21 23:25:02.000000',4,3,NULL,'Phát triển chiến lược marketing digital. Quản lý các chiến dịch quảng cáo trên Facebook Ads, Google Ads. Phân tích dữ liệu và tối ưu hóa chiến dịch.','Hà Nội','2 năm kinh nghiệm marketing, Facebook Ads, Google Ads. Biết SEO là lợi thế.','Nhân viên Marketing','FULL_TIME','OPEN'),(12000000,7000000,2,'2026-04-06 23:25:02.000000','2026-04-26 23:25:02.000000',5,2,NULL,'Quản lý hồ sơ kế toán, lập báo cáo tài chính. Thực hiện các nghiệp vụ kế toán theo quy định. Phối hợp với kiểm toán nội bộ và bên ngoài.','Hà Nội','Tốt nghiệp ĐH Kế toán, kinh nghiệm MISA, Fast. Có chứng chỉ CPA là lợi thế.','Kế toán viên','FULL_TIME','OPEN');
/*!40000 ALTER TABLE `job_postings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_skills`
--

DROP TABLE IF EXISTS `job_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_skills` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_id` bigint NOT NULL,
  `skill_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt7lohvyjn1vtjmdyfkr6r953t` (`job_id`),
  CONSTRAINT `FKt7lohvyjn1vtjmdyfkr6r953t` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_skills`
--

LOCK TABLES `job_skills` WRITE;
/*!40000 ALTER TABLE `job_skills` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linkcvs`
--

DROP TABLE IF EXISTS `linkcvs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linkcvs` (
  `is_active` bit(1) DEFAULT NULL,
  `candidate_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) DEFAULT NULL,
  `link_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKf3vkljn7vw3y9jgg5t65qoxv3` (`candidate_id`),
  CONSTRAINT `FKf3vkljn7vw3y9jgg5t65qoxv3` FOREIGN KEY (`candidate_id`) REFERENCES `candidate_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linkcvs`
--

LOCK TABLES `linkcvs` WRITE;
/*!40000 ALTER TABLE `linkcvs` DISABLE KEYS */;
/*!40000 ALTER TABLE `linkcvs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbti_answers`
--

DROP TABLE IF EXISTS `mbti_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mbti_answers` (
  `selected_option` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_id` bigint NOT NULL,
  `test_result_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6r17548y39v6h9mpoc5p9qhxr` (`question_id`),
  KEY `FKomp9d7yjd06rcvxtpkienjxoq` (`test_result_id`),
  CONSTRAINT `FK6r17548y39v6h9mpoc5p9qhxr` FOREIGN KEY (`question_id`) REFERENCES `mbti_questions` (`id`),
  CONSTRAINT `FKomp9d7yjd06rcvxtpkienjxoq` FOREIGN KEY (`test_result_id`) REFERENCES `mbti_test_results` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbti_answers`
--

LOCK TABLES `mbti_answers` WRITE;
/*!40000 ALTER TABLE `mbti_answers` DISABLE KEYS */;
INSERT INTO `mbti_answers` VALUES ('A',61,421,2),('B',62,422,2),('B',63,423,2),('B',64,424,2),('B',65,425,2),('A',66,426,2),('B',67,427,2),('B',68,428,2),('B',69,429,2),('A',70,430,2),('B',71,431,2),('A',72,432,2),('B',73,433,2),('B',74,434,2),('B',75,435,2),('A',76,436,2),('B',77,437,2),('B',78,438,2),('B',79,439,2),('A',80,440,2),('A',81,441,2),('B',82,442,2),('A',83,443,2),('A',84,444,2),('B',85,445,2),('A',86,446,2),('B',87,447,2),('B',88,448,2),('A',89,449,2),('B',90,450,2),('A',91,451,2),('B',92,452,2),('A',93,453,2),('A',94,454,2),('B',95,455,2),('A',96,456,2),('B',97,457,2),('A',98,458,2),('A',99,459,2),('A',100,460,2),('A',101,461,2),('B',102,462,2),('A',103,463,2),('A',104,464,2),('B',105,465,2),('A',106,466,2),('B',107,467,2),('B',108,468,2),('B',109,469,2),('B',110,470,2),('A',111,471,2),('B',112,472,2),('B',113,473,2),('B',114,474,2),('B',115,475,2),('A',116,476,2),('A',117,477,2),('B',118,478,2),('B',119,479,2),('B',120,480,2);
/*!40000 ALTER TABLE `mbti_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbti_questions`
--

DROP TABLE IF EXISTS `mbti_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mbti_questions` (
  `question_order` int DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `dimension` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_a` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_b` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbti_questions`
--

LOCK TABLES `mbti_questions` WRITE;
/*!40000 ALTER TABLE `mbti_questions` DISABLE KEYS */;
INSERT INTO `mbti_questions` VALUES (1,421,'EI','Trò chuyện với nhiều người, kể cả người lạ','Chỉ nói chuyện với vài người quen biết','Trong các bữa tiệc, bạn thường:'),(2,422,'EI','Đi chơi với bạn bè để giải tỏa','Ở nhà một mình nghỉ ngơi','Sau một tuần làm việc căng thẳng, bạn muốn:'),(3,423,'EI','Thảo luận với người khác để tìm giải pháp','Tự suy nghĩ và tìm giải pháp một mình','Khi gặp vấn đề, bạn thường:'),(4,424,'EI','Nói nhiều, đưa ra nhiều ý kiến','Lắng nghe và chỉ nói khi cần thiết','Trong các cuộc họp nhóm, bạn thường:'),(5,425,'EI','Công việc cần giao tiếp nhiều với mọi người','Công việc có thể làm độc lập, ít giao tiếp','Bạn thích công việc nào hơn?'),(6,426,'EI','Dễ dàng hòa nhập và kết bạn mới nhanh','Cần thời gian để quen dần, quan sát trước','Khi làm quen với môi trường mới, bạn:'),(7,427,'EI','Người năng động, thích nói chuyện','Người điềm đạm, ít nói','Bạn thường được mọi người đánh giá là:'),(8,428,'EI','Chia sẻ ngay với mọi người','Giữ cho mình hoặc chỉ nói với người thân','Khi bạn có tin vui, bạn:'),(9,429,'EI','Thoải mái bắt đầu cuộc trò chuyện','Thích khi người khác bắt chuyện trước','Trong tình huống xã hội, bạn:'),(10,430,'EI','Các hoạt động nhóm, team building','Các sở thích cá nhân như đọc sách, nghe nhạc','Bạn cảm thấy hứng thú hơn với:'),(11,431,'EI','Cảm thấy hào hứng và tự tin','Cảm thấy lo lắng nhưng cố gắng hoàn thành','Khi phải thuyết trình trước đám đông, bạn:'),(12,432,'EI','Đi dã ngoại, tiệc tùng với bạn bè','Ở nhà đọc sách, xem phim một mình','Cuối tuần lý tưởng của bạn là:'),(13,433,'EI','Làm việc nhóm, thảo luận liên tục','Làm việc một mình trong không gian yên tĩnh','Bạn thường làm việc hiệu quả hơn khi:'),(14,434,'EI','Dễ dàng bắt chuyện và làm quen','Cần thời gian để cảm thấy thoải mái','Khi gặp người lạ, bạn thường:'),(15,435,'EI','Gặp mặt trực tiếp hoặc gọi điện thoại','Nhắn tin hoặc email để có thời gian suy nghĩ','Bạn thích cách giao tiếp nào hơn?'),(16,436,'SN','Kinh nghiệm thực tế và dữ liệu cụ thể','Trực giác và khả năng suy luận','Bạn tin tưởng vào thông tin từ:'),(17,437,'SN','Tác phẩm mô tả chi tiết, có thật','Tác phẩm khoa học viễn tưởng, tưởng tượng','Khi đọc một cuốn sách, bạn thích:'),(18,438,'SN','Chi tiết cụ thể trong công việc','Bức tranh tổng thể và ý tưởng lớn','Bạn thường chú ý đến:'),(19,439,'SN','Học theo quy trình từng bước cụ thể','Tự khám phá và tìm cách riêng','Khi học một điều mới, bạn thích:'),(20,440,'SN','Hành động thực tế và kết quả','Ý định và tiềm năng của họ','Bạn đánh giá một người dựa trên:'),(21,441,'SN','Giải pháp đã được chứng minh hiệu quả','Giải pháp sáng tạo, mới mẻ','Khi giải quyết vấn đề, bạn ưu tiên:'),(22,442,'SN','Tuân theo các quy trình đã có','Tìm cách cải tiến và đổi mới','Bạn thích cách làm việc nào hơn?'),(23,443,'SN','Mô tả chi tiết, cụ thể','Nói về ý nghĩa và kết nối','Khi mô tả một sự việc, bạn thường:'),(24,444,'SN','Thực tại và những gì đang xảy ra','Tương lai và những khả năng có thể','Bạn quan tâm hơn đến:'),(25,445,'SN','Người thực hiện các công việc cụ thể','Người đưa ra ý tưởng và tầm nhìn','Trong một dự án, bạn thường đóng vai trò:'),(26,446,'SN','Công việc có quy trình rõ ràng','Công việc cần sáng tạo và đổi mới','Bạn thích công việc nào hơn?'),(27,447,'SN','Áp dụng các giải pháp đã biết','Tìm cách mới, khác biệt','Khi gặp khó khăn, bạn thường:'),(28,448,'SN','Điều gì đã được chứng minh bằng thực tế','Khả năng và tiềm năng của con người','Bạn tin vào:'),(29,449,'SN','Dữ liệu và thông tin cụ thể','Ý tưởng và khái niệm trừu tượng','Bạn thích làm việc với:'),(30,450,'SN','Chi tiết từng bước thực hiện','Chỉ phác thảo ý tưởng chính','Khi lập kế hoạch, bạn:'),(31,451,'TF','Logic và phân tích khách quan','Cảm xúc và tác động đến người khác','Khi đưa ra quyết định quan trọng, bạn dựa vào:'),(32,452,'TF','Sự thật và logic đúng đắn','Cảm xúc và quan điểm của mỗi người','Trong tranh luận, bạn ưu tiên:'),(33,453,'TF','Phân tích vấn đề một cách logic','Hiểu và chia sẻ cảm xúc người khác','Bạn cảm thấy thoải mái hơn khi:'),(34,454,'TF','Đưa ra lời khuyên và giải pháp cụ thể','Lắng nghe và động viên tinh thần','Khi người thân gặp khó khăn, bạn thường:'),(35,455,'TF','Hiệu quả và kết quả thực tế','Ảnh hưởng đến cảm xúc mọi người','Bạn đánh giá một quyết định dựa trên:'),(36,456,'TF','Công bằng và nguyên tắc','Sự đồng cảm và hỗ trợ đồng nghiệp','Trong công việc, bạn coi trọng:'),(37,457,'TF','Nêu rõ vấn đề một cách thẳng thắn','Cố gắng nhẹ nhàng để không làm họ tổn thương','Khi phải phê bình người khác, bạn:'),(38,458,'TF','Người thực tế, ít cảm xúc','Người biết quan tâm, cảm thông','Bạn thường bị đánh giá là:'),(39,459,'TF','Lựa chọn logic và hợp lý nhất','Lựa chọn phù hợp với giá trị và cảm xúc','Khi đứng trước hai lựa chọn, bạn ưu tiên:'),(40,460,'TF','Việc đưa ra quyết định cảm xúc','Việc đưa ra quyết định thiếu cảm xúc','Bạn cảm thấy khó khăn hơn với:'),(41,461,'TF','Đưa ra nhận xét thẳng thắn','Giữ hòa khí và động viên mọi người','Trong nhóm, bạn thường là người:'),(42,462,'TF','Phân tích đúng đắn và hành động logic','Đam mê và sự tận tâm','Bạn tin rằng thành công đến từ:'),(43,463,'TF','Hỏi lý do và tìm giải pháp','Cảm thấy muốn an ủi và chia sẻ','Khi thấy ai đó khóc, bạn thường:'),(44,464,'TF','Sự thật và công bằng','Sự hòa thuận và thiện chí','Bạn ưu tiên giá trị nào hơn?'),(45,465,'TF','Những điểm cần cải thiện','Những điểm tích cực trước','Khi đưa ra phản hồi, bạn tập trung vào:'),(46,466,'JP','Có kế hoạch chi tiết từ trước','Linh hoạt, thích ứng theo tình huống','Bạn thích cách làm việc nào hơn?'),(47,467,'JP','Hoàn thành trước hạn một cách thoải mái','Làm đến phút chót mới xong','Khi có deadline, bạn thường:'),(48,468,'JP','Mọi việc được sắp xếp theo kế hoạch','Có sự thay đổi bất ngờ và thử thách mới','Bạn cảm thấy thoải mái hơn khi:'),(49,469,'JP','Tuân thủ kế hoạch đã đề ra','Thay đổi và điều chỉnh theo quá trình','Trong các dự án, bạn thích:'),(50,470,'JP','Người có tổ chức, kỷ luật','Người linh hoạt, thích nghi tốt','Bạn thường được mọi người đánh giá là:'),(51,471,'JP','Lên lịch trình chi tiết trước','Đi và quyết định tại chỗ','Khi đi du lịch, bạn thích:'),(52,472,'JP','Kế hoạch bị thay đổi đột ngột','Phải tuân thủ quy trình cứng nhắc','Bạn cảm thấy căng thẳng khi:'),(53,473,'JP','Làm từng bước theo trình tự','Làm theo cảm hứng, có thể nhảy cóc','Cách bạn giải quyết công việc:'),(54,474,'JP','Có quy trình và nguyên tắc rõ ràng','Mở và linh hoạt, cho phép sáng tạo','Bạn thích môi trường làm việc:'),(55,475,'JP','Tìm hiểu kỹ và lập kế hoạch chi tiết','Đi vào làm ngay và học dần','Khi bắt đầu một công việc mới, bạn:'),(56,476,'JP','Hoàn thành công việc đúng hạn','Khám phá các khả năng mới','Bạn ưu tiên:'),(57,477,'JP','Gọn gàng, ngăn nắp, có trật tự','Có thể bừa bộn nhưng biết mọi thứ ở đâu','Phòng làm việc/bàn làm việc của bạn:'),(58,478,'JP','Lên danh sách ưu tiên và làm theo','Làm việc nào thấy hứng trước','Khi có nhiều việc cùng lúc, bạn:'),(59,479,'JP','Kỷ luật là chìa khóa thành công','Sự linh hoạt giúp thích nghi tốt hơn','Bạn tin rằng:'),(60,480,'JP','Thu thập thông tin và quyết định dứt khoát','Cân nhắc nhiều lựa chọn, có thể thay đổi sau','Khi phải đưa ra quyết định nhanh, bạn:');
/*!40000 ALTER TABLE `mbti_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mbti_test_results`
--

DROP TABLE IF EXISTS `mbti_test_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mbti_test_results` (
  `e_score` int DEFAULT NULL,
  `f_score` int DEFAULT NULL,
  `i_score` int DEFAULT NULL,
  `j_score` int DEFAULT NULL,
  `n_score` int DEFAULT NULL,
  `p_score` int DEFAULT NULL,
  `s_score` int DEFAULT NULL,
  `t_score` int DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `taken_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `result_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `career_fits` text COLLATE utf8mb4_unicode_ci,
  `description` text COLLATE utf8mb4_unicode_ci,
  `strengths` text COLLATE utf8mb4_unicode_ci,
  `weaknesses` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `FKqlhoaj1fatn2vgjj005c8ovyw` (`user_id`),
  CONSTRAINT `FKqlhoaj1fatn2vgjj005c8ovyw` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mbti_test_results`
--

LOCK TABLES `mbti_test_results` WRITE;
/*!40000 ALTER TABLE `mbti_test_results` DISABLE KEYS */;
INSERT INTO `mbti_test_results` VALUES (4,5,11,4,8,11,7,10,2,'2026-04-06 16:16:06.889506',3,'INTP','Nhà khoa học, lập trình viên, nhà phân tích, nhà nghiên cứu, nhà phát triển game','INTP là những người sáng tạo, có tư duy logic và thích phân tích. Họ luôn tìm kiếm sự hiểu biết sâu sắc về cách mọi thứ hoạt động.','Sáng tạo, logic, khách quan, cầu tiến','Có thể xa rời thực tế, thiếu sự thực dụng, dễ bị phân tâm');
/*!40000 ALTER TABLE `mbti_test_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `is_read` bit(1) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `receiver_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  `sent_at` datetime(6) DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_conversation` (`sender_id`,`receiver_id`),
  KEY `FKt05r0b6n0iis8u7dfna4xdh73` (`receiver_id`),
  CONSTRAINT `FK4ui4nnwntodh6wjvck53dbk9m` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKt05r0b6n0iis8u7dfna4xdh73` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mycvs`
--

DROP TABLE IF EXISTS `mycvs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mycvs` (
  `is_active` bit(1) DEFAULT NULL,
  `is_default` bit(1) DEFAULT NULL,
  `candidate_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `file_size` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) DEFAULT NULL,
  `cv_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cv_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcenukia22jdosquh1mlp645ye` (`candidate_id`),
  CONSTRAINT `FKcenukia22jdosquh1mlp645ye` FOREIGN KEY (`candidate_id`) REFERENCES `candidate_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mycvs`
--

LOCK TABLES `mycvs` WRITE;
/*!40000 ALTER TABLE `mycvs` DISABLE KEYS */;
/*!40000 ALTER TABLE `mycvs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `is_read` bit(1) DEFAULT NULL,
  `company_id` bigint DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK4jibwyyblv04ovaf0uhcg2xe4` (`company_id`),
  KEY `FK9y21adhxn0ayjhfocscqox7bh` (`user_id`),
  CONSTRAINT `FK4jibwyyblv04ovaf0uhcg2xe4` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  CONSTRAINT `FK9y21adhxn0ayjhfocscqox7bh` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (_binary '\0',NULL,NULL,1,1,'Nguyễn Văn Minh đã ứng tuyển vị trí Senior Java Developer','Ứng viên mới ứng tuyển'),(_binary '\0',NULL,NULL,2,1,'Bạn có lịch phỏng vấn vào ngày mai với ứng viên Nguyễn Văn Minh','Lịch phỏng vấn'),(_binary '\0',NULL,NULL,3,3,'Đơn ứng tuyển Senior Java Developer của bạn đang được xem xét','Trạng thái đơn ứng tuyển');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recruiter_approval_requests`
--

DROP TABLE IF EXISTS `recruiter_approval_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recruiter_approval_requests` (
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `admin_note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_license_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company_website` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_person_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('APPROVED','PENDING','REJECTED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKt8aowlestj9snhewba8hd1f8h` (`user_id`),
  CONSTRAINT `FKoneanv90rdnylk78bpvi4gf3e` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recruiter_approval_requests`
--

LOCK TABLES `recruiter_approval_requests` WRITE;
/*!40000 ALTER TABLE `recruiter_approval_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `recruiter_approval_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_jobs`
--

DROP TABLE IF EXISTS `saved_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved_jobs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_id` bigint NOT NULL,
  `saved_at` datetime(6) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKe0hdgkw4tkup6grelv0q8g6qb` (`user_id`,`job_id`),
  KEY `FK8l8o6lpibh1n4cs469180onb1` (`job_id`),
  CONSTRAINT `FK5fc45yi5nwtm3y93nt4fcpln6` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK8l8o6lpibh1n4cs469180onb1` FOREIGN KEY (`job_id`) REFERENCES `job_postings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_jobs`
--

LOCK TABLES `saved_jobs` WRITE;
/*!40000 ALTER TABLE `saved_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `is_active` bit(1) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('ADMIN','CANDIDATE','RECRUITER') COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (_binary '','2026-04-06 23:25:02.000000',1,'2026-04-06 23:25:02.000000','recruiter@techviet.com','$2a$10$b1rFjy3YeYrvA9E/veBhKOejvvvE40PtnHDZkaZ5E44cfQcBTtXgu','RECRUITER'),(_binary '','2026-04-06 23:25:02.000000',2,'2026-04-06 23:25:02.000000','recruiter2@techviet.com','$2a$10$b1rFjy3YeYrvA9E/veBhKOejvvvE40PtnHDZkaZ5E44cfQcBTtXgu','RECRUITER'),(_binary '','2026-04-06 23:25:02.000000',3,'2026-04-06 23:25:02.000000','candidate@email.com','$2a$10$b1rFjy3YeYrvA9E/veBhKOejvvvE40PtnHDZkaZ5E44cfQcBTtXgu','CANDIDATE'),(_binary '','2026-04-06 23:25:02.000000',4,'2026-04-06 23:25:02.000000','candidate2@email.com','$2a$10$b1rFjy3YeYrvA9E/veBhKOejvvvE40PtnHDZkaZ5E44cfQcBTtXgu','CANDIDATE'),(_binary '','2026-04-06 23:25:02.000000',5,'2026-04-06 23:25:02.000000','candidate3@email.com','$2a$10$b1rFjy3YeYrvA9E/veBhKOejvvvE40PtnHDZkaZ5E44cfQcBTtXgu','CANDIDATE'),(_binary '','2026-04-06 23:25:02.000000',6,'2026-04-06 23:25:02.000000','admin@recruitpro.com','$2a$10$b1rFjy3YeYrvA9E/veBhKOejvvvE40PtnHDZkaZ5E44cfQcBTtXgu','ADMIN');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-07 11:23:14
