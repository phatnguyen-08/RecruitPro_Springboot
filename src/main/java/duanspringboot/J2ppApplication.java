package duanspringboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.oauth2.client.servlet.OAuth2ClientAutoConfiguration;

import duanspringboot.repository.MbtiQuestionRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;

@SpringBootApplication(exclude = {OAuth2ClientAutoConfiguration.class})
public class J2ppApplication {

	public static void main(String[] args) {
		SpringApplication.run(J2ppApplication.class, args);
	}

	@Bean
	public CommandLineRunner debugMbtiData(MbtiQuestionRepository repository) {
		return args -> {
			long count = repository.count();
			System.out.println("MBTI DATA CHECK: Table 'mbti_questions' has " + count + " records.");
		};
	}

}

