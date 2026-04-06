package duanspringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import duanspringboot.entity.MbtiTestResult;

import java.util.Optional;

@Repository
public interface MbtiTestResultRepository extends JpaRepository<MbtiTestResult, Long> {
    Optional<MbtiTestResult> findByUser_Id(Long userId);
    boolean existsByUser_Id(Long userId);
    void deleteByUserId(Long userId); // Cần đảm bảo hàm này tồn tại nếu bạn muốn xóa kết quả theo userId
}