package duanspringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import duanspringboot.entity.MbtiAnswer;

@Repository
public interface MbtiAnswerRepository extends JpaRepository<MbtiAnswer, Long> {
}