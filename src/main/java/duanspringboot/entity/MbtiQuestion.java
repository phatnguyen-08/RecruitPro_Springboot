package duanspringboot.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "mbti_questions")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "question_text", nullable = false, columnDefinition = "TEXT")
    private String questionText;

    @Column(name = "option_a", nullable = false, columnDefinition = "TEXT")
    private String optionA;

    @Column(name = "option_b", nullable = false, columnDefinition = "TEXT")
    private String optionB;

    @Column(name = "dimension", nullable = false, length = 10)
    private String dimension; // EI, SN, TF, JP

    @Column(name = "question_order")
    private Integer questionOrder; // Order of question in test
}
