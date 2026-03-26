// application.js - Job Posting and Application logic

/**
 * Ứng tuyển công việc - kết nối với modal trong job-detail.html
 * Gọi từ nút #btn-confirm-apply trong modal #applyModal
 */
document.addEventListener('DOMContentLoaded', function () {
    // Xử lý nút xác nhận ứng tuyển trong modal
    const confirmApplyBtn = document.getElementById('btn-confirm-apply');
    const applyBtn = document.getElementById('btn-apply-job');

    if (confirmApplyBtn && applyBtn) {
        confirmApplyBtn.addEventListener('click', async function () {
            const jobId = applyBtn.getAttribute('data-job-id');
            const coverLetter = document.getElementById('coverLetterInput')?.value || '';
            await submitApply(jobId, coverLetter);
        });
    }

    // Xóa alert khi mở lại modal
    const applyModal = document.getElementById('applyModal');
    if (applyModal) {
        applyModal.addEventListener('show.bs.modal', function () {
            document.getElementById('applyAlert')?.classList.add('d-none');
            document.getElementById('applySuccess')?.classList.add('d-none');
            document.getElementById('coverLetterInput').value = '';
            document.getElementById('applyBtnText')?.classList.remove('d-none');
            document.getElementById('applyBtnLoading')?.classList.add('d-none');
            if (confirmApplyBtn) confirmApplyBtn.disabled = false;
        });
    }

    // Load data theo từng trang
    if (document.getElementById('applications-container')) loadMyApplications();
    if (document.getElementById('my-jobs-container')) loadMyJobs();
    if (document.getElementById('interviews-container')) loadInterviews();

    // Form listeners
    const jobForm = document.getElementById('jobPostingForm');
    if (jobForm) jobForm.addEventListener('submit', saveJobPosting);

    const companyForm = document.getElementById('companyForm');
    if (companyForm) companyForm.addEventListener('submit', saveCompanyInfo);

    const profileForm = document.getElementById('candidateProfileForm');
    if (profileForm) profileForm.addEventListener('submit', saveCandidateProfile);

    const createProfileForm = document.getElementById('createProfileForm');
    if (createProfileForm) createProfileForm.addEventListener('submit', createCandidateProfile);

    const interviewForm = document.getElementById('scheduleInterviewForm');
    if (interviewForm) interviewForm.addEventListener('submit', scheduleInterview);
});

/**
 * Gửi đơn ứng tuyển thực sự (gọi API)
 */
async function submitApply(jobId, coverLetter) {
    if (!isLoggedIn()) {
        window.location.href = '/login';
        return;
    }

    const confirmBtn = document.getElementById('btn-confirm-apply');
    const btnText = document.getElementById('applyBtnText');
    const btnLoading = document.getElementById('applyBtnLoading');
    const alertEl = document.getElementById('applyAlert');
    const alertMsg = document.getElementById('applyAlertMessage');
    const successEl = document.getElementById('applySuccess');

    // Hiện loading
    if (confirmBtn) confirmBtn.disabled = true;
    btnText?.classList.add('d-none');
    btnLoading?.classList.remove('d-none');
    alertEl?.classList.add('d-none');

    try {
        const response = await fetchWithAuth('/api/applications', {
            method: 'POST',
            body: JSON.stringify({ jobId: parseInt(jobId), coverLetter })
        });

        const data = await response.json();

        if (response.ok) {
            // Hiện thông báo thành công trong modal
            successEl?.classList.remove('d-none');
            if (confirmBtn) confirmBtn.disabled = true;
            btnText?.classList.remove('d-none');
            btnLoading?.classList.add('d-none');

            // Đóng modal sau 2 giây
            setTimeout(() => {
                const modal = bootstrap.Modal.getInstance(document.getElementById('applyModal'));
                if (modal) modal.hide();
            }, 2000);
        } else {
            // Hiện lỗi trong modal
            if (alertMsg) alertMsg.textContent = data.message || 'Không thể gửi đơn ứng tuyển';
            alertEl?.classList.remove('d-none');
            if (confirmBtn) confirmBtn.disabled = false;
            btnText?.classList.remove('d-none');
            btnLoading?.classList.add('d-none');
        }
    } catch (error) {
        console.error('Apply error:', error);
        if (alertMsg) alertMsg.textContent = 'Lỗi kết nối, vui lòng thử lại';
        alertEl?.classList.remove('d-none');
        if (confirmBtn) confirmBtn.disabled = false;
        btnText?.classList.remove('d-none');
        btnLoading?.classList.add('d-none');
    }
}

/**
 * applyForJob — dùng ở trang chủ (card job), mở modal nếu có hoặc redirect login
 */
function applyForJob(jobId) {
    if (!isLoggedIn()) {
        window.location.href = '/login';
        return;
    }
    // Redirect sang trang chi tiết job để ứng tuyển qua modal
    window.location.href = '/jobs/' + jobId;
}

// ==================== RECRUITER: MANAGE JOBS ====================

async function loadMyJobs() {
    const container = document.getElementById('my-jobs-container');
    if (!container) return;

    try {
        const response = await fetchWithAuth('/api/jobs/my-jobs');
        const jobs = await response.json();

        if (!Array.isArray(jobs) || jobs.length === 0) {
            container.innerHTML = `<tr><td colspan="5" class="text-center py-5">
                <p class="text-muted mb-0">Bạn chưa đăng tin nào.</p>
            </td></tr>`;
            return;
        }

        container.innerHTML = jobs.map(job => `
            <tr>
                <td class="ps-4">
                    <h6 class="mb-0 fw-bold text-primary">${escHtml(job.title)}</h6>
                    <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i>${escHtml(job.location || '')}</small>
                </td>
                <td>${new Date(job.createdAt || Date.now()).toLocaleDateString('vi-VN')}</td>
                <td class="text-center">
                    <a href="/recruiter/applications/job/${job.id}" class="text-decoration-none">
                        <span class="badge bg-info">${job.applicationCount || 0} ứng viên</span>
                    </a>
                </td>
                <td>
                    <span class="badge ${job.status === 'OPEN' ? 'bg-success' : job.status === 'DRAFT' ? 'bg-warning text-dark' : 'bg-secondary'}">
                        ${job.status}
                    </span>
                </td>
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

async function deleteJob(id) {
    if (!confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')) return;

    try {
        const response = await fetchWithAuth(`/api/jobs/${id}`, { method: 'DELETE' });
        if (response.ok) {
            loadMyJobs();
        } else {
            alert('Không thể xóa tin tuyển dụng');
        }
    } catch (error) {
        console.error('Delete error:', error);
    }
}

async function saveJobPosting(e) {
    e.preventDefault();
    const jobId = document.getElementById('jobId')?.value;
    const expiredAtVal = document.getElementById('expiredAt')?.value;
    const data = {
        title: document.getElementById('title').value,
        jobType: document.getElementById('jobType').value,
        location: document.getElementById('location').value,
        salaryMin: parseInt(document.getElementById('salaryMin').value) || null,
        salaryMax: parseInt(document.getElementById('salaryMax').value) || null,
        description: document.getElementById('description').value,
        requirements: document.getElementById('requirements').value,
        skills: document.getElementById('skills').value.split(',').map(s => s.trim()).filter(s => s),
        expiredAt: expiredAtVal ? expiredAtVal + ':00' : null
    };

    const url = jobId ? `/api/jobs/${jobId}` : '/api/jobs';
    const method = jobId ? 'PUT' : 'POST';

    try {
        const response = await fetchWithAuth(url, { method, body: JSON.stringify(data) });
        if (response.ok) {
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

// ==================== COMPANY ====================

async function saveCompanyInfo(e) {
    e.preventDefault();
    const companyId = document.getElementById('companyId')?.value;
    const data = {
        name: document.getElementById('companyName').value,
        website: document.getElementById('companyWebsite').value,
        industry: document.getElementById('companyIndustry')?.value || '',
        companySize: document.getElementById('companySize')?.value || '',
        description: document.getElementById('companyDescription').value
    };

    const url = companyId ? `/api/companies/${companyId}` : '/api/companies';
    const method = companyId ? 'PUT' : 'POST';

    try {
        const response = await fetchWithAuth(url, { method, body: JSON.stringify(data) });
        if (response.ok) {
            setTimeout(() => location.reload(), 100);
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Lỗi hệ thống'));
        }
    } catch (error) {
        console.error('Save company error:', error);
        alert('Có lỗi xảy ra khi lưu thông tin.');
    }
}

// ==================== CANDIDATE: APPLICATIONS ====================

async function loadMyApplications() {
    const container = document.getElementById('applications-container');
    if (!container) return;

    try {
        const response = await fetchWithAuth('/api/applications/my-applications');
        const applications = await response.json();

        if (!Array.isArray(applications) || applications.length === 0) {
            container.innerHTML = '<div class="alert alert-info">Bạn chưa ứng tuyển công việc nào.</div>';
            return;
        }

        container.innerHTML = applications.map(app => `
            <div class="card mb-3 shadow-sm border-0">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title fw-bold text-primary mb-1">${escHtml(app.jobTitle)}</h5>
                            <p class="card-text text-muted mb-1">
                                <i class="fas fa-building me-1"></i>${escHtml(app.companyName)}
                            </p>
                            <small class="text-muted">
                                <i class="fas fa-calendar me-1"></i>
                                Ngày nộp: ${new Date(app.appliedAt).toLocaleDateString('vi-VN')}
                            </small>
                        </div>
                        <span class="badge ${getStatusBadgeClass(app.status)} px-3 py-2">${getStatusLabel(app.status)}</span>
                    </div>
                </div>
            </div>
        `).join('');
    } catch (error) {
        console.error('Load applications error:', error);
        container.innerHTML = '<div class="alert alert-danger">Lỗi khi tải danh sách đơn ứng tuyển.</div>';
    }
}

function getStatusBadgeClass(status) {
    const map = {
        'APPLIED': 'bg-warning text-dark',
        'SHORTLISTED': 'bg-info',
        'INTERVIEWING': 'bg-primary',
        'OFFERED': 'bg-success',
        'REJECTED': 'bg-danger'
    };
    return map[status] || 'bg-secondary';
}

function getStatusLabel(status) {
    const map = {
        'APPLIED': 'Đã nộp',
        'SHORTLISTED': 'Lọc hồ sơ',
        'INTERVIEWING': 'Phỏng vấn',
        'OFFERED': 'Nhận offer',
        'REJECTED': 'Từ chối'
    };
    return map[status] || status;
}

async function updateApplicationStatus(applicationId, status) {
    try {
        const response = await fetchWithAuth(`/api/applications/${applicationId}/status`, {
            method: 'PUT',
            body: JSON.stringify({ status })
        });

        if (response.ok) {
            location.reload();
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Không thể cập nhật trạng thái'));
        }
    } catch (error) {
        console.error('Update status error:', error);
        alert('Có lỗi xảy ra khi cập nhật trạng thái');
    }
}

// ==================== CANDIDATE: PROFILE ====================

async function saveCandidateProfile(e) {
    e.preventDefault();
    const submitBtn = e.target.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.disabled = true;
    submitBtn.textContent = 'Đang lưu...';

    let resumeUrl = null;
    const cvFile = document.getElementById('edit-cv-file')?.files[0];
    if (cvFile) {
        const formData = new FormData();
        formData.append('file', cvFile);
        const token = localStorage.getItem('jwt_token');
        try {
            const uploadRes = await fetch('/api/files/upload', {
                method: 'POST',
                headers: token ? { 'Authorization': 'Bearer ' + token } : {},
                body: formData
            });
            if (uploadRes.ok) {
                resumeUrl = (await uploadRes.json()).url;
            } else {
                alert('Tải CV lên thất bại.');
                submitBtn.disabled = false;
                submitBtn.textContent = originalText;
                return;
            }
        } catch (e) {
            alert('Lỗi kết nối khi tải CV.');
            submitBtn.disabled = false;
            submitBtn.textContent = originalText;
            return;
        }
    }

    const data = {
        fullName: document.getElementById('edit-fullName').value,
        headline: document.getElementById('edit-headline').value,
        phone: document.getElementById('edit-phone').value,
        address: document.getElementById('edit-address').value,
        summary: document.getElementById('edit-summary').value
    };
    if (resumeUrl) data.resumeUrl = resumeUrl;

    try {
        const response = await fetchWithAuth('/api/candidate/profile', {
            method: 'PUT',
            body: JSON.stringify(data)
        });

        if (response.ok) {
            const modal = bootstrap.Modal.getInstance(document.getElementById('editProfileModal'));
            if (modal) modal.hide();
            location.reload();
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Không thể cập nhật hồ sơ'));
        }
    } catch (error) {
        alert('Lỗi kết nối khi cập nhật hồ sơ.');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

async function createCandidateProfile(e) {
    e.preventDefault();
    const submitBtn = e.target.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.disabled = true;
    submitBtn.textContent = 'Đang tạo...';

    let resumeUrl = null;
    const cvFile = document.getElementById('create-cv-file')?.files[0];
    if (cvFile) {
        const formData = new FormData();
        formData.append('file', cvFile);
        const token = localStorage.getItem('jwt_token');
        try {
            const uploadRes = await fetch('/api/files/upload', {
                method: 'POST',
                headers: token ? { 'Authorization': 'Bearer ' + token } : {},
                body: formData
            });
            if (uploadRes.ok) {
                resumeUrl = (await uploadRes.json()).url;
            } else {
                alert('Tải CV lên thất bại.');
                submitBtn.disabled = false;
                submitBtn.textContent = originalText;
                return;
            }
        } catch (e) {
            alert('Lỗi kết nối khi tải CV.');
            submitBtn.disabled = false;
            submitBtn.textContent = originalText;
            return;
        }
    }

    const data = {
        fullName: document.getElementById('create-fullName').value,
        headline: document.getElementById('create-headline').value,
        phone: document.getElementById('create-phone').value,
        address: document.getElementById('create-address').value,
        summary: document.getElementById('create-summary').value,
        resumeUrl
    };

    try {
        const response = await fetchWithAuth('/api/candidate/profile', {
            method: 'PUT',
            body: JSON.stringify(data)
        });

        if (response.ok) {
            const modal = bootstrap.Modal.getInstance(document.getElementById('createProfileModal'));
            if (modal) modal.hide();
            location.reload();
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Không thể tạo hồ sơ'));
        }
    } catch (error) {
        alert('Lỗi kết nối khi tạo hồ sơ.');
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
    }
}

// ==================== RECRUITER: INTERVIEWS ====================

async function loadInterviews() {
    const container = document.getElementById('interviews-container');
    if (!container) return;

    try {
        const response = await fetchWithAuth('/api/interviews/my');
        const interviews = await response.json();

        if (!Array.isArray(interviews) || interviews.length === 0) {
            container.innerHTML = '<tr><td colspan="6" class="text-center py-5"><p class="text-muted">Chưa có lịch phỏng vấn nào.</p></td></tr>';
            return;
        }

        container.innerHTML = interviews.map(interview => `
            <tr>
                <td class="ps-4">
                    <h6 class="mb-0 fw-bold">${escHtml(interview.candidateName)}</h6>
                    <small class="text-muted">${escHtml(interview.candidateEmail)}</small>
                </td>
                <td>${escHtml(interview.jobTitle)}</td>
                <td><span class="text-primary fw-bold">${formatDateTime(interview.scheduledAt)}</span></td>
                <td><span class="badge bg-light text-dark border">${interview.type}</span></td>
                <td>
                    <!-- FIX: enum là PASS/FAIL/PENDING không phải PASSED/FAILED -->
                    <span class="badge ${getInterviewResultBadge(interview.result)}">${getInterviewResultLabel(interview.result)}</span>
                </td>
                <td class="text-center pe-4">
                    <div class="btn-group">
                        <button onclick="showInterviewDetail(${JSON.stringify(interview).replace(/"/g, '&quot;')})" 
                                class="btn btn-sm btn-outline-secondary" title="Chi tiết">
                            <i class="fas fa-info-circle"></i>
                        </button>
                        <button onclick="updateInterviewResult(${interview.id}, 'PASS')" 
                                class="btn btn-sm btn-outline-success" title="Đánh dấu Pass">
                            <i class="fas fa-check"></i>
                        </button>
                        <button onclick="updateInterviewResult(${interview.id}, 'FAIL')" 
                                class="btn btn-sm btn-outline-danger" title="Đánh dấu Fail">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `).join('');
    } catch (error) {
        console.error('Load interviews error:', error);
        container.innerHTML = '<tr><td colspan="6" class="text-center text-danger">Lỗi kết nối server</td></tr>';
    }
}

// FIX: Dùng đúng enum PASS/FAIL/PENDING (không phải PASSED/FAILED)
function getInterviewResultBadge(result) {
    const map = {
        'PASS': 'bg-success',
        'FAIL': 'bg-danger',
        'PENDING': 'bg-warning text-dark'
    };
    return map[result] || 'bg-secondary';
}

function getInterviewResultLabel(result) {
    const map = { 'PASS': 'Đạt', 'FAIL': 'Không đạt', 'PENDING': 'Chờ kết quả' };
    return map[result] || result;
}

// FIX: Không gọi GET /api/interviews/{id} vì endpoint không tồn tại - dùng data đã có
function showInterviewDetail(interview) {
    alert(
        `Chi tiết phỏng vấn:\n\n` +
        `Ứng viên: ${interview.candidateName}\n` +
        `Email: ${interview.candidateEmail}\n` +
        `Vị trí: ${interview.jobTitle}\n` +
        `Thời gian: ${formatDateTime(interview.scheduledAt)}\n` +
        `Hình thức: ${interview.type}\n` +
        `Địa điểm/Link: ${interview.locationOrLink}\n` +
        `Ghi chú: ${interview.interviewerNote || 'Không có'}`
    );
}

function formatDateTime(dateTimeStr) {
    if (!dateTimeStr) return '';
    return new Date(dateTimeStr).toLocaleString('vi-VN', {
        day: '2-digit', month: '2-digit', year: 'numeric',
        hour: '2-digit', minute: '2-digit'
    });
}

async function updateInterviewResult(interviewId, result) {
    const note = prompt(`Nhập ghi chú cho kết quả "${getInterviewResultLabel(result)}" (tùy chọn):`);
    if (note === null) return; // User bấm Cancel

    try {
        const response = await fetchWithAuth(
            `/api/interviews/${interviewId}/result?result=${result}&note=${encodeURIComponent(note || '')}`,
            { method: 'PATCH' }
        );

        if (response.ok) {
            loadInterviews();
        } else {
            alert('Không thể cập nhật kết quả');
        }
    } catch (error) {
        console.error('Update interview result error:', error);
    }
}

async function scheduleInterview(e) {
    e.preventDefault();
    const data = {
        applicationId: parseInt(document.getElementById('interviewApplicationId').value),
        scheduledAt: document.getElementById('interviewDateTime').value,
        type: document.getElementById('interviewType').value,
        locationOrLink: document.getElementById('interviewLocation').value,
        interviewerNote: document.getElementById('interviewNote').value
    };

    try {
        const response = await fetchWithAuth('/api/interviews', {
            method: 'POST',
            body: JSON.stringify(data)
        });

        if (response.ok) {
            const modal = bootstrap.Modal.getInstance(document.getElementById('scheduleInterviewModal'));
            if (modal) modal.hide();
            loadInterviews();
        } else {
            const errData = await response.json();
            alert('Lỗi: ' + (errData.message || 'Không thể tạo lịch phỏng vấn'));
        }
    } catch (error) {
        console.error('Schedule interview error:', error);
        alert('Lỗi kết nối khi tạo lịch phỏng vấn');
    }
}

// ==================== HOME PAGE: JOB SEARCH ====================

let searchTimeout = null;

async function loadAllJobs(title = '', location = '', fieldId = '') {
    const container = document.getElementById('jobs-list-container');
    if (!container) return;

    container.innerHTML = `
        <div class="col-12 text-center py-5">
            <div class="spinner-border text-primary mb-3" role="status" style="width: 3rem; height: 3rem;"></div>
            <p class="text-muted">Đang tìm kiếm việc làm phù hợp...</p>
        </div>`;

    const params = new URLSearchParams();
    if (title) params.append('title', title);
    if (location) params.append('location', location);
    if (fieldId) params.append('fieldId', fieldId);

    const url = '/api/jobs/search' + (params.toString() ? '?' + params.toString() : '');

    try {
        const response = await fetch(url);
        const jobs = await response.json();

        if (!Array.isArray(jobs) || jobs.length === 0) {
            container.innerHTML = `
                <div class="col-12 text-center py-5">
                    <i class="fas fa-search fa-4x text-muted opacity-50 mb-4"></i>
                    <h5 class="text-muted mb-2">Không tìm thấy việc làm</h5>
                    <p class="text-muted mb-0">Thử thay đổi từ khóa tìm kiếm.</p>
                    <button onclick="loadAllJobs()" class="btn btn-outline-primary mt-3">
                        <i class="fas fa-sync me-2"></i>Xem tất cả
                    </button>
                </div>`;
            return;
        }

        container.innerHTML = `
            <div class="col-12 mb-3">
                <p class="text-muted mb-0">
                    <i class="fas fa-check-circle text-success me-1"></i>
                    Tìm thấy <strong>${jobs.length}</strong> việc làm phù hợp
                </p>
            </div>
            ${jobs.map(job => `
            <div class="col-md-6 col-lg-4">
                <div class="card job-card h-100 border-0 shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <div class="flex-grow-1">
                                <h5 class="card-title text-primary fw-bold mb-1">${escHtml(job.title)}</h5>
                                <h6 class="card-subtitle text-muted">${escHtml(job.companyName)}</h6>
                            </div>
                            <span class="badge bg-light text-dark border px-2 py-1 flex-shrink-0">${job.jobType}</span>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex align-items-center text-muted mb-1">
                                <i class="fas fa-map-marker-alt me-2 text-primary" style="width:14px"></i>
                                <small>${escHtml(job.location || 'Nơi làm việc')}</small>
                            </div>
                            ${job.jobFieldName ? `<div class="d-flex align-items-center text-muted mb-1">
                                <i class="fas fa-briefcase me-2 text-primary" style="width:14px"></i>
                                <small>${escHtml(job.jobFieldName)}</small>
                            </div>` : ''}
                            <div class="d-flex align-items-center text-muted">
                                <i class="fas fa-money-bill-wave me-2 text-primary" style="width:14px"></i>
                                <small>${job.salaryMin ? job.salaryMin.toLocaleString('vi-VN') + ' - ' + job.salaryMax.toLocaleString('vi-VN') + ' đ' : 'Thỏa thuận'}</small>
                            </div>
                        </div>
                        <p class="card-text text-muted small" style="display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden">
                            ${escHtml(job.description || '')}
                        </p>
                    </div>
                    <div class="card-footer bg-white border-0 pt-0">
                        <div class="d-flex gap-2">
                            <a href="/jobs/${job.id}" class="btn btn-outline-primary flex-grow-1">
                                <i class="fas fa-eye me-1"></i>Chi tiết
                            </a>
                            <a href="/jobs/${job.id}" class="btn btn-primary flex-grow-1">
                                <i class="fas fa-paper-plane me-1"></i>Ứng tuyển
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        `).join('')}`;
    } catch (error) {
        console.error('Load all jobs error:', error);
        container.innerHTML = `
            <div class="col-12 text-center py-5">
                <i class="fas fa-exclamation-triangle fa-4x text-danger mb-3"></i>
                <h5 class="text-danger">Đã xảy ra lỗi</h5>
                <button onclick="loadAllJobs()" class="btn btn-primary mt-2">
                    <i class="fas fa-sync me-2"></i>Thử lại
                </button>
            </div>`;
    }
}

function debouncedSearch() {
    if (searchTimeout) clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
        const title = document.getElementById('searchTitle')?.value || '';
        const field = document.getElementById('searchField')?.value || '';
        const location = document.getElementById('searchLocation')?.value || '';
        loadAllJobs(title, location, field);
    }, 500);
}

// ==================== UTILS ====================

function escHtml(str) {
    if (!str) return '';
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
}