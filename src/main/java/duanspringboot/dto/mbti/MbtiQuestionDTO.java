package duanspringboot.dto.mbti;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiQuestionDTO {
    private Long id;
    private String questionText;
    private String optionA;
    private String optionB;
    private String dimension;
}
