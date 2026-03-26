package duanspringboot.service;

import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordTest {
    @Test
    public void testPassword() {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String hash = "$2a$10$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW";
        System.out.println("----------------------------------------");
        System.out.println("Checking 'password123': " + encoder.matches("password123", hash));
        System.out.println("Checking 'password': " + encoder.matches("password", hash));
        System.out.println("Checking 'admin': " + encoder.matches("admin", hash));
        System.out.println("Checking '12345678': " + encoder.matches("12345678", hash));
        System.out.println("New hash for 'password123': " + encoder.encode("password123"));
        System.out.println("----------------------------------------");
    }
}
