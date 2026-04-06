package duanspringboot.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "mbti_answers")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "test_result_id", nullable = false)
    private MbtiTestResult testResult;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "question_id", nullable = false)
    private MbtiQuestion question;

    @Column(name = "selected_option", nullable = false, length = 1)
    private Character selectedOption; // 'A' hoặc 'B'
}
