package duanspringboot.repository;

import duanspringboot.entity.JobPosting;
import duanspringboot.enums.JobStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface JobPostingRepository extends JpaRepository<JobPosting, Long> {
    List<JobPosting> findByCompanyId(Long companyId);
    List<JobPosting> findByStatus(JobStatus status);

    @Query("SELECT j FROM JobPosting j WHERE j.status = :status " +
           "AND (:location IS NULL OR j.location LIKE %:location%) " +
           "AND (:minSalary IS NULL OR j.salaryMax >= :minSalary) " +
           "AND (:title IS NULL OR j.title LIKE %:title%)")
    List<JobPosting> filterJobs(
            @Param("status") JobStatus status,
            @Param("location") String location,
            @Param("minSalary") Integer minSalary,
            @Param("title") String title);
}
