package duanspringboot.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

import duanspringboot.dto.mbti.MbtiQuestionDTO;
import duanspringboot.entity.MbtiQuestion;
import duanspringboot.repository.MbtiQuestionRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MbtiQuestionService {

    private final MbtiQuestionRepository mbtiQuestionRepository;

    @Transactional(readOnly = true)
    public List<MbtiQuestionDTO> getAllQuestions() {
        return mbtiQuestionRepository.findAllByOrderByQuestionOrderAsc()
                .stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }

    private MbtiQuestionDTO toDTO(MbtiQuestion question) {
        return MbtiQuestionDTO.builder()
                .id(question.getId())
                .questionText(question.getQuestionText())
                .optionA(question.getOptionA())
                .optionB(question.getOptionB())
                .dimension(question.getDimension())
                .build();
    }
}