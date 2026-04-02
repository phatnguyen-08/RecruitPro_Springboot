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
            const role = document.querySelector('input[name="role"]:checked').value;

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

// ==================== LOGIN GUIDE POPUP ====================

function showLoginGuide() {
    const popup = document.getElementById('loginGuidePopup');
    if (popup) {
        popup.classList.remove('hidden');
    }
}

function closeLoginGuide() {
    const popup = document.getElementById('loginGuidePopup');
    if (popup) {
        popup.classList.add('hidden');
    }
}

// ==================== GOOGLE GUIDE POPUP ====================

function showGoogleGuide() {
    const popup = document.getElementById('googleGuidePopup');
    if (popup) {
        // Set current redirect URI
        const redirectUriEl = document.getElementById('googleRedirectUri');
        if (redirectUriEl) {
            redirectUriEl.textContent = window.location.origin + '/login/oauth2/code/google';
        }
        popup.classList.remove('hidden');
    }
}

function closeGoogleGuide() {
    const popup = document.getElementById('googleGuidePopup');
    if (popup) {
        popup.classList.add('hidden');
    }
}

// ==================== POPUP EVENT LISTENERS ====================

document.addEventListener('DOMContentLoaded', function() {
    // Login guide popup overlay click
    const loginPopup = document.getElementById('loginGuidePopup');
    if (loginPopup) {
        const loginOverlay = loginPopup.querySelector('.login-guide-overlay');
        if (loginOverlay) {
            loginOverlay.addEventListener('click', closeLoginGuide);
        }
    }

    // Google guide popup overlay click
    const googlePopup = document.getElementById('googleGuidePopup');
    if (googlePopup) {
        const googleOverlay = googlePopup.querySelector('.login-guide-overlay');
        if (googleOverlay) {
            googleOverlay.addEventListener('click', closeGoogleGuide);
        }
    }

    // Show guide when clicking login button with empty fields
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        const loginBtn = document.getElementById('loginBtn');
        if (loginBtn) {
            loginBtn.addEventListener('click', function(e) {
                const email = document.getElementById('email').value.trim();
                const password = document.getElementById('password').value;

                // If fields are empty, show guide popup
                if (!email || !password) {
                    e.preventDefault();
                    showLoginGuide();
                }
            });
        }
    }

    // Show Google guide when clicking Google login button
    const googleBtn = document.querySelector('.btn-google');
    if (googleBtn) {
        googleBtn.addEventListener('click', function(e) {
            e.preventDefault();
            showGoogleGuide();
        });
    }
});
