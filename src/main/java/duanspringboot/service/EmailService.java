package duanspringboot.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class EmailService {

    public void sendInterviewInvitation(String toEmail, String candidateName, String jobTitle, String time,
            String location) {
        // Demo mode - In production, configure Spring Mail with SMTP credentials
        log.info("=== EMAIL NOTIFICATION (Demo Mode) ===");
        log.info("To: {}", toEmail);
        log.info("Subject: Mời phỏng vấn công việc: {}", jobTitle);
        log.info("Content:");
        log.info("Chào {},\n", candidateName);
        log.info("Bạn có lịch phỏng vấn cho vị trí {} vào lúc {}.", jobTitle, time);
        log.info("Địa điểm/Link: {}", location);
        log.info("Chúc bạn thành công!");
        log.info("========================================");
    }

    public void sendApplicationStatusUpdate(String toEmail, String candidateName, String jobTitle, String status) {
        log.info("=== EMAIL NOTIFICATION (Demo Mode) ===");
        log.info("To: {}", toEmail);
        log.info("Subject: Cập nhật trạng thái ứng tuyển: {}", jobTitle);
        log.info("Content:");
        log.info("Chào {},\n", candidateName);
        log.info("Đơn ứng tuyển vị trí {} của bạn đã được cập nhật trạng thái: {}", jobTitle, status);
        log.info("Vui lòng đăng nhập vào hệ thống để xem chi tiết.");
        log.info("========================================");
    }
}
