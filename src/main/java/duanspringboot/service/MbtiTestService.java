package duanspringboot.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

import duanspringboot.dto.mbti.MbtiAnswerRequest;
import duanspringboot.dto.mbti.MbtiSubmitRequest;
import duanspringboot.dto.mbti.MbtiTestResultDTO;
import duanspringboot.entity.MbtiAnswer;
import duanspringboot.entity.MbtiQuestion;
import duanspringboot.entity.MbtiTestResult;
import duanspringboot.entity.User;
import duanspringboot.repository.MbtiAnswerRepository;
import duanspringboot.repository.MbtiQuestionRepository;
import duanspringboot.repository.MbtiTestResultRepository;
import duanspringboot.repository.UserRepository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MbtiTestService {

    private final MbtiTestResultRepository mbtiTestResultRepository;
    private final MbtiQuestionRepository mbtiQuestionRepository;
    private final MbtiAnswerRepository mbtiAnswerRepository;
    private final UserRepository userRepository;

    // MBTI type descriptions
    private static final Map<String, MbtiTypeDescription> MBTI_DESCRIPTIONS = new HashMap<>();

    static {
        MBTI_DESCRIPTIONS.put("INTJ", new MbtiTypeDescription(
            "Nhà kiến tạo",
            "INTJ là những người có tư duy chiến lược, độc lập và quyết đoán. Họ có khả năng nhìn thấy bức tranh toàn cảnh và lập kế hoạch dài hạn chi tiết.",
            "Tư duy chiến lược, quyết đoán, độc lập, có tầm nhìn",
            "Có thể cứng nhắc, khó gần, quá cầu toàn",
            "Nhà khoa học, lập trình viên, nhà quản lý, nhà phân tích tài chính, kiến trúc sư"
        ));
        MBTI_DESCRIPTIONS.put("INTP", new MbtiTypeDescription(
            "Nhà tư tưởng",
            "INTP là những người sáng tạo, có tư duy logic và thích phân tích. Họ luôn tìm kiếm sự hiểu biết sâu sắc về cách mọi thứ hoạt động.",
            "Sáng tạo, logic, khách quan, cầu tiến",
            "Có thể xa rời thực tế, thiếu sự thực dụng, dễ bị phân tâm",
            "Nhà khoa học, lập trình viên, nhà phân tích, nhà nghiên cứu, nhà phát triển game"
        ));
        MBTI_DESCRIPTIONS.put("ENTJ", new MbtiTypeDescription(
            "Nhà chỉ huy",
            "ENTJ là những nhà lãnh đạo bẩm sinh với tầm nhìn rõ ràng. Họ quyết đoán, tự tin và có khả năng tổ chức xuất sắc.",
            "Lãnh đạo, quyết đoán, có tầm nhìn, tổ chức tốt",
            "Có thể áp đặt, thiếu kiên nhẫn, coi nhẹ cảm xúc",
            "Giám đốc điều hành, nhà quản lý, luật sư, nhà tư vấn kinh doanh"
        ));
        MBTI_DESCRIPTIONS.put("ENTP", new MbtiTypeDescription(
            "Nhà tranh luận",
            "ENTP là những người sáng tạo, thông minh và thích tranh luận. Họ thích thử thách và tìm kiếm giải pháp mới.",
            "Sáng tạo, linh hoạt, thuyết phục, đa tài",
            "Có thể gây tranh cãi, thiếu kiên nhẫn với chi tiết",
            "Doanh nhân, luật sư, nhà tư vấn, nhà marketing, nhà phát triển sản phẩm"
        ));
        MBTI_DESCRIPTIONS.put("ISTJ", new MbtiTypeDescription(
            "Người thực hiện",
            "ISTJ là những người đáng tin cậy, có trách nhiệm và thực tế. Họ coi trọng truyền thống và cam kết.",
            "Đáng tin cậy, có trách nhiệm, chi tiết, thực tế",
            "Có thể cứng nhắc, khó thích nghi, quá nghiêm túc",
            "Kế toán, nhân viên ngân hàng, kiểm toán, quản trị viên, cảnh sát"
        ));
        MBTI_DESCRIPTIONS.put("ISFJ", new MbtiTypeDescription(
            "Người bảo vệ",
            "ISFJ là những người ấm áp, tận tâm và đáng tin cậy. Họ luôn sẵn sàng giúp đỡ người khác.",
            "Tận tâm, ấm áp, kiên nhẫn, đáng tin cậy",
            "Có thể quá hy sinh, khó từ chối, không biết đề cao bản thân",
            "Y tá, giáo viên, nhân viên xã hội, quản trị viên, nhân sự"
        ));
        MBTI_DESCRIPTIONS.put("ESTJ", new MbtiTypeDescription(
            "Nhà điều hành",
            "ESTJ là những người thực tế, có tổ chức và quyết đoán. Họ thích duy trì trật tự và hiệu quả.",
            "Tổ chức tốt, quyết đoán, thực tế, đáng tin cậy",
            "Có thể cứng nhắc, áp đặt, thiếu linh hoạt",
            "Quản lý, giám đốc nhân sự, luật sư, quan tòa, nhân viên ngân hàng"
        ));
        MBTI_DESCRIPTIONS.put("ESFJ", new MbtiTypeDescription(
            "Người hỗ trợ",
            "ESFJ là những người hòa đồng, tận tâm và quan tâm đến người khác. Họ tạo ra môi trường hài hòa.",
            "Hòa đồng, tận tâm, chu đáo, có trách nhiệm",
            "Có thể quá nhạy cảm, khó từ chối, cần sự công nhận",
            "Y tá, giáo viên, nhân viên sự kiện, nhân sự, tư vấn viên"
        ));
        MBTI_DESCRIPTIONS.put("INFJ", new MbtiTypeDescription(
            "Người ủng hộ",
            "INFJ là những người có trực giác mạnh, lý tưởng và thấu cảm. Họ luôn tìm cách giúp đỡ người khác phát triển.",
            "Thấu cảm, có tầm nhìn, lý tưởng, sáng tạo",
            "Có thể quá lý tưởng, dễ kiệt sức, khó từ chối",
            "Tư vấn viên, nhà văn, nhà hoạt động xã hội, giáo viên, nhà tâm lý học"
        ));
        MBTI_DESCRIPTIONS.put("INFP", new MbtiTypeDescription(
            "Người hòa giải",
            "INFP là những người lý tưởng, sáng tạo và thấu cảm. Họ luôn tìm kiếm ý nghĩa và mục đích trong cuộc sống.",
            "Sáng tạo, thấu cảm, lý tưởng, cởi mở",
            "Có thể quá lý tưởng, dễ bị tổn thương, khó ra quyết định",
            "Nhà văn, nghệ sĩ, nhà tư vấn, nhà thiết kế, nhân viên NGO"
        ));
        MBTI_DESCRIPTIONS.put("ENFJ", new MbtiTypeDescription(
            "Người dẫn dắt",
            "ENFJ là những người có khả năng lãnh đạo tự nhiên, thấu cảm và truyền cảm hứng. Họ giúp người khác phát huy tiềm năng.",
            "Lãnh đạo, thấu cảm, truyền cảm hứng, tổ chức tốt",
            "Có thể quá hy sinh, nhạy cảm với phê bình, thao túng",
            "Giáo viên, nhà tư vấn, nhân sự, nhà quản lý, huấn luyện viên"
        ));
        MBTI_DESCRIPTIONS.put("ENFP", new MbtiTypeDescription(
            "Người vận động",
            "ENFP là những người nhiệt huyết, sáng tạo và xã hội. Họ luôn tìm kiếm những khả năng mới.",
            "Nhiệt huyết, sáng tạo, thấu cảm, linh hoạt",
            "Có thể thiếu kiên nhẫn, dễ mất tập trung, quá lý tưởng",
            "Nhà báo, nhà sáng tạo nội dung, diễn viên, nhà tư vấn, nhà marketing"
        ));
        MBTI_DESCRIPTIONS.put("ISTP", new MbtiTypeDescription(
            "Nhà thợ",
            "ISTP là những người thực tế, linh hoạt và thích hành động. Họ có khả năng giải quyết vấn đề xuất sắc.",
            "Thực tế, linh hoạt, điềm tĩnh, giải quyết vấn đề",
            "Có thể khó biểu lộ cảm xúc, thích rủi ro, thiếu kiên nhẫn",
            "Kỹ sư, thợ cơ khí, lập trình viên, cảnh sát, vận động viên"
        ));
        MBTI_DESCRIPTIONS.put("ISFP", new MbtiTypeDescription(
            "Người nghệ sĩ",
            "ISFP là những người nhạy cảm, nghệ thuật và tận tâm. Họ thể hiện bản thân qua hành động hơn lời nói.",
            "Nghệ thuật, nhạy cảm, tận tâm, linh hoạt",
            "Có thể quá nhạy cảm, khó ra quyết định, thiếu sự định hướng",
            "Nghệ sĩ, nhà thiết kế, nhiếp ảnh gia, y tá, nhân viên phục vụ"
        ));
        MBTI_DESCRIPTIONS.put("ESTP", new MbtiTypeDescription(
            "Nhà doanh nghiệp",
            "ESTP là những người hành động, thực tế và thích phiêu lưu. Họ nhanh nhẹn và thích giải quyết vấn đề ngay lập tức.",
            "Hành động, nhanh nhẹn, thuyết phục, thực tế",
            "Có thể thiếu kiên nhẫn, thích rủi ro, thiếu sự cam kết dài hạn",
            "Doanh nhân, sales, cảnh sát, vận động viên, nhà môi giới"
        ));
        MBTI_DESCRIPTIONS.put("ESFP", new MbtiTypeDescription(
            "Người trình diễn",
            "ESFP là những người năng động, vui vẻ và xã hội. Họ mang niềm vui và năng lượng tích cực đến mọi người xung quanh.",
            "Năng động, vui vẻ, xã hội, thực tế",
            "Có thể thiếu sự tập trung, tránh xung đột, thiếu kế hoạch dài hạn",
            "Diễn viên, MC, nhân viên sự kiện, nhân viên bán hàng, hướng dẫn viên"
        ));
    }

    @Transactional
    public MbtiTestResultDTO submitTest(Long userId, MbtiSubmitRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        // Check if user already has a result
        if (mbtiTestResultRepository.existsByUser_Id(userId)) {
            mbtiTestResultRepository.findByUser_Id(userId).ifPresent(mbtiTestResultRepository::delete);
        }

        // Calculate scores
        Map<String, Integer> scores = calculateScores(request.getAnswers());

        // Determine MBTI type
        String mbtiType = determineMbtiType(scores);

        // Get description
        MbtiTypeDescription description = MBTI_DESCRIPTIONS.get(mbtiType);

        // Save result
        MbtiTestResult result = MbtiTestResult.builder()
                .user(user)
                .resultType(mbtiType)
                .eScore(scores.get("E"))
                .iScore(scores.get("I"))
                .sScore(scores.get("S"))
                .nScore(scores.get("N"))
                .tScore(scores.get("T"))
                .fScore(scores.get("F"))
                .jScore(scores.get("J"))
                .pScore(scores.get("P"))
                .description(description.description)
                .strengths(description.strengths)
                .weaknesses(description.weaknesses)
                .careerFits(description.careers)
                .build();

        result = mbtiTestResultRepository.save(result);

        // Save individual answers
        for (MbtiAnswerRequest answerRequest : request.getAnswers()) {
            MbtiQuestion question = mbtiQuestionRepository.findById(answerRequest.getQuestionId())
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy câu hỏi"));

            MbtiAnswer answer = MbtiAnswer.builder()
                    .testResult(result)
                    .question(question)
                    .selectedOption(answerRequest.getSelectedOption())
                    .build();
            mbtiAnswerRepository.save(answer);
        }

        return toDTO(result);
    }

    @Transactional(readOnly = true)
    public MbtiTestResultDTO getResultByUserId(Long userId) {
        MbtiTestResult result = mbtiTestResultRepository.findByUser_Id(userId)
                .orElseThrow(() -> new RuntimeException("Chưa có kết quả trắc nghiệm MBTI"));
        return toDTO(result);
    }

    @Transactional(readOnly = true)
    public boolean hasTestResult(Long userId) {
        return mbtiTestResultRepository.existsByUser_Id(userId);
    }

    private Map<String, Integer> calculateScores(List<MbtiAnswerRequest> answers) {
        Map<String, Integer> scores = new HashMap<>();
        scores.put("E", 0);
        scores.put("I", 0);
        scores.put("S", 0);
        scores.put("N", 0);
        scores.put("T", 0);
        scores.put("F", 0);
        scores.put("J", 0);
        scores.put("P", 0);

        for (MbtiAnswerRequest answer : answers) {
            MbtiQuestion question = mbtiQuestionRepository.findById(answer.getQuestionId())
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy câu hỏi"));

            String selectedOption = answer.getSelectedOption() != null ? String.valueOf(answer.getSelectedOption()).toUpperCase() : "A";
            String dimension = question.getDimension() != null ? question.getDimension().toUpperCase() : "EI";

            if (selectedOption.equals("A")) {
                scores.put(dimension.substring(0, 1), scores.get(dimension.substring(0, 1)) + 1);
            } else if (selectedOption.equals("B")) {
                scores.put(dimension.substring(1, 2), scores.get(dimension.substring(1, 2)) + 1);
            }
        }

        return scores;
    }

    private String determineMbtiType(Map<String, Integer> scores) {
        StringBuilder mbtiType = new StringBuilder();

        mbtiType.append(scores.get("E") >= scores.get("I") ? "E" : "I");
        mbtiType.append(scores.get("S") >= scores.get("N") ? "S" : "N");
        mbtiType.append(scores.get("T") >= scores.get("F") ? "T" : "F");
        mbtiType.append(scores.get("J") >= scores.get("P") ? "J" : "P");

        return mbtiType.toString();
    }

    private MbtiTestResultDTO toDTO(MbtiTestResult result) {
        return MbtiTestResultDTO.builder()
                .id(result.getId())
                .resultType(result.getResultType())
                .eScore(result.getEScore())
                .iScore(result.getIScore())
                .sScore(result.getSScore())
                .nScore(result.getNScore())
                .tScore(result.getTScore())
                .fScore(result.getFScore())
                .jScore(result.getJScore())
                .pScore(result.getPScore())
                .description(result.getDescription())
                .strengths(result.getStrengths())
                .weaknesses(result.getWeaknesses())
                .careers(result.getCareerFits())
                .takenAt(result.getTakenAt())
                .build();
    }

    // Inner class for MBTI descriptions
    private static class MbtiTypeDescription {
        String title;
        String description;
        String strengths;
        String weaknesses;
        String careers;

        MbtiTypeDescription(String title, String description, String strengths, String weaknesses, String careers) {
            this.title = title;
            this.description = description;
            this.strengths = strengths;
            this.weaknesses = weaknesses;
            this.careers = careers;
        }
    }
    @Transactional
public void resetTestResult(Long userId) {
    // 1. Xóa các câu trả lời cũ của user này (nếu bảng mbti_answers của bạn có tham chiếu đến user_id)
    // mbtiAnswerRepository.deleteByUserId(userId); 
    
    // 2. Xóa kết quả bài test cũ
    mbtiTestResultRepository.deleteByUserId(userId); // Cần đảm bảo Repository của bạn có hàm này
}
}