<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Đăng ký tài khoản - CinemaVN</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;700;900&family=Inter:wght@400;500;600&display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                rel="stylesheet" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css" />
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
            <script id="tailwind-config">
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: {
                                "on-secondary-fixed": "#403f3f",
                                "on-surface-variant": "#5a5c5c",
                                "on-tertiary-container": "#4b0b75",
                                "background": "#f6f6f6",
                                "primary-container": "#ff7668",
                                "primary-fixed": "#ff7668",
                                "on-primary-fixed": "#000000",
                                "surface": "#f6f6f6",
                                "outline-variant": "#acadad",
                                "surface-variant": "#dbdddd",
                                "surface-tint": "#bb000c",
                                "on-primary": "#ffefed",
                                "primary-dim": "#a40009",
                                "on-primary-fixed-variant": "#610003",
                                "inverse-on-surface": "#9c9d9d",
                                "inverse-surface": "#0c0f0f",
                                "error-container": "#f74b6d",
                                "surface-container-lowest": "#ffffff",
                                "on-error-container": "#510017",
                                "secondary-container": "#e5e2e1",
                                "surface-container-highest": "#dbdddd",
                                "tertiary-fixed": "#d398ff",
                                "secondary-fixed-dim": "#d6d4d3",
                                "surface-dim": "#d3d5d5",
                                "on-error": "#ffefef",
                                "on-background": "#2d2f2f",
                                "surface-container-high": "#e1e3e3",
                                "error": "#b41340",
                                "outline": "#767777",
                                "secondary-fixed": "#e5e2e1",
                                "primary": "#bb000c",
                                "primary-fixed-dim": "#ff5b4c",
                                "on-surface": "#2d2f2f",
                                "surface-container-low": "#f0f1f1",
                                "tertiary-fixed-dim": "#c68af3",
                                "error-dim": "#a70138",
                                "inverse-primary": "#ff5446",
                                "surface-bright": "#f6f6f6",
                                "tertiary-container": "#d398ff",
                                "on-secondary-fixed-variant": "#5c5b5b",
                                "on-primary-container": "#4f0002",
                                "secondary-dim": "#504f4f",
                                "tertiary": "#7941a4",
                                "on-tertiary-fixed-variant": "#54197f",
                                "on-tertiary": "#fceeff",
                                "secondary": "#5c5b5b",
                                "on-tertiary-fixed": "#290045",
                                "on-secondary-container": "#525151",
                                "on-secondary": "#f5f2f1",
                                "tertiary-dim": "#6c3497",
                                "surface-container": "#e7e8e8"
                            },
                            fontFamily: {
                                "headline": ["Be Vietnam Pro"],
                                "body": ["Inter"],
                                "label": ["Inter"]
                            },
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "2xl": "1rem", "3xl": "1.5rem", "full": "9999px" },
                        },
                    },
                }
            </script>
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }

                .cinematic-gradient {
                    background: linear-gradient(135deg, #bb000c 0%, #ff7668 100%);
                }

                .glass-panel {
                    background: rgba(255, 255, 255, 0.8);
                    backdrop-filter: blur(20px);
                }
            </style>
        </head>

        <body
            class="bg-background text-on-background font-body selection:bg-primary-container selection:text-on-primary-container min-h-screen flex flex-col">
            <header
                class="bg-[#f6f6f6]/80 backdrop-blur-xl docked full-width top-0 sticky z-50 shadow-[0_12px_40px_rgba(45,47,47,0.06)]">
                <div
                    class="flex justify-between items-center w-full px-8 py-4 max-w-screen-2xl mx-auto font-['Be_Vietnam_Pro'] tracking-tight">
                    <div class="text-2xl font-black italic tracking-tighter text-[#bb000c]">CinemaVN</div>
                    <nav
                        class="hidden md:flex items-center space-x-8 font-['Be_Vietnam_Pro'] tracking-tight headline-md">
                        <a class="text-neutral-700 dark:text-neutral-300 hover:text-red-600 transition-all duration-300 hover:scale-105"
                            href="/index.jsp">Trang chủ</a>
                        <a class="text-neutral-700 dark:text-neutral-300 hover:text-red-600 transition-all duration-300 hover:scale-105"
                            href="/now-showing.jsp">Phim đang chiếu</a>
                        <a class="text-neutral-700 dark:text-neutral-300 hover:text-red-600 transition-all duration-300 hover:scale-105"
                            href="/upcoming.jsp">Phim sắp chiếu</a>
                        <a class="text-neutral-700 dark:text-neutral-300 hover:text-red-600 transition-all duration-300 hover:scale-105"
                            href="/theater.jsp">Rạp chiếu</a>
                        <a class="text-neutral-700 dark:text-neutral-300 hover:text-red-600 transition-all duration-300 hover:scale-105"
                            href="/promotion.jsp">Khuyến mãi</a>
                        <a class="text-red-700 dark:text-red-500 font-bold border-b-2 border-red-700 transition-all duration-300 hover:scale-105"
                            href="/register.jsp">Đăng ký</a>
                    </nav>
                    <div class="flex items-center space-x-4">
                        <a class="text-[#2d2f2f] font-medium text-sm hover:text-[#bb000c] transition-colors" href="/">Về
                            trang chủ</a>
                        <a class="bg-primary text-on-primary px-6 py-2.5 rounded-full font-bold transition-transform scale-95 active:scale-100 hover:scale-105 inline-block"
                            href="/login">Đăng nhập</a>
                    </div>
                </div>
            </header>
            <main class="flex-grow flex items-center justify-center py-12 px-4 md:px-8">
                <div
                    class="register-card max-w-6xl w-full grid grid-cols-1 lg:grid-cols-12 gap-0 overflow-hidden rounded-3xl shadow-[0_20px_60px_rgba(45,47,47,0.08)] bg-surface-container-lowest border border-outline-variant/10">
                    <div class="lg:col-span-7 p-8 md:p-12">
                        <div class="mb-10">
                            <h1
                                class="font-headline text-3xl md:text-4xl font-black text-on-background mb-2 tracking-tight">
                                Đăng ký tài khoản</h1>
                            <p class="text-on-surface-variant font-medium">Tạo tài khoản để đặt vé xem phim nhanh chóng
                            </p>
                        </div>
                        <c:if test="${not empty registerError}">
                            <div class="bg-red-100 text-red-700 border border-red-300 rounded-lg p-4 mb-4 text-center">
                                ${registerError}</div>
                        </c:if>
                        <form class="space-y-6" action="${pageContext.request.contextPath}/register" method="post">
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <div class="space-y-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Họ và tên</label>
                                    <input
                                        class="w-full bg-surface-container-low border-none rounded-xl px-4 py-3.5 focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-300 outline-none placeholder:text-outline"
                                        placeholder="Nguyễn Văn A" type="text" name="fullName" required />
                                </div>
                                <div class="space-y-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Email</label>
                                    <input
                                        class="w-full bg-surface-container-low border-none rounded-xl px-4 py-3.5 focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-300 outline-none placeholder:text-outline"
                                        placeholder="example@email.com" type="email" name="email" required />
                                </div>
                                <div class="space-y-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Số điện thoại</label>
                                    <input
                                        class="w-full bg-surface-container-low border-none rounded-xl px-4 py-3.5 focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-300 outline-none placeholder:text-outline"
                                        placeholder="090 123 4567" type="tel" name="phone" required />
                                </div>
                                <div class="space-y-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Ngày sinh</label>
                                    <input
                                        class="w-full bg-surface-container-low border-none rounded-xl px-4 py-3.5 focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-300 outline-none text-on-surface"
                                        type="date" name="birthday" required />
                                </div>
                                <div class="space-y-2 md:col-span-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Giới tính</label>
                                    <div class="flex gap-4">
                                        <label
                                            class="flex-1 flex items-center justify-center gap-2 bg-surface-container-low p-3.5 rounded-xl cursor-pointer hover:bg-surface-container-high transition-colors group">
                                            <input class="text-primary focus:ring-primary border-outline-variant"
                                                name="gender" type="radio" value="Nam" required />
                                            <span class="text-sm font-medium">Nam</span>
                                        </label>
                                        <label
                                            class="flex-1 flex items-center justify-center gap-2 bg-surface-container-low p-3.5 rounded-xl cursor-pointer hover:bg-surface-container-high transition-colors group">
                                            <input class="text-primary focus:ring-primary border-outline-variant"
                                                name="gender" type="radio" value="Nữ" required />
                                            <span class="text-sm font-medium">Nữ</span>
                                        </label>
                                        <!-- <label
                                            class="flex-1 flex items-center justify-center gap-2 bg-surface-container-low p-3.5 rounded-xl cursor-pointer hover:bg-surface-container-high transition-colors group">
                                            <input class="text-primary focus:ring-primary border-outline-variant"
                                                name="gender" type="radio" value="Khác" required />
                                            <span class="text-sm font-medium">Khác</span>
                                        </label> -->
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Mật khẩu</label>
                                    <div class="relative">
                                        <input id="password"
                                            class="w-full bg-surface-container-low border-none rounded-xl px-4 py-3.5 focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-300 outline-none placeholder:text-outline"
                                            placeholder="••••••••" type="password" name="password" minlength="8"
                                            required />
                                        <button
                                            class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-primary transition-colors toggle-password"
                                            type="button" aria-label="Hiện mật khẩu">
                                            <span class="material-symbols-outlined text-[20px]">visibility</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="space-y-2">
                                    <label class="block text-sm font-bold text-on-surface ml-1">Nhập lại mật
                                        khẩu</label>
                                    <div class="relative">
                                        <input id="confirmPassword"
                                            class="w-full bg-surface-container-low border-none rounded-xl px-4 py-3.5 focus:ring-2 focus:ring-primary/20 focus:bg-surface-container-lowest transition-all duration-300 outline-none placeholder:text-outline"
                                            placeholder="••••••••" type="password" name="confirmPassword" minlength="8"
                                            required />
                                        <button
                                            class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-primary transition-colors toggle-password"
                                            type="button" aria-label="Hiện mật khẩu">
                                            <span class="material-symbols-outlined text-[20px]">visibility</span>
                                        </button>
                                    </div>
                                </div>
                                <div id="passwordRequirements"
                                    class="space-y-2 px-4 py-4 rounded-2xl border border-outline-variant bg-surface-container-highest text-sm text-on-surface-variant">
                                    <p class="font-semibold text-on-surface mb-2">Yêu cầu mật khẩu:</p>
                                    <ul class="space-y-2">
                                        <li id="requirementLength" class="flex items-center gap-2">
                                            <span class="h-3 w-3 rounded-full bg-error"></span>
                                            Ít nhất 8 ký tự
                                        </li>
                                        <li id="requirementUpper" class="flex items-center gap-2">
                                            <span class="h-3 w-3 rounded-full bg-error"></span>
                                            Có chữ hoa (A-Z)
                                        </li>
                                        <li id="requirementLower" class="flex items-center gap-2">
                                            <span class="h-3 w-3 rounded-full bg-error"></span>
                                            Có chữ thường (a-z)
                                        </li>
                                        <li id="requirementDigit" class="flex items-center gap-2">
                                            <span class="h-3 w-3 rounded-full bg-error"></span>
                                            Có số (0-9)
                                        </li>
                                        <li id="requirementSpecial" class="flex items-center gap-2">
                                            <span class="h-3 w-3 rounded-full bg-error"></span>
                                            Có ký tự đặc biệt (!@#$%^&*)
                                        </li>
                                        <li id="requirementMatch" class="flex items-center gap-2">
                                            <span class="h-3 w-3 rounded-full bg-error"></span>
                                            Xác nhận mật khẩu khớp
                                        </li>
                                    </ul>
                                    <p id="registerValidationMessage" class="text-error text-sm hidden"></p>
                                </div>
                            </div>
                            <div class="flex items-start gap-3 py-2">
                                <input
                                    class="mt-1 rounded text-primary focus:ring-primary border-outline-variant w-5 h-5"
                                    id="terms" type="checkbox" required />
                                <label class="text-sm text-on-surface-variant leading-relaxed" for="terms">
                                    Tôi đồng ý với <a class="text-primary font-bold hover:underline" href="#">điều khoản
                                        sử
                                        dụng</a> và <a class="text-primary font-bold hover:underline" href="#">chính
                                        sách
                                        bảo mật</a> của CinemaVN.
                                </label>
                            </div>
                            <div class="space-y-4 pt-4">
                                <button
                                    class="w-full cinematic-gradient text-white font-bold py-4 rounded-full text-lg shadow-[0_8px_25px_rgba(187,0,12,0.3)] hover:scale-[1.02] active:scale-[0.98] transition-all duration-300 flex items-center justify-center gap-3"
                                    type="submit">
                                    Đăng ký
                                    <span
                                        class="material-symbols-outlined group-hover:translate-x-1 transition-transform">arrow_forward</span>
                                </button>
                                <div class="text-center">
                                    <p class="text-on-surface-variant font-medium">Đã có tài khoản? <a
                                            class="text-primary font-bold hover:underline" href="/login">Đăng nhập
                                            ngay</a>
                                    </p>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="hidden lg:block lg:col-span-5 relative overflow-hidden bg-inverse-surface">
                        <img alt="Cinema background" class="absolute inset-0 w-full h-full object-cover opacity-60"
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuB7tuCu8LptuhabC1eafnUGn6rjGdjAXWZ0jz4Of5LqDHfvG36nENRltno44mCncmYIvXEitq8uVUZIgceH2tO6l72JqptbGlj3gRpjiIqjnACDbgAZndKYp1DR86SciPNXz_ecUzX-Yx0A8XcyanIqKDXWTXlSKgKpf4HjNp8Ov3r3JrOZQv4ZTemvi6eus46du4Cr3Jz1q-f5F1GTIYbszBxUO7RKIW0qn6wEHIrzgJx4pVq5bo4neZTcH7x0SjuN9YkpEx1m-pc" />
                        <div class="absolute inset-0 bg-gradient-to-t from-black via-black/40 to-transparent"></div>
                        <div class="relative h-full flex flex-col justify-end p-12 text-white">
                            <div
                                class="glass-panel rounded-3xl p-6 mb-8 text-on-background max-w-sm self-start shadow-2xl">
                                <div class="flex gap-4">
                                    <img alt="Movie Poster" class="w-24 h-36 rounded-xl object-cover shadow-lg"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuAYND0mjQ2b9nqf5eFEM4EEx7miUyWH0BG3StBuZa73gtvhhqW3wQFRkptChBkXVVN7o6IrTUItxQ_AaVJC9X_GxklG4vVdHW-j24gizTNow3Z4_tnLHf4pMu-MoehJu_zoc7-RRef1d_2zQFTaPaaTvEL_5UCIK4Q2A3R4kjBvksyyxKvQRoZNy3vo23gsBK_bdjAlvKm5B8uyvaaa7Rxp2X2F8Vdzyy8paneTZd9oWfbuE1EvL_UgpuXXPJL2IjhQ2LFUZW3ZxPI" />
                                    <div class="flex flex-col justify-center">
                                        <span
                                            class="bg-primary text-[10px] uppercase font-black text-white px-2 py-1 rounded-md w-fit mb-2">Đang
                                            Chiếu</span>
                                        <h3 class="font-headline font-bold text-lg leading-tight mb-1">Vệ Binh Ánh Sáng
                                        </h3>
                                        <p class="text-xs text-on-surface-variant flex items-center gap-1"><span
                                                class="material-symbols-outlined text-[14px] text-primary">schedule</span>
                                            120 phút</p>
                                        <div class="flex gap-1 mt-3">
                                            <span
                                                class="material-symbols-outlined text-[16px] text-yellow-500">star</span>
                                            <span
                                                class="material-symbols-outlined text-[16px] text-yellow-500">star</span>
                                            <span
                                                class="material-symbols-outlined text-[16px] text-yellow-500">star</span>
                                            <span
                                                class="material-symbols-outlined text-[16px] text-yellow-500">star</span>
                                            <span
                                                class="material-symbols-outlined text-[16px] text-yellow-500">star_half</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <h2 class="font-headline text-4xl font-black mb-4 leading-tight italic tracking-tighter">
                                TRẢI
                                NGHIỆM ĐIỆN ẢNH XỨNG TẦM</h2>
                            <p class="text-white/80 font-medium max-w-xs leading-relaxed">Nhận ngay ưu đãi đặc quyền cho
                                thành viên CinemaVN: Giảm giá bắp nước và tích điểm đổi vé miễn phí.</p>
                        </div>
                    </div>
                </div>
            </main>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const passwordInput = document.getElementById('password');
                    const confirmPasswordInput = document.getElementById('confirmPassword');
                    const validationMessage = document.getElementById('registerValidationMessage');
                    const requirementRules = [
                        { id: 'requirementLength', regex: /.{8,}/ },
                        { id: 'requirementUpper', regex: /[A-Z]/ },
                        { id: 'requirementLower', regex: /[a-z]/ },
                        { id: 'requirementDigit', regex: /[0-9]/ },
                        { id: 'requirementSpecial', regex: /[!@#$%^&*]/ }
                    ];

                    function setRequirementState(id, passed) {
                        const item = document.getElementById(id);
                        if (!item) return;
                        item.classList.toggle('text-green-600', passed);
                        item.classList.toggle('text-on-surface-variant', !passed);
                        const dot = item.querySelector('span');
                        if (dot) {
                            dot.classList.toggle('bg-green-600', passed);
                            dot.classList.toggle('bg-error', !passed);
                        }
                    }

                    function updateRequirements() {
                        const password = passwordInput.value;
                        requirementRules.forEach(rule => setRequirementState(rule.id, rule.regex.test(password)));
                        setRequirementState('requirementMatch', password !== '' && password === confirmPasswordInput.value);
                    }

                    document.querySelectorAll('.toggle-password').forEach(button => {
                        button.addEventListener('click', function () {
                            const input = this.previousElementSibling;
                            const icon = this.querySelector('.material-symbols-outlined');
                            if (input.type === 'password') {
                                input.type = 'text';
                                icon.textContent = 'visibility_off';
                            } else {
                                input.type = 'password';
                                icon.textContent = 'visibility';
                            }
                        });
                    });

                    if (passwordInput && confirmPasswordInput) {
                        passwordInput.addEventListener('input', updateRequirements);
                        confirmPasswordInput.addEventListener('input', updateRequirements);
                    }

                    const form = document.querySelector('form[action="${pageContext.request.contextPath}/register"]');
                    if (form) {
                        form.addEventListener('submit', function (event) {
                            const password = passwordInput.value;
                            const allValid = requirementRules.every(rule => rule.regex.test(password));
                            const matchValid = password !== '' && password === confirmPasswordInput.value;
                            if (!allValid || !matchValid) {
                                event.preventDefault();
                                validationMessage.textContent = 'Mật khẩu phải đáp ứng đầy đủ các yêu cầu trên và khớp với xác nhận.';
                                validationMessage.classList.remove('hidden');
                                passwordInput.focus();
                            }
                        });
                    }
                });
            </script>
            <footer class="bg-[#f0f1f1] py-12 mt-auto font-['Inter'] text-sm tracking-normal">
                <div
                    class="grid grid-cols-1 md:grid-cols-2 lg:flex lg:justify-between items-start px-12 max-w-screen-2xl mx-auto">
                    <div class="mb-8 lg:mb-0">
                        <div class="text-xl font-bold text-[#2d2f2f] mb-4">CinemaVN</div>
                        <p class="text-[#2d2f2f]/70 max-w-xs">Hệ thống rạp chiếu phim hiện đại hàng đầu Việt Nam, mang
                            đến
                            trải nghiệm giải trí đỉnh cao.</p>
                    </div>
                    <div class="flex flex-wrap gap-x-12 gap-y-4">
                        <a class="text-[#2d2f2f]/70 hover:text-[#bb000c] transition-colors" href="#">Về Chúng Tôi</a>
                        <a class="text-[#2d2f2f]/70 hover:text-[#bb000c] transition-colors" href="#">Điều Khoản Sử
                            Dụng</a>
                        <a class="text-[#2d2f2f]/70 hover:text-[#bb000c] transition-colors" href="#">Chính Sách Bảo
                            Mật</a>
                        <a class="text-[#2d2f2f]/70 hover:text-[#bb000c] transition-colors" href="#">Liên Hệ Quảng
                            Cáo</a>
                    </div>
                    <div class="mt-8 lg:mt-0 lg:text-right">
                        <div class="flex lg:justify-end gap-4 mb-4">
                            <span
                                class="material-symbols-outlined text-[#2d2f2f]/70 hover:text-[#bb000c] cursor-pointer">language</span>
                            <span
                                class="material-symbols-outlined text-[#2d2f2f]/70 hover:text-[#bb000c] cursor-pointer">share</span>
                        </div>
                        <div class="text-[#2d2f2f]/70">© 2024 CinemaVN. Digital Red Carpet Experience.</div>
                    </div>
                </div>
            </footer>
        </body>

        </html>