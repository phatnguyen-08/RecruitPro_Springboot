package duanspringboot.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.time.LocalDateTime;

@Entity
@Table(name = "mbti_test_results")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiTestResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "result_type", nullable = false, length = 10)
    private String resultType; // INTJ, ENFP, v.v.

    @Column(name = "e_score")
    private Integer eScore; // 0-100

    @Column(name = "i_score")
    private Integer iScore; // 0-100

    @Column(name = "s_score")
    private Integer sScore; // 0-100

    @Column(name = "n_score")
    private Integer nScore; // 0-100

    @Column(name = "t_score")
    private Integer tScore; // 0-100

    @Column(name = "f_score")
    private Integer fScore; // 0-100

    @Column(name = "j_score")
    private Integer jScore; // 0-100

    @Column(name = "p_score")
    private Integer pScore; // 0-100

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "strengths", columnDefinition = "TEXT")
    private String strengths;

    @Column(name = "weaknesses", columnDefinition = "TEXT")
    private String weaknesses;

    @Column(name = "career_fits", columnDefinition = "TEXT")
    private String careerFits;

    @CreationTimestamp
    @Column(name = "taken_at", nullable = false, updatable = false)
    private LocalDateTime takenAt;
}
