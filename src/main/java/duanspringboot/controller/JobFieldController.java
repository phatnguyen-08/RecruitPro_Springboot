package duanspringboot.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import duanspringboot.entity.JobField;
import duanspringboot.repository.JobFieldRepository;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/job-fields")
@RequiredArgsConstructor
public class JobFieldController {

    private final JobFieldRepository jobFieldRepository;

    @GetMapping
    public ResponseEntity<List<JobField>> getAllJobFields() {
        List<JobField> jobFields = jobFieldRepository.findAllByOrderByNameAsc();
        return ResponseEntity.ok(jobFields);
    }
}
