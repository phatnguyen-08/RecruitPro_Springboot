package duanspringboot.dto.Application;

import java.time.LocalDateTime;

import duanspringboot.enums.ApplicationStatus;
import lombok.Data;
import lombok.Builder;

@Data @Builder
public class ApplicationResponse {
    private Long id;
    private Long candidateId;
    private String candidateName;
    private Long jobId;
    private String jobTitle;
    private String companyName;
    private String coverLetter;
    private String resumeUrl; // HR bấm vào để xem CV
    private ApplicationStatus status;
    private LocalDateTime appliedAt;
}
