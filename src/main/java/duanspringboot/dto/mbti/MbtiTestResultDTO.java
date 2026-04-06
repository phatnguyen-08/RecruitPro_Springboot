package duanspringboot.dto.mbti;

import lombok.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiTestResultDTO {
    private Long id;
    private String resultType;
    private Integer eScore;
    private Integer iScore;
    private Integer sScore;
    private Integer nScore;
    private Integer tScore;
    private Integer fScore;
    private Integer jScore;
    private Integer pScore;
    private String description;
    private String strengths;
    private String weaknesses;
    private String careers;
    private LocalDateTime takenAt;
}
