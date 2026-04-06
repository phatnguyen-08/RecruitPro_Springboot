package duanspringboot.dto.mbti;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiAnswerRequest {
    private Long questionId;
    private Character selectedOption; // 'A' hoặc 'B'
}
