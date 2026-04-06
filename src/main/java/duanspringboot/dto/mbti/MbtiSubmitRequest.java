package duanspringboot.dto.mbti;

import lombok.*;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiSubmitRequest {
    private List<MbtiAnswerRequest> answers;
}
