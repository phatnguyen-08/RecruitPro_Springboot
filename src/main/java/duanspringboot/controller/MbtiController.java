package duanspringboot.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import duanspringboot.dto.mbti.MbtiQuestionDTO;
import duanspringboot.dto.mbti.MbtiSubmitRequest;
import duanspringboot.dto.mbti.MbtiTestResultDTO;
import duanspringboot.security.CustomUserDetails;
import duanspringboot.service.MbtiQuestionService;
import duanspringboot.service.MbtiTestService;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MbtiController {

    private final MbtiQuestionService mbtiQuestionService;
    private final MbtiTestService mbtiTestService;

    // --- REST API Endpoints ---

    // API: Get all MBTI questions
    @GetMapping("/api/mbti/questions")
    @PreAuthorize("hasRole('CANDIDATE')")
    public ResponseEntity<List<MbtiQuestionDTO>> getQuestions() {
        return ResponseEntity.ok(mbtiQuestionService.getAllQuestions());
    }

    // API: Submit MBTI test
    @PostMapping("/api/mbti/submit")
    @PreAuthorize("hasRole('CANDIDATE')")
    public ResponseEntity<MbtiTestResultDTO> submitTest(
            @RequestBody MbtiSubmitRequest request,
            @AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        MbtiTestResultDTO result = mbtiTestService.submitTest(userId, request);
        return ResponseEntity.ok(result);
    }

    // API: Get user's MBTI result
    @GetMapping("/api/mbti/result")
    @PreAuthorize("hasRole('CANDIDATE')")
    public ResponseEntity<MbtiTestResultDTO> getResult(@AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        MbtiTestResultDTO result = mbtiTestService.getResultByUserId(userId);
        return ResponseEntity.ok(result);
    }

    // API: Check if user has taken the test
    @GetMapping("/api/mbti/has-result")
    @PreAuthorize("hasRole('CANDIDATE')")
    public ResponseEntity<Boolean> hasResult(@AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        boolean hasResult = mbtiTestService.hasTestResult(userId);
        return ResponseEntity.ok(hasResult);
    }

    // --- View Controllers ---

    // View: MBTI Test Page
    @GetMapping("/candidate/mbti-test")
    public String mbtiTestPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        
        Long userId = ((CustomUserDetails) userDetails).getId();
        boolean hasResult = mbtiTestService.hasTestResult(userId);
        if (hasResult) {
            return "redirect:/candidate/mbti-result";
        }
        
        // Lấy dữ liệu thực tế từ Database
        List<MbtiQuestionDTO> questions = mbtiQuestionService.getAllQuestions();
        
        // Giữ lại dòng log để bạn dễ debug xem DB trả về bao nhiêu câu
        System.out.println("DEBUG: Fetching MBTI questions from DB. Count: " + (questions != null ? questions.size() : 0));
        
        model.addAttribute("questions", questions);
        return "candidate/mbti-test";
    }

    // View: MBTI Result Page
    @GetMapping("/candidate/mbti-result")
    public String mbtiResultPage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails == null) {
            return "redirect:/login";
        }
        Long userId = ((CustomUserDetails) userDetails).getId();
        try {
            MbtiTestResultDTO result = mbtiTestService.getResultByUserId(userId);
            model.addAttribute("result", result);
        } catch (Exception e) {
            model.addAttribute("result", null);
        }
        return "candidate/mbti-result";
    }
    // API: Reset MBTI test
    @DeleteMapping("/api/mbti/reset")
    @PreAuthorize("hasRole('CANDIDATE')")
    public ResponseEntity<String> resetTest(@AuthenticationPrincipal UserDetails userDetails) {
        Long userId = ((CustomUserDetails) userDetails).getId();
        
        try {
            mbtiTestService.resetTestResult(userId);
            return ResponseEntity.ok("Đã xóa kết quả cũ thành công");
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Lỗi khi xóa kết quả: " + e.getMessage());
        }
    }
}