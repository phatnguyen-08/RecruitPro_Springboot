package duanspringboot.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class EmailService {

    public void sendInterviewInvitation(String toEmail, String candidateName, String jobTitle, String time, String location) {
        String subject = "Mời phỏng vấn công việc: " + jobTitle;
        String content = String.format(
            "Chào %s,\n\nBạn có lịch phỏng vấn cho vị trí %s vào lúc %s.\nĐịa điểm/Link: %s\n\nChúc bạn thành công!",
            candidateName, jobTitle, time, location
        );

        // Giả lập gửi email
        log.info("--- Gửi email thành công tới: {} ---", toEmail);
        log.info("Tiêu đề: {}", subject);
        log.info("Nội dung: \n{}", content);
        log.info("------------------------------------------");
    }
}
