package duanspringboot.service;

import duanspringboot.dto.admin.AdminDashboardResponse;
import duanspringboot.dto.admin.UserResponse;
import duanspringboot.entity.User;
import duanspringboot.enums.Role;
import duanspringboot.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;
    private final CompanyRepository companyRepository;
    private final JobPostingRepository jobPostingRepository;
    private final ApplicationRepository applicationRepository;
    private final InterviewRepository interviewRepository;

    public AdminDashboardResponse getDashboardStats() {
        List<User> allUsers = userRepository.findAll();

        long totalCandidates = allUsers.stream()
                .filter(u -> u.getRole() == Role.CANDIDATE)
                .count();

        long totalRecruiters = allUsers.stream()
                .filter(u -> u.getRole() == Role.RECRUITER)
                .count();

        return AdminDashboardResponse.builder()
                .totalUsers(allUsers.size())
                .totalCandidates(totalCandidates)
                .totalRecruiters(totalRecruiters)
                .totalCompanies(companyRepository.count())
                .totalJobPostings(jobPostingRepository.count())
                .totalApplications(applicationRepository.count())
                .totalInterviews(interviewRepository.count())
                .build();
    }

    public List<UserResponse> getAllUsers() {
        return userRepository.findAll().stream()
                .map(this::mapToUserResponse)
                .collect(Collectors.toList());
    }

    public UserResponse getUserById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        return mapToUserResponse(user);
    }

    @Transactional
    public UserResponse toggleUserStatus(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        user.setIsActive(!user.getIsActive());
        return mapToUserResponse(userRepository.save(user));
    }

    @Transactional
    public UserResponse updateUserRole(Long id, String role) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        if (user.getRole() == Role.ADMIN) {
            throw new RuntimeException("Không thể thay đổi vai trò của Admin");
        }

        try {
            Role newRole = Role.valueOf(role.toUpperCase());
            user.setRole(newRole);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Vai trò không hợp lệ: " + role);
        }

        return mapToUserResponse(userRepository.save(user));
    }

    @Transactional
    public void deleteUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        if (user.getRole() == Role.ADMIN) {
            throw new RuntimeException("Không thể xóa tài khoản Admin");
        }

        userRepository.delete(user);
    }

    public List<UserResponse> searchUsers(String keyword) {
        String searchTerm = keyword.toLowerCase();
        return userRepository.findAll().stream()
                .filter(u -> u.getEmail().toLowerCase().contains(searchTerm))
                .map(this::mapToUserResponse)
                .collect(Collectors.toList());
    }

    private UserResponse mapToUserResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .email(user.getEmail())
                .role(user.getRole())
                .isActive(user.getIsActive())
                .createdAt(user.getCreatedAt())
                .updatedAt(user.getUpdatedAt())
                .build();
    }
}
