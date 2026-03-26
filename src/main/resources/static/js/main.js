// main.js - Xử lý giao diện dùng chung và xác thực

/**
 * Lấy thông tin người dùng từ localStorage
 */
function getUserInfo() {
    const info = localStorage.getItem('user_info');
    try {
        return info ? JSON.parse(info) : null;
    } catch (e) {
        console.error("Lỗi parse user_info:", e);
        return null;
    }
}

/**
 * Kiểm tra xem người dùng đã đăng nhập chưa
 */
function isLoggedIn() {
    return localStorage.getItem('jwt_token') !== null;
}

/**
 * Cập nhật thanh điều hướng (Navbar) dựa trên trạng thái đăng nhập
 */
function updateNavbar() {
    const loginBtn = document.getElementById('nav-login-btn');
    const registerBtn = document.getElementById('nav-register-btn');
    const userDropdown = document.getElementById('nav-user-dropdown');
    const userNameDisplay = document.getElementById('nav-username');
    
    const recruiterMenu = document.getElementById('nav-recruiter-menu');
    const candidateMenu = document.getElementById('nav-candidate-menu');

    const user = getUserInfo();
    const token = localStorage.getItem('jwt_token');

    if (token && user) {
        // Đã đăng nhập: Ẩn nút đăng nhập/đăng ký
        if (loginBtn) loginBtn.classList.add('hidden');
        if (registerBtn) registerBtn.classList.add('hidden');
        
        // Hiện dropdown người dùng và tên
        if (userDropdown) userDropdown.classList.remove('hidden');
        if (userNameDisplay) {
            userNameDisplay.textContent = user.username || user.email.split('@')[0];
        }

        // Kiểm tra Role để hiển thị Menu tương ứng (xử lý cả ROLE_ prefix)
        const role = user.role ? user.role.replace('ROLE_', '') : '';
        
        if (role === 'RECRUITER' || role === 'COMPANY') {
            if (recruiterMenu) recruiterMenu.classList.remove('hidden');
            if (candidateMenu) candidateMenu.classList.add('hidden');
        } else if (role === 'CANDIDATE') {
            if (candidateMenu) candidateMenu.classList.remove('hidden');
            if (recruiterMenu) recruiterMenu.classList.add('hidden');
        }
    } else {
        // Chưa đăng nhập: Hiện nút đăng nhập/đăng ký
        if (loginBtn) loginBtn.classList.remove('hidden');
        if (registerBtn) registerBtn.classList.remove('hidden');
        
        // Ẩn các menu chức năng
        if (userDropdown) userDropdown.classList.add('hidden');
        if (recruiterMenu) recruiterMenu.classList.add('hidden');
        if (candidateMenu) candidateMenu.classList.add('hidden');
    }
}

/**
 * Đăng xuất
 */
function logout() {
    localStorage.removeItem('jwt_token');
    localStorage.removeItem('user_info');
    document.cookie = 'jwt_token=; path=/; max-age=0; SameSite=Lax';
    window.location.replace('/login');
}

/**
 * API Helper: Fetch có đính kèm Token tự động
 */
async function fetchWithAuth(url, options = {}) {
    const token = localStorage.getItem('jwt_token');
    const headers = {
        'Content-Type': 'application/json',
        ...options.headers
    };

    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await fetch(url, { ...options, headers });

    if (response.status === 401) {
        logout(); // Token hết hạn hoặc không hợp lệ
    }
    return response;
}

// Chạy cập nhật Navbar ngay khi trang web tải xong
document.addEventListener('DOMContentLoaded', updateNavbar);
