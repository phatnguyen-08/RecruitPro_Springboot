package duanspringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import duanspringboot.entity.MbtiQuestion;

import java.util.List;

@Repository
public interface MbtiQuestionRepository extends JpaRepository<MbtiQuestion, Long> {
    List<MbtiQuestion> findByDimensionOrderByQuestionOrderAsc(String dimension);
    List<MbtiQuestion> findAllByOrderByQuestionOrderAsc();
}