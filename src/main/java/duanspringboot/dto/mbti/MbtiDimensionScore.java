package duanspringboot.dto.mbti;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MbtiDimensionScore {
    private String dimension; // EI, SN, TF, JP
    private Character firstType; // E, S, T, J
    private Character secondType; // I, N, F, P
    private Integer firstScore;
    private Integer secondScore;
}
