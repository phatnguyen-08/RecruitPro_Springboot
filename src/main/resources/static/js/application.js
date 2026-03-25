// application.js - Job, Posting and Company logic

/**
 * Ứng tuyển (Ứng viên)
 */
async function applyForJob(jobId) {
    if (!isLoggedIn()) {
        window.location.href = '/login';
        return;
    }

    const coverLetter = prompt("Vui lòng nhập thư giới thiệu của bạn (tùy chọn):");
    if (coverLetter === null) return;
    
    try {
        const response = await fetchWithAuth('/api/applications', {
            method: 'POST',
            body: JSON.stringify({ jobId, coverLetter })
        });

        if (response.ok) {
            alert('Ứng tuyển thành công!');
            location.reload();
        } else {
            const data = await response.json();
            alert('Lỗi: ' + (data.message || 'Không thể gửi đơn'));
        }
    } catch (error) {
        console.error('Apply error:', error);
    }
}

/**
 * Nạp danh sách tin của Nhà tuyển dụng (Manage Jobs)
 */
async function loadMyJobs() {
    const container = document.getElementById('my-jobs-container');
    if (!container) return;

    try {
        const response = await fetchWithAuth('/api/jobs/my-jobs');
        const jobs = await response.json();

        if (jobs.length === 0) {
            container.innerHTML = `<tr><td colspan="5" class="text-center py-5"><p class="text-muted mb-0">Bạn chưa đăng tin nào.</p></td></tr>`;
            return;
        }

        container.innerHTML = jobs.map(job => `
            <tr>
                <td class="ps-4">
                    <h6 class="mb-0 fw-bold text-primary">${job.title}</h6>
                    <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i>${job.location}</small>
                </td>
                <td>${new Date(job.createdAt || Date.now()).toLocaleDateString('vi-VN')}</td>
                <td class="text-center">
                    <a href="/recruiter/applications/job/${job.id}" class="text-decoration-none">
                        <span class="badge bg-info">${job.applicationCount || 0} ứng viên</span>
                    </a>
                </td>
                <td><span class="badge ${job.status === 'OPEN' ? 'bg-success' : 'bg-secondary'}">${job.status}</span></td>
                <td class="text-center pe-4">
                    <div class="btn-group">
                        <a href="/recruiter/jobs/edit/${job.id}" class="btn btn-sm btn-outline-secondary" title="Sửa"><i class="fas fa-edit"></i></a>
                        <a href="/jobs/${job.id}" class="btn btn-sm btn-outline-secondary" title="Xem" target="_blank"><i class="fas fa-eye"></i></a>
                        <button onclick="deleteJob(${job.id})" class="btn btn-sm btn-outline-danger" title="Xóa"><i class="fas fa-trash"></i></button>
                    </div>
                </td>
            </tr>
        `).join('');
    } catch (error) {
        console.error('Load jobs error:', error);
        container.innerHTML = `<tr><td colspan="5" class="text-center text-danger">Lỗi kết nối server</td></tr>`;
    }
}

/**
 * Xóa tin đăng
 */
async function deleteJob(id) {
    if (!confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')) return;
    
    try {
        const response = await fetchWithAuth(`/api/jobs/${id}`, { method: 'DELETE' });
        if (response.ok) {
            alert('Xóa thành công!');
            loadMyJobs();
        } else {
            alert('Không thể xóa tin tuyển dụng');
        }
    } catch (error) {
        console.error('Delete error:', error);
    }
}

/**
 * Lưu Tin Tuyển Dụng
 */
async function saveJobPosting(e) {
    e.preventDefault();
    const jobId = document.getElementById('jobId').value;
    const data = {
        title: document.getElementById('title').value,
        jobType: document.getElementById('jobType').value,
        location: document.getElementById('location').value,
        salaryMin: document.getElementById('salaryMin').value,
        salaryMax: document.getElementById('salaryMax').value,
        description: document.getElementById('description').value,
        requirements: document.getElementById('requirements').value,
        skills: document.getElementById('skills').value.split(',').map(s => s.trim()).filter(s => s !== '')
    };

    const url = jobId ? `/api/jobs/${jobId}` : '/api/jobs';
    const method = jobId ? 'PUT' : 'POST';

    try {
        const response = await fetchWithAuth(url, { method, body: JSON.stringify(data) });
        if (response.ok) {
            alert(jobId ? 'Cập nhật thành công!' : 'Đăng tin thành công!');
            window.location.href = '/recruiter/jobs';
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Lỗi hệ thống'));
        }
    } catch (error) {
        console.error('Save job error:', error);
        alert('Lỗi kết nối khi gửi tin đăng');
    }
}

/**
 * Lưu Thông Tin Công Ty
 */
async function saveCompanyInfo(e) {
    e.preventDefault();
    const companyId = document.getElementById('companyId').value;
    const data = {
        name: document.getElementById('companyName').value,
        website: document.getElementById('companyWebsite').value,
        location: document.getElementById('companyLocation').value,
        description: document.getElementById('companyDescription').value,
        logo: document.getElementById('logoUrl').value
    };

    const url = companyId ? `/api/companies/${companyId}` : '/api/companies';
    const method = companyId ? 'PUT' : 'POST';

    try {
        const response = await fetchWithAuth(url, { method, body: JSON.stringify(data) });
        if (response.ok) {
            alert('Cập nhật thông tin công ty thành công!');
            // Không reload ngay lập tức để tránh tranh chấp với alert
            setTimeout(() => location.reload(), 100);
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Lỗi hệ thống'));
        }
    } catch (error) {
        console.error('Save company error:', error);
        // Kiểm tra xem thực tế server có phản hồi thành công không trước khi báo lỗi kết nối
        alert('Có lỗi xảy ra khi lưu thông tin. Hãy kiểm tra kết nối.');
    }
}

/**
 * Nạp danh sách tin đã ứng tuyển (Candidate)
 */
async function loadMyApplications() {
    const container = document.getElementById('applications-container');
    if (!container) return;

    try {
        const response = await fetchWithAuth('/api/applications/my-applications');
        const applications = await response.json();

        if (applications.length === 0) {
            container.innerHTML = '<div class="alert alert-info">Bạn chưa ứng tuyển công việc nào.</div>';
            return;
        }

        container.innerHTML = applications.map(app => `
            <div class="card mb-3 shadow-sm border-0">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title fw-bold text-primary">${app.jobTitle}</h5>
                            <p class="card-text text-muted mb-1">${app.companyName}</p>
                            <small class="text-muted">Ngày nộp: ${new Date(app.appliedAt).toLocaleDateString()}</small>
                        </div>
                        <span class="badge ${getStatusBadgeClass(app.status)}">${app.status}</span>
                    </div>
                </div>
            </div>
        `).join('');
    } catch (error) {
        console.error('Load applications error:', error);
    }
}

function getStatusBadgeClass(status) {
    switch (status) {
        case 'APPLIED': return 'bg-warning text-dark';
        case 'SHORTLISTED': return 'bg-info';
        case 'INTERVIEWING': return 'bg-primary';
        case 'OFFERED': return 'bg-success';
        case 'REJECTED': return 'bg-danger';
        default: return 'bg-secondary';
    }
}

/**
 * Cập nhật trạng thái đơn ứng tuyển (Recruiter)
 */
async function updateApplicationStatus(applicationId, status) {
    try {
        const response = await fetchWithAuth(`/api/applications/${applicationId}/status`, {
            method: 'PUT',
            body: JSON.stringify({ status })
        });
        
        if (response.ok) {
            alert('Cập nhật trạng thái thành công!');
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Không thể cập nhật trạng thái'));
            location.reload(); 
        }
    } catch (error) {
        console.error('Update status error:', error);
        alert('Có lỗi xảy ra khi cập nhật trạng thái');
        location.reload();
    }
}

/**
 * Lưu hồ sơ ứng viên
 */
async function saveCandidateProfile(e) {
    e.preventDefault();
    console.log("Đang bắt đầu lưu hồ sơ...");

    const submitBtn = e.target.querySelector('button[type="submit"]');
    const originalBtnText = submitBtn.textContent;
    submitBtn.disabled = true;
    submitBtn.textContent = 'Đang lưu...';

    const data = {
        fullName: document.getElementById('edit-fullName').value,
        headline: document.getElementById('edit-headline').value,
        phone: document.getElementById('edit-phone').value,
        address: document.getElementById('edit-address').value,
        summary: document.getElementById('edit-summary').value
    };

    try {
        const response = await fetchWithAuth('/api/candidate/profile', {
            method: 'PUT',
            body: JSON.stringify(data)
        });

        if (response.ok) {
            alert('Cập nhật hồ sơ thành công!');
            // Đóng modal
            const modalElement = document.getElementById('editProfileModal');
            const modal = bootstrap.Modal.getInstance(modalElement);
            if (modal) modal.hide();

            location.reload();
        } else {
            let errorMessage = 'Không thể cập nhật hồ sơ';
            try {
                const errData = await response.json();
                errorMessage = errData.message || errorMessage;
            } catch (e) {}
            alert('Lỗi: ' + errorMessage);
        }
    } catch (error) {
        console.error('Save profile error:', error);
        alert('Lỗi kết nối khi cập nhật hồ sơ. Vui lòng thử lại sau.');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalBtnText;
    }
}


/**
 * Nạp danh sách việc làm (Trang chủ)
 */
async function loadAllJobs(title = '', location = '') {
    const container = document.getElementById('jobs-list-container');
    if (!container) return;

    let url = '/api/jobs/search';
    const params = new URLSearchParams();
    if (title) params.append('title', title);
    if (location) params.append('location', location);
    if (params.toString()) url += '?' + params.toString();

    try {
        const response = await fetch(url);
        const jobs = await response.json();

        if (jobs.length === 0) {
            container.innerHTML = `
                <div class="col-12 text-center py-5">
                    <p class="text-muted">Không tìm thấy việc làm phù hợp với tiêu chí của bạn.</p>
                </div>`;
            return;
        }

        container.innerHTML = jobs.map(job => `
            <div class="col-md-6 col-lg-4">
                <div class="card job-card h-100 border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h5 class="card-title text-primary mb-0 fw-bold">${job.title}</h5>
                            <span class="badge bg-light text-dark">${job.jobType}</span>
                        </div>
                        <h6 class="card-subtitle mb-2 text-muted">${job.companyName}</h6>
                        <div class="mb-3">
                            <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i> ${job.location || 'Nơi làm việc'}</small>
                            <small class="text-muted ms-3"><i class="fas fa-money-bill-wave me-1"></i> ${job.salaryMin ? job.salaryMin + ' - ' + job.salaryMax : 'Thỏa thuận'}</small>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-0 pb-3">
                        <a href="/jobs/${job.id}" class="btn btn-outline-primary w-100">Chi tiết</a>
                    </div>
                </div>
            </div>
        `).join('');
    } catch (error) {
        console.error('Load all jobs error:', error);
        container.innerHTML = '<div class="col-12 text-center text-danger">Lỗi nạp dữ liệu từ máy chủ.</div>';
    }
}

// Initialization
document.addEventListener('DOMContentLoaded', function() {
    const jobForm = document.getElementById('jobPostingForm');
    if (jobForm) jobForm.addEventListener('submit', saveJobPosting);

    const companyForm = document.getElementById('companyForm');
    if (companyForm) companyForm.addEventListener('submit', saveCompanyInfo);

    const profileForm = document.getElementById('candidateProfileForm');
    if (profileForm) profileForm.addEventListener('submit', saveCandidateProfile);

    const applyBtn = document.getElementById('btn-apply-job');
    if (applyBtn) {
        applyBtn.addEventListener('click', function() {
            const jobId = this.getAttribute('data-job-id');
            applyForJob(jobId);
        });
    }

    if (document.getElementById('applications-container')) loadMyApplications();
    if (document.getElementById('my-jobs-container')) loadMyJobs();
});
