<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>

        <html class="light" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Thông tin cá nhân - CinemaVN Scarlet</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,600;0,700;0,900;1,900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
            <script id="tailwind-config">
                tailwind.config = {
                    darkMode: "class",
                    theme: {
                        extend: {
                            colors: {
                                "inverse-surface": "#0c0f0f",
                                "on-background": "#2d2f2f",
                                "tertiary-container": "#d398ff",
                                "on-primary-container": "#4f0002",
                                "surface-bright": "#f6f6f6",
                                "on-primary": "#ffefed",
                                "surface": "#f6f6f6",
                                "on-secondary-fixed": "#403f3f",
                                "secondary-dim": "#504f4f",
                                "on-surface-variant": "#5a5c5c",
                                "on-tertiary-fixed": "#290045",
                                "outline": "#767777",
                                "on-error-container": "#510017",
                                "surface-container-highest": "#dbdddd",
                                "surface-container": "#e7e8e8",
                                "secondary-fixed": "#e5e2e1",
                                "on-tertiary-fixed-variant": "#54197f",
                                "on-error": "#ffefef",
                                "error": "#b41340",
                                "outline-variant": "#acadad",
                                "error-dim": "#a70138",
                                "tertiary-dim": "#6c3497",
                                "surface-container-lowest": "#ffffff",
                                "tertiary": "#7941a4",
                                "primary": "#bb000c",
                                "on-secondary-container": "#525151",
                                "primary-fixed": "#ff7668",
                                "on-tertiary": "#fceeff",
                                "primary-container": "#ff7668",
                                "surface-tint": "#bb000c",
                                "primary-fixed-dim": "#ff5b4c",
                                "on-tertiary-container": "#4b0b75",
                                "secondary": "#5c5b5b",
                                "on-secondary": "#f5f2f1",
                                "surface-container-low": "#f0f1f1",
                                "tertiary-fixed": "#d398ff",
                                "inverse-on-surface": "#9c9d9d",
                                "on-surface": "#2d2f2f",
                                "surface-variant": "#dbdddd",
                                "background": "#f6f6f6",
                                "tertiary-fixed-dim": "#c68af3",
                                "secondary-fixed-dim": "#d6d4d3",
                                "surface-container-high": "#e1e3e3",
                                "surface-dim": "#d3d5d5",
                                "secondary-container": "#e5e2e1",
                                "inverse-primary": "#ff5446",
                                "error-container": "#f74b6d",
                                "on-primary-fixed": "#000000",
                                "primary-dim": "#a40009",
                                "on-secondary-fixed-variant": "#5c5b5b",
                                "on-primary-fixed-variant": "#610003"
                            },
                            fontFamily: {
                                "headline": ["Be Vietnam Pro"],
                                "body": ["Inter"],
                                "label": ["Inter"]
                            },
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "2xl": "1rem", "full": "9999px" },
                        },
                    },
                }
            </script>
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }

                .glass-nav {
                    background: rgba(255, 255, 255, 0.8);
                    backdrop-filter: blur(12px);
                }

                .hero-gradient {
                    background: linear-gradient(135deg, #bb000c 0%, #ff7668 100%);
                }
            </style>
        </head>

        <body class="bg-surface font-body text-on-surface antialiased">
            <!-- TopNavBar -->
            <nav class="fixed top-0 w-full z-50 bg-white/80 dark:bg-neutral-900/80 backdrop-blur-md shadow-sm">
                <div class="flex justify-between items-center px-8 h-20 max-w-7xl mx-auto">
                    <div class="text-2xl font-black text-red-700 dark:text-red-600 italic tracking-tighter">CinemaVN
                    </div>
                    <c:set var="currentUri" value="${pageContext.request.servletPath}" />
                    <div
                        class="hidden md:flex items-center space-x-8 font-['Be_Vietnam_Pro'] tracking-tight headline-md">
                        <a class="${currentUri == '/' ? 'text-red-700 dark:text-red-500 font-bold border-b-2 border-red-700' : 'text-neutral-700 dark:text-neutral-300 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                            href="/">Trang chủ</a>
                        <a class="${currentUri == '/now-showing' ? 'text-red-700 dark:text-red-500 font-bold border-b-2 border-red-700' : 'text-neutral-700 dark:text-neutral-300 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                            href="/now-showing">Phim đang chiếu</a>
                        <a class="${currentUri == '/upcoming' ? 'text-red-700 dark:text-red-500 font-bold border-b-2 border-red-700' : 'text-neutral-700 dark:text-neutral-300 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                            href="/upcoming">Phim sắp chiếu</a>
                        <a class="${currentUri == '/theater' ? 'text-red-700 dark:text-red-500 font-bold border-b-2 border-red-700' : 'text-neutral-700 dark:text-neutral-300 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                            href="/theater">Rạp chiếu</a>
                        <a class="${currentUri == '/promotion' ? 'text-red-700 dark:text-red-500 font-bold border-b-2 border-red-700' : 'text-neutral-700 dark:text-neutral-300 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                            href="/promotion">Khuyến mại</a>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="relative hidden lg:block">
                            <input
                                class="bg-surface-container-low border-none rounded-full px-6 py-2 w-64 focus:ring-2 focus:ring-primary/20 transition-all text-sm"
                                placeholder="Tìm kiếm phim..." type="text" />
                            <span
                                class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-outline-variant">search</span>
                        </div>
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="relative profile-dropdown">
                                    <button id="profileToggle"
                                        class="flex items-center gap-3 bg-surface-container-low hover:bg-surface-container-high px-4 py-2 rounded-full transition-all border border-outline-variant/20"
                                        type="button">
                                        <div class="w-8 h-8 rounded-full bg-primary-container overflow-hidden">
                                            <img alt="User Avatar" class="w-full h-full object-cover"
                                                src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullName}&background=ff7668&color=fff" />
                                        </div>
                                        <span
                                            class="font-bold text-sm hidden sm:inline-block">${sessionScope.currentUser.fullName}</span>
                                        <span
                                            class="material-symbols-outlined text-outline transition-transform group-hover:rotate-180">expand_more</span>
                                    </button>
                                    <div id="profileDropdownMenu"
                                        class="dropdown-menu hidden absolute right-0 mt-2 w-56 bg-white dark:bg-neutral-800 rounded-xl shadow-xl border border-outline-variant/10 py-2 z-50">
                                        <a class="flex items-center gap-3 px-4 py-3 hover:bg-surface-container-low transition-colors text-sm font-medium"
                                            href="/profile"><span
                                                class="material-symbols-outlined text-lg text-primary">person</span>Thông
                                            tin cá nhân</a>
                                        <a class="flex items-center gap-3 px-4 py-3 hover:bg-surface-container-low transition-colors text-sm font-medium"
                                            href="/profile/edit"><span
                                                class="material-symbols-outlined text-lg text-primary">edit</span>Chỉnh
                                            sửa hồ sơ</a>
                                        <a class="flex items-center gap-3 px-4 py-3 hover:bg-surface-container-low transition-colors text-sm font-medium border-b border-outline-variant/10"
                                            href="#"><span
                                                class="material-symbols-outlined text-lg text-primary">confirmation_number</span>Vé
                                            của tôi</a>
                                        <a class="flex items-center gap-3 px-4 py-3 hover:bg-surface-container-low transition-colors text-sm font-medium"
                                            href="/change-password"><span
                                                class="material-symbols-outlined text-lg text-primary">lock_reset</span>Đổi
                                            mật khẩu</a>
                                        <c:if test="${sessionScope.currentUser.role.roleName == 'SUPER_ADMIN'}">
                                            <a class="flex items-center gap-3 px-4 py-3 hover:bg-surface-container-low transition-colors text-sm font-medium border-b border-outline-variant/10"
                                                href="/admin"><span
                                                    class="material-symbols-outlined text-lg text-primary">admin_panel_settings</span>Quản
                                                lý
                                                hệ thống
                                                (Admin)</a>
                                        </c:if>
                                        <a class="flex items-center gap-3 px-4 py-3 hover:bg-red-50 text-error transition-colors text-sm font-bold"
                                            href="/logout"><span
                                                class="material-symbols-outlined text-lg">logout</span>Đăng
                                            xuất</a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="/login"
                                    class="bg-primary text-on-primary px-6 py-2.5 rounded-full font-bold transition-transform scale-95 active:scale-100 hover:scale-105 inline-block">Đăng
                                    nhập</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </nav>
            <main class="pt-28 pb-20 max-w-7xl mx-auto px-6">
                <!-- Profile Bento Container -->
                <div class="grid grid-cols-12 gap-6">
                    <!-- Sidebar / Quick Actions -->
                    <aside class="col-span-12 md:col-span-4 lg:col-span-3">
                        <div class="bg-white rounded-2xl p-6 shadow-sm border border-gray-100 h-full">
                            <div class="flex flex-col items-center text-center mb-6">
                                <div class="relative group">
                                    <img class="w-16 h-16 rounded-full object-cover mb-3 border-2 border-white shadow-md group-hover:opacity-90 transition-opacity"
                                        src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullName}&background=ff7668&color=fff"
                                        data-alt="Professional profile photo" />
                                    <button
                                        class="absolute bottom-2 right-0 bg-primary text-white p-1 rounded-full shadow-md scale-90 active:scale-75 transition-transform"
                                        onclick="document.getElementById('avatarInput').click()">
                                        <span class="material-symbols-outlined text-xs">photo_camera</span>
                                    </button>
                                    <input type="file" id="avatarInput" accept="image/*" style="display: none;"
                                        onchange="uploadAvatar(this)">
                                </div>
                                <h2 class="font-headline text-lg font-bold text-on-surface">
                                    ${sessionScope.currentUser.fullName}</h2>
                                <p class="text-[10px] font-label uppercase tracking-widest text-primary font-bold mt-1">
                                    ${sessionScope.currentUser.role.roleName}</p>
                            </div>
                            <nav class="flex flex-col gap-1.5">
                                <button
                                    class="flex items-center gap-3 w-full p-2.5 rounded-xl bg-primary-container/10 text-primary font-semibold">
                                    <span class="material-symbols-outlined text-xl" data-weight="fill">person</span>
                                    <span class="text-sm">Hồ sơ cá nhân</span>
                                </button>
                                <button
                                    class="flex items-center gap-3 w-full p-2.5 rounded-xl text-on-surface-variant hover:bg-surface-container transition-colors"
                                    onclick="window.location.href='/tickets'">
                                    <span class="material-symbols-outlined text-xl">confirmation_number</span>
                                    <span class="text-sm">Vé của tôi</span>
                                </button>
                                <button
                                    class="flex items-center gap-3 w-full p-2.5 rounded-xl text-on-surface-variant hover:bg-surface-container transition-colors"
                                    onclick="window.location.href='/favorites'">
                                    <span class="material-symbols-outlined text-xl">favorite</span>
                                    <span class="text-sm">Phim yêu thích</span>
                                </button>
                                <button
                                    class="flex items-center gap-3 w-full p-2.5 rounded-xl text-on-surface-variant hover:bg-surface-container transition-colors"
                                    onclick="window.location.href='/history'">
                                    <span class="material-symbols-outlined text-xl">payments</span>
                                    <span class="text-sm">Lịch sử giao dịch</span>
                                </button>
                                <div class="h-px bg-outline-variant/10 my-2"></div>
                                <button
                                    class="flex items-center gap-3 w-full p-2.5 rounded-xl text-error hover:bg-error/5 transition-colors"
                                    onclick="window.location.href='/logout'">
                                    <span class="material-symbols-outlined text-xl">logout</span>
                                    <span class="text-sm">Đăng xuất</span>
                                </button>
                            </nav>
                        </div>
                    </aside>
                    <!-- Main Content Card -->
                    <div class="col-span-12 md:col-span-8 lg:col-span-9">
                        <div
                            class="bg-white rounded-2xl shadow-sm overflow-hidden border border-gray-100 flex flex-col">
                            <!-- Hero Section -->
                            <div class="py-6 px-6 md:px-8 hero-gradient relative">
                                <div
                                    class="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10">
                                </div>
                                <div
                                    class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-4">
                                    <div>
                                        <h1
                                            class="font-headline text-2xl lg:text-3xl font-black text-white tracking-tight">
                                            Thông tin tài khoản</h1>
                                        <p class="text-white/80 text-sm mt-1 max-w-lg">Quản lý thông tin cá nhân và
                                            cài
                                            đặt bảo mật cho tài khoản của bạn.</p>
                                    </div>
                                    <div class="flex gap-3">
                                        <button
                                            class="flex items-center gap-2 px-5 py-2.5 bg-white/20 hover:bg-white/30 text-white text-sm font-semibold rounded-xl backdrop-blur-md transition-all"
                                            onclick="window.location.href='/change-password'">
                                            <span class="material-symbols-outlined text-base">lock_reset</span>
                                            <span>Đổi mật khẩu</span>
                                        </button>
                                        <button
                                            class="flex items-center gap-2 px-5 py-2.5 bg-white text-primary hover:bg-primary-container/10 text-sm font-bold rounded-xl shadow-sm transition-all"
                                            onclick="window.location.href='/profile/edit'">
                                            <span class="material-symbols-outlined text-base">edit</span>
                                            <span>Chỉnh sửa</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!-- Information Content -->
                            <div class="p-6 md:p-8 space-y-6">
                                <c:if test="${not empty profileSuccess}">
                                    <div
                                        class="p-4 bg-primary/10 border border-primary/20 rounded-xl text-primary font-medium">
                                        ${profileSuccess}
                                    </div>
                                </c:if>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <!-- Information Fields -->
                                    <div class="space-y-2">
                                        <label class="text-xs font-label uppercase tracking-widest text-outline">Họ
                                            tên</label>
                                        <div class="flex items-center gap-3 rounded-xl bg-gray-100 px-4 py-3">
                                            <span
                                                class="material-symbols-outlined text-on-surface-variant text-xl">badge</span>
                                            <span
                                                class="font-semibold text-on-surface">${sessionScope.currentUser.fullName}</span>
                                        </div>
                                    </div>
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-label uppercase tracking-widest text-outline">Email</label>
                                        <div class="flex items-center gap-3 rounded-xl bg-gray-100 px-4 py-3">
                                            <span
                                                class="material-symbols-outlined text-on-surface-variant text-xl">mail</span>
                                            <span
                                                class="font-semibold text-on-surface">${sessionScope.currentUser.email}</span>
                                        </div>
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-label uppercase tracking-widest text-outline">Số
                                            điện
                                            thoại</label>
                                        <div class="flex items-center gap-3 rounded-xl bg-gray-100 px-4 py-3">
                                            <span
                                                class="material-symbols-outlined text-on-surface-variant text-xl">phone_iphone</span>
                                            <span
                                                class="font-semibold text-on-surface">${sessionScope.currentUser.phone}</span>
                                        </div>
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-label uppercase tracking-widest text-outline">Ngày
                                            sinh</label>
                                        <div class="flex items-center gap-3 rounded-xl bg-gray-100 px-4 py-3">
                                            <span
                                                class="material-symbols-outlined text-on-surface-variant text-xl">calendar_month</span>
                                            <span class="font-semibold text-on-surface">01/01/1995</span>
                                        </div>
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-label uppercase tracking-widest text-outline">Giới
                                            tính</label>
                                        <div class="flex items-center gap-3 rounded-xl bg-gray-100 px-4 py-3">
                                            <span
                                                class="material-symbols-outlined text-on-surface-variant text-xl">wc</span>
                                            <span class="font-semibold text-on-surface">Nam</span>
                                        </div>
                                    </div>
                                    <div class="space-y-2">
                                        <label class="text-xs font-label uppercase tracking-widest text-outline">Vai
                                            trò</label>
                                        <div class="flex items-center gap-3 rounded-xl bg-gray-100 px-4 py-3">
                                            <span class="material-symbols-outlined text-primary text-xl"
                                                style="font-variation-settings: 'FILL' 1;">verified_user</span>
                                            <span
                                                class="font-bold text-primary">${sessionScope.currentUser.role.roleName}</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Membership Tier Card -->
                                <div
                                    class="mt-6 p-5 rounded-2xl bg-stone-900 text-white relative overflow-hidden group">
                                    <div
                                        class="absolute top-0 right-0 p-8 opacity-20 transform translate-x-1/4 -translate-y-1/4 group-hover:scale-110 transition-transform duration-700">
                                        <span class="material-symbols-outlined text-[8rem]">stars</span>
                                    </div>
                                    <div class="relative z-10">
                                        <div class="flex items-center gap-2 mb-2">
                                            <span
                                                class="material-symbols-outlined text-primary-fixed text-xl">diamond</span>
                                            <span
                                                class="text-[10px] font-label uppercase tracking-[0.2em] font-bold text-primary-fixed">Hạng
                                                Thẻ Scarlet</span>
                                        </div>
                                        <h3 class="text-xl font-black italic tracking-tight mb-3">MEMBER PLATINUM
                                        </h3>
                                        <div class="w-full bg-white/10 h-1.5 rounded-full mb-2">
                                            <div class="bg-primary-fixed w-[85%] h-full rounded-full"></div>
                                        </div>
                                        <div
                                            class="flex justify-between items-center text-[10px] text-stone-400 font-semibold tracking-wider">
                                            <span>12,500 ĐIỂM</span>
                                            <span>CẦN THÊM 2,500 ĐIỂM ĐỂ LÊN DIAMOND</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <!-- Footer -->
            <footer class="bg-stone-100 dark:bg-stone-950 w-full py-12 px-6">
                <div class="max-w-7xl mx-auto">
                    <div class="flex flex-col md:flex-row justify-between items-center">
                        <div class="mb-8 md:mb-0">
                            <span
                                class="font-['Be_Vietnam_Pro'] font-bold text-lg text-stone-900 dark:text-stone-100">CinemaVN
                                Scarlet</span>
                            <p
                                class="mt-4 text-stone-500 max-w-sm font-['Inter'] text-xs uppercase tracking-widest leading-loose">
                                Mang đến trải nghiệm điện ảnh sang trọng và đẳng cấp bậc nhất tại Việt Nam.
                            </p>
                        </div>
                        <div class="flex flex-wrap justify-center gap-8">
                            <a class="font-['Inter'] text-xs uppercase tracking-widest text-stone-500 hover:text-stone-900 dark:hover:text-stone-100 underline underline-offset-4 opacity-80 hover:opacity-100 transition-opacity"
                                href="#">Về chúng tôi</a>
                            <a class="font-['Inter'] text-xs uppercase tracking-widest text-stone-500 hover:text-stone-900 dark:hover:text-stone-100 underline underline-offset-4 opacity-80 hover:opacity-100 transition-opacity"
                                href="#">Chính sách bảo mật</a>
                            <a class="font-['Inter'] text-xs uppercase tracking-widest text-stone-500 hover:text-stone-900 dark:hover:text-stone-100 underline underline-offset-4 opacity-80 hover:opacity-100 transition-opacity"
                                href="#">Điều khoản sử dụng</a>
                            <a class="font-['Inter'] text-xs uppercase tracking-widest text-stone-500 hover:text-stone-900 dark:hover:text-stone-100 underline underline-offset-4 opacity-80 hover:opacity-100 transition-opacity"
                                href="#">Liên hệ</a>
                        </div>
                    </div>
                    <div class="bg-stone-200 dark:bg-stone-800 h-px w-full my-8"></div>
                    <div class="text-center">
                        <p class="font-['Inter'] text-xs uppercase tracking-widest text-stone-500">© 2024 CinemaVN
                            Scarlet. The Digital Red Carpet Experience.</p>
                    </div>
                </div>
            </footer>
            <script>
                function uploadAvatar(input) {
                    if (input.files && input.files[0]) {
                        const formData = new FormData();
                        formData.append('avatar', input.files[0]);
                        formData.append('fullName', '${sessionScope.currentUser.fullName}');
                        formData.append('phone', '${sessionScope.currentUser.phone}');

                        fetch('/profile/edit', {
                            method: 'POST',
                            body: formData
                        }).then(response => {
                            if (response.ok) {
                                location.reload();
                            } else {
                                alert('Lỗi khi tải lên ảnh đại diện');
                            }
                        }).catch(error => {
                            console.error('Error:', error);
                            alert('Lỗi khi tải lên ảnh đại diện');
                        });
                    }
                }

                // Profile dropdown toggle
                document.addEventListener('DOMContentLoaded', function () {
                    const profileToggle = document.getElementById('profileToggle');
                    const profileMenu = document.getElementById('profileDropdownMenu');
                    if (profileToggle && profileMenu) {
                        profileToggle.addEventListener('click', function (event) {
                            event.stopPropagation();
                            profileMenu.classList.toggle('hidden');
                        });
                    }

                    // Close dropdown when clicking outside
                    document.addEventListener('click', function (event) {
                        if (profileToggle && profileMenu && !profileToggle.contains(event.target) && !profileMenu.contains(event.target)) {
                            profileMenu.classList.add('hidden');
                        }
                    });
                });
            </script>
        </body>

        </html>