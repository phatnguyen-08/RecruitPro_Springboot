package duanspringboot.service;

import org.springframework.stereotype.Service;

import duanspringboot.dto.Application.ApplicationRequest;
import duanspringboot.dto.Application.ApplicationResponse;
import duanspringboot.dto.Application.ApplicationStatusRequest;
import duanspringboot.entity.Application;
import duanspringboot.entity.CandidateProfile;
import duanspringboot.entity.JobPosting;
import duanspringboot.enums.ApplicationStatus;
import duanspringboot.repository.ApplicationRepository;
import duanspringboot.repository.CandidateProfileRepository;
import duanspringboot.repository.JobPostingRepository;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ApplicationService {
    private final ApplicationRepository applicationRepository;
    private final JobPostingRepository jobPostingRepository;
    private final CandidateProfileRepository profileRepository;

    // 1. Ứng viên: Nộp đơn ứng tuyển
    public ApplicationResponse apply(ApplicationRequest request, Long userId) {
        CandidateProfile profile = profileRepository.findByUser_Id(userId)
                .orElseThrow(() -> new RuntimeException("Vui lòng cập nhật hồ sơ ứng viên trước khi ứng tuyển"));

        JobPosting job = jobPostingRepository.findById(request.getJobId())
                .orElseThrow(() -> new RuntimeException("Công việc không tồn tại"));

        // Kiểm tra xem đã ứng tuyển vào job này chưa
        if (applicationRepository.existsByCandidateIdAndJobPostingId(profile.getId(), job.getId())) {
            throw new RuntimeException("Bạn đã ứng tuyển vào công việc này rồi");
        }

        Application application = Application.builder()
                .candidate(profile)
                .jobPosting(job)
                .coverLetter(request.getCoverLetter())
                .status(ApplicationStatus.APPLIED) // Trạng thái ban đầu
                .build();

        return mapToResponse(applicationRepository.save(application));
    }

    // 2. Nhà tuyển dụng: Cập nhật trạng thái đơn (Pipeline: Screen, Interview, Offer,...)
    public ApplicationResponse changeStatus(Long applicationId, ApplicationStatusRequest request, Long userId) {
        Application application = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException("Đơn ứng tuyển không tồn tại"));
        
        // Kiểm tra quyền: Đảm bảo người cập nhật là chủ sở hữu tin tuyển dụng này
        if (!application.getJobPosting().getCompany().getUser().getId().equals(userId)) {
            throw new RuntimeException("Bạn không có quyền quản lý đơn ứng tuyển này");
        }

        application.setStatus(request.getStatus());
        return mapToResponse(applicationRepository.save(application));
    }

    // 3. Ứng viên: Xem danh sách các việc đã ứng tuyển
    public List<ApplicationResponse> getMyApplications(Long userId) {
        CandidateProfile profile = profileRepository.findByUser_Id(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy hồ sơ ứng viên"));
        
        return applicationRepository.findByCandidateId(profile.getId()).stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    // 4. Nhà tuyển dụng: Xem danh sách ứng viên của một tin tuyển dụng cụ thể
    public List<ApplicationResponse> getApplicationsByJob(Long jobId, Long userId) {
        JobPosting job = jobPostingRepository.findById(jobId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy tin tuyển dụng"));

        if (!job.getCompany().getUser().getId().equals(userId)) {
            throw new RuntimeException("Bạn không có quyền xem danh sách này");
        }

        return applicationRepository.findByJobPostingId(jobId).stream()
                .map(this::mapToResponse)
                .collect(Collectors.toList());
    }

    private ApplicationResponse mapToResponse(Application app) {
        return ApplicationResponse.builder()
                .id(app.getId())
                .candidateId(app.getCandidate().getId())
                .candidateName(app.getCandidate().getFullName())
                .jobId(app.getJobPosting().getId()) 
                .jobTitle(app.getJobPosting().getTitle())
                .companyName(app.getJobPosting().getCompany().getName())
                .coverLetter(app.getCoverLetter())
                .resumeUrl(app.getCandidate().getResumeUrl())
                .status(app.getStatus())
                .appliedAt(app.getAppliedAt())
                .build();
    }
}
