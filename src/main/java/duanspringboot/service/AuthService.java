package duanspringboot.service;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import duanspringboot.dto.auth.AuthResponse;
import duanspringboot.dto.auth.LoginRequest;
import duanspringboot.dto.auth.RegisterRequest;
import duanspringboot.enums.Role;
import duanspringboot.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import duanspringboot.entity.User;
import duanspringboot.util.JwtUtil;


@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtUtil jwtUtil;
    private final AuthenticationManager authenticationManager;

    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail()))
            throw new RuntimeException("Email đã tồn tại");

        User user = User.builder()
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(request.getRole())
                .build();
        userRepository.save(user);

        String token = jwtUtil.generateToken(user.getEmail(), user.getRole().name());
        String message = null;
        if (request.getRole() == Role.RECRUITER) {
            message = "Đăng ký thành công! Vui lòng cung cấp thông tin công ty để được phê duyệt.";
        }
        return AuthResponse.builder()
                .token(token)
                .userId(user.getId())
                .email(user.getEmail())
                .role(user.getRole().name())
                .message(message)
                .build();
    }

    public AuthResponse login(LoginRequest request) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getEmail(), request.getPassword())
        );

        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Email không tồn tại"));

        String token = jwtUtil.generateToken(user.getEmail(), user.getRole().name());
        return AuthResponse.builder()
                .token(token)
                .userId(user.getId())
                .email(user.getEmail())
                .role(user.getRole().name())
                .build();
    }

    public AuthResponse generateTokenForUser(User user) {
        String token = jwtUtil.generateToken(user.getEmail(), user.getRole().name());
        return AuthResponse.builder()
                .token(token)
                .userId(user.getId())
                .email(user.getEmail())
                .role(user.getRole().name())
                .build();
    }
}