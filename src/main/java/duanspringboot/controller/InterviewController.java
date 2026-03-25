package duanspringboot.controller;

import duanspringboot.dto.interview.InterviewRequest;
import duanspringboot.dto.interview.InterviewResponse;
import duanspringboot.enums.InterviewResult;
import duanspringboot.security.CustomUserDetails;
import duanspringboot.service.InterviewService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/interviews")
@RequiredArgsConstructor
public class InterviewController {

    private final InterviewService interviewService;

    // 1. Tạo lịch phỏng vấn (Recruiter)
    @PostMapping
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<InterviewResponse> scheduleInterview(
            @Valid @RequestBody InterviewRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long recruiterId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(interviewService.scheduleInterview(request, recruiterId));
    }

    // 2. Lấy danh sách phỏng vấn của tôi (Recruiter)
    @GetMapping("/my")
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<List<InterviewResponse>> getMyInterviews(@AuthenticationPrincipal UserDetails userDetails) {
        Long recruiterId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(interviewService.getMyInterviews(recruiterId));
    }

    // 3. Cập nhật kết quả phỏng vấn (Recruiter)
    @PatchMapping("/{id}/result")
    @PreAuthorize("hasRole('RECRUITER')")
    public ResponseEntity<InterviewResponse> updateResult(
            @PathVariable Long id,
            @RequestParam InterviewResult result,
            @RequestParam(required = false) String note,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long recruiterId = ((CustomUserDetails) userDetails).getId();
        return ResponseEntity.ok(interviewService.updateResult(id, result, note, recruiterId));
    }
}
