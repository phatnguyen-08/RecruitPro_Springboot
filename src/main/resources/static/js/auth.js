// auth.js - Login and Registration logic

document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');

    if (loginForm) {
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;

            try {
                const response = await fetch('/api/auth/login', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ email, password })
                });

                const data = await response.json();

                if (response.ok) {
                    // 1. Lưu JWT Token
                    localStorage.setItem('jwt_token', data.token);
                    document.cookie = `jwt_token=${data.token}; path=/; max-age=86400; SameSite=Lax`;
                    
                    // 2. Chuẩn bị thông tin User
                    const userInfo = {
                        email: data.email,
                        username: data.email.split('@')[0],
                        role: data.role
                    };
                    localStorage.setItem('user_info', JSON.stringify(userInfo));
                    
                    alert('Đăng nhập thành công!');

                    // 3. CHUYỂN HƯỚNG THEO ROLE
                    // Hỗ trợ cả trường hợp role có tiền tố ROLE_ hoặc không
                    const userRole = data.role.replace('ROLE_', '');
                    
                    if (userRole === 'RECRUITER' || userRole === 'COMPANY') {
                        window.location.replace('/recruiter/jobs');
                    } else if (userRole === 'CANDIDATE') {
                        window.location.replace('/');
                    } else {
                        window.location.replace('/');
                    }
                    
                } else {
                    alert('Đăng nhập thất bại: ' + (data.message || 'Sai thông tin đăng nhập'));
                }
            } catch (error) {
                console.error('Login error:', error);
                alert('Có lỗi xảy ra, vui lòng thử lại sau');
            }
        });
    }

    if (registerForm) {
        registerForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const role = document.getElementById('role').value;

            try {
                const response = await fetch('/api/auth/register', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ email, password, role })
                });

                const data = await response.json();

                if (response.ok) {
                    alert('Đăng ký thành công! Hãy đăng nhập để bắt đầu.');
                    window.location.href = '/login';
                } else {
                    alert('Đăng ký thất bại: ' + (data.message || 'Dữ liệu không hợp lệ'));
                }
            } catch (error) {
                console.error('Registration error:', error);
                alert('Có lỗi xảy ra, vui lòng thử lại sau');
            }
        });
    }
});
