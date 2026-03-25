package duanspringboot.controller;

import duanspringboot.dto.job.JobPostingRequest;
import duanspringboot.dto.job.JobPostingResponse;
import duanspringboot.enums.JobStatus;
import duanspringboot.security.CustomUserDetails;
import duanspringboot.service.JobPostingService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/jobs")
@RequiredArgsConstructor
public class JobPostingController {

    private final JobPostingService jobPostingService;

    // 1. Đăng tin mới (Recruiter)
    @PostMapping
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<JobPostingResponse> createJob(
            @Valid @RequestBody JobPostingRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(jobPostingService.create(request, userId));
    }

    // 2. Cập nhật tin (Recruiter)
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<JobPostingResponse> updateJob(
            @PathVariable Long id,
            @Valid @RequestBody JobPostingRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(jobPostingService.update(id, request, userId));
    }

    // 3. Xóa tin (Recruiter)
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<Void> deleteJob(
            @PathVariable Long id,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        jobPostingService.delete(id, userId);
        return ResponseEntity.noContent().build();
    }

    // 4. Tìm kiếm việc làm với filter (Công khai)
    @GetMapping("/search")
    public ResponseEntity<List<JobPostingResponse>> searchJobs(
            @RequestParam(required = false) String location,
            @RequestParam(required = false) Integer minSalary,
            @RequestParam(required = false) String title) {
        return ResponseEntity.ok(jobPostingService.searchJobs(location, minSalary, title));
    }

    // 5. Lấy tin tuyển dụng của chính mình (Recruiter quản lý)
    @GetMapping("/my-jobs")
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<List<JobPostingResponse>> getMyJobs(@AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(jobPostingService.getMyCompanyJobs(userId));
    }

    // 6. Lấy chi tiết tin (Công khai)
    @GetMapping("/{id}")
    public ResponseEntity<JobPostingResponse> getJobById(@PathVariable Long id) {
        return ResponseEntity.ok(jobPostingService.getById(id));
    }

    // 7. Đóng/Mở tin nhanh (Recruiter)
    @PatchMapping("/{id}/status")
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<JobPostingResponse> changeStatus(
            @PathVariable Long id,
            @RequestParam JobStatus status,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(jobPostingService.changeStatus(id, status, userId));
    }
}
