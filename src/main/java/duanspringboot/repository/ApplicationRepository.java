package duanspringboot.repository;

import duanspringboot.entity.Application;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ApplicationRepository extends JpaRepository<Application, Long> {
    List<Application> findByCandidateId(Long candidateId);
    List<Application> findByJobPostingId(Long jobPostingId);
    boolean existsByCandidateIdAndJobPostingId(Long candidateId, Long jobPostingId);
}
