package duanspringboot.dto.Application;

import java.time.LocalDate;
import java.time.LocalDateTime;

import duanspringboot.enums.ApplicationStatus;
import lombok.Data;
import lombok.Builder;

@Data @Builder
public class ApplicationResponse {
    // --- Thông tin đơn ứng tuyển ---
    private Long id;
    private Long candidateId;
    private Long jobId;
    private String jobTitle;
    private String companyName;
    private String coverLetter;
    private ApplicationStatus status;
    private LocalDateTime appliedAt;

    // --- Thông tin cá nhân ứng viên ---
    private String candidateName;
    private String candidateEmail;
    private String candidatePhone;
    private String candidateHeadline;
    private String candidateSummary;
    private String candidateAddress; 
    private LocalDate candidateDob;
    private String candidateGender; 
    private String resumeUrl; // URL trỏ đến file CV của ứng viên
    private String avatarUrl; // URL trỏ đến ảnh đại diện của ứng viên
}
