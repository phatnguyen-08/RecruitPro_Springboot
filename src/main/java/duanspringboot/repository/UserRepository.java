package duanspringboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import duanspringboot.entity.User;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    // Tìm user bằng email (Dùng cho chức năng Đăng nhập)
    Optional<User> findByEmail(String email);
    // Kiểm tra xem email đã tồn tại chưa (Dùng cho chức năng Đăng ký)
    boolean existsByEmail(String email);
}
