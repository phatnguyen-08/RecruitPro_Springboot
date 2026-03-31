package duanspringboot.repository;

import duanspringboot.entity.Interview;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface InterviewRepository extends JpaRepository<Interview, Long> {
    List<Interview> findByApplicationId(Long applicationId);
    // Tìm các cuộc phỏng vấn liên quan đến HR cụ thể (thông qua Application -> JobPosting -> Company -> User)
    List<Interview> findByApplicationJobPostingCompanyUserId(Long userId);
}
