package duanspringboot.controller;

import duanspringboot.dto.profile.CandidateProfileResponse;
import duanspringboot.security.CustomUserDetails;
import duanspringboot.service.ApplicationService;
import duanspringboot.service.CandidateProfileService;
import duanspringboot.service.CompanyService;
import duanspringboot.service.InterviewService;
import duanspringboot.service.JobPostingService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class ViewController {

    private final JobPostingService jobPostingService;
    private final CandidateProfileService candidateProfileService;
    private final ApplicationService applicationService;
    private final CompanyService companyService;
    private final InterviewService interviewService;

    // --- Trang chủ & Auth ---
    @GetMapping("/")
    public String index() {
        return "common/index";
    }

    @GetMapping("/login")
    public String login() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String register() {
        return "auth/register";
    }

    // --- Job Details ---
    @GetMapping("/jobs/{id}")
    public String jobDetail(@PathVariable Long id, Model model) {
        try {
            model.addAttribute("job", jobPostingService.getById(id));
        } catch (Exception e) {
            model.addAttribute("job", null);
        }
        return "common/job-detail";
    }

    // --- Candidate Views ---
    @GetMapping("/candidate/profile")
    public String candidateProfile(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails != null) {
            Long userId = ((CustomUserDetails) userDetails).getId();
            CandidateProfileResponse profile = candidateProfileService.getMyProfile(userId);
            System.out.println("DEBUG: Username: " + userDetails.getUsername() + " | Profile fetched: " + profile);
            model.addAttribute("profile", profile);
            model.addAttribute("userEmail", userDetails.getUsername());
        }
        return "candidate/profile";
    }

    // ✅ ĐÃ SỬA: Thêm @AuthenticationPrincipal và truyền data vào model
    @GetMapping("/candidate/applications")
    public String myApplications(
            @AuthenticationPrincipal UserDetails userDetails,
            Model model) {
        if (userDetails == null)
            return "redirect:/login";
        Long userId = ((CustomUserDetails) userDetails).getId();
        try {
            model.addAttribute("applications", applicationService.getMyApplications(userId));
        } catch (Exception e) {
            model.addAttribute("applications", List.of());
        }
        return "candidate/my-applications";
    }

    // --- Recruiter Views ---
    @GetMapping("/recruiter/company")
    public String companyInfo(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails != null) {
            try {
                Long userId = ((CustomUserDetails) userDetails).getId();
                model.addAttribute("company", companyService.getMyCompany(userId));
            } catch (Exception e) {
                model.addAttribute("company", null);
            }
        }
        return "recruiter/company-info";
    }

    @GetMapping("/recruiter/jobs")
    public String manageJobs() {
        return "recruiter/jobs/list";
    }

    @GetMapping("/recruiter/jobs/create")
    public String createJob() {
        return "recruiter/jobs/create-edit";
    }

    @GetMapping("/recruiter/jobs/edit/{id}")
    public String editJob(@PathVariable Long id, @AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails != null) {
            try {
                model.addAttribute("job", jobPostingService.getById(id));
            } catch (Exception e) {
                model.addAttribute("job", null);
            }
        }
        return "recruiter/jobs/create-edit";
    }

    @GetMapping("/recruiter/applications/job/{jobId}")
    public String viewApplicationsForJob(@PathVariable Long jobId, @AuthenticationPrincipal UserDetails userDetails,
            Model model) {
        if (userDetails != null) {
            Long userId = ((CustomUserDetails) userDetails).getId();
            try {
                model.addAttribute("job", jobPostingService.getById(jobId));
                model.addAttribute("applications", applicationService.getApplicationsByJob(jobId, userId));
            } catch (Exception e) {
                // Ignore or handle
            }
        }
        return "recruiter/applications/job-applications";
    }

    @GetMapping("/recruiter/pipeline")
    public String viewPipeline() {
        return "recruiter/applications/pipeline";
    }

    @GetMapping("/recruiter/interviews")
    public String viewInterviews(@AuthenticationPrincipal UserDetails userDetails, Model model) {
        if (userDetails != null) {
            Long userId = ((CustomUserDetails) userDetails).getId();
            try {
                model.addAttribute("interviews", interviewService.getMyInterviews(userId));
            } catch (Exception e) {
                model.addAttribute("interviews", List.of());
            }
        }
        return "recruiter/interviews/schedule";
    }
}