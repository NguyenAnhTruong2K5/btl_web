<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>

            <html class="light" lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Đổi mật khẩu - CinemaVN</title>
                <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,500;0,600;0,700;0,800;0,900;1,400;1,500;1,600;1,700;1,800;1,900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                    rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                    rel="stylesheet" />
                <script id="tailwind-config">
                    tailwind.config = {
                        darkMode: "class",
                        theme: {
                            extend: {
                                "colors": {
                                    "on-primary": "#ffefed",
                                    "primary-fixed": "#ff7668",
                                    "on-surface-variant": "#5a5c5c",
                                    "on-error": "#ffefef",
                                    "background": "#f6f6f6",
                                    "tertiary": "#7941a4",
                                    "on-secondary": "#f5f2f1",
                                    "surface-dim": "#d3d5d5",
                                    "tertiary-container": "#d398ff",
                                    "surface": "#f6f6f6",
                                    "secondary": "#5c5b5b",
                                    "secondary-fixed": "#e5e2e1",
                                    "outline": "#767777",
                                    "on-secondary-container": "#525151",
                                    "on-tertiary-fixed": "#290045",
                                    "on-tertiary-container": "#4b0b75",
                                    "secondary-dim": "#504f4f",
                                    "error": "#b41340",
                                    "outline-variant": "#acadad",
                                    "tertiary-dim": "#6c3497",
                                    "on-background": "#2d2f2f",
                                    "tertiary-fixed-dim": "#c68af3",
                                    "secondary-fixed-dim": "#d6d4d3",
                                    "on-secondary-fixed-variant": "#5c5b5b",
                                    "secondary-container": "#e5e2e1",
                                    "primary": "#bb000c",
                                    "surface-container-highest": "#dbdddd",
                                    "inverse-primary": "#ff5446",
                                    "surface-container-low": "#f0f1f1",
                                    "surface-container-high": "#e1e3e3",
                                    "on-primary-fixed-variant": "#610003",
                                    "surface-bright": "#f6f6f6",
                                    "on-secondary-fixed": "#403f3f",
                                    "on-surface": "#2d2f2f",
                                    "on-error-container": "#510017",
                                    "surface-container": "#e7e8e8",
                                    "on-tertiary": "#fceeff",
                                    "tertiary-fixed": "#d398ff",
                                    "on-tertiary-fixed-variant": "#54197f",
                                    "on-primary-container": "#4f0002",
                                    "error-container": "#f74b6d",
                                    "surface-variant": "#dbdddd",
                                    "primary-fixed-dim": "#ff5b4c",
                                    "on-primary-fixed": "#000000",
                                    "surface-container-lowest": "#ffffff",
                                    "inverse-surface": "#0c0f0f",
                                    "inverse-on-surface": "#9c9d9d",
                                    "surface-tint": "#bb000c",
                                    "primary-container": "#ff7668",
                                    "primary-dim": "#a40009",
                                    "error-dim": "#a70138"
                                },
                                "borderRadius": {
                                    "DEFAULT": "0.25rem",
                                    "lg": "0.5rem",
                                    "xl": "0.75rem",
                                    "full": "9999px"
                                },
                                "fontFamily": {
                                    "headline": ["Be Vietnam Pro"],
                                    "body": ["Inter"],
                                    "label": ["Inter"]
                                }
                            },
                        },
                    }
                </script>
                <style>
                    .material-symbols-outlined {
                        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                    }

                    .hero-gradient {
                        background: linear-gradient(135deg, #bb000c 0%, #ff7668 100%);
                    }

                    .glass-nav {
                        background: rgba(246, 246, 246, 0.8);
                        backdrop-filter: blur(20px);
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
                <main class="pt-24 pb-20 max-w-screen-2xl mx-auto px-6">
                    <div class="grid grid-cols-12 gap-8">
                        <!-- SideNavBar -->
                        <aside class="col-span-12 md:col-span-3">
                            <div class="bg-white rounded-xl overflow-hidden border border-neutral-200 shadow-sm">
                                <div
                                    class="p-8 flex flex-col items-center text-center bg-surface-container-low/30 border-b border-neutral-100">
                                    <div class="h-20 w-20 rounded-full overflow-hidden mb-4 ring-4 ring-primary/10">
                                        <img alt="User Profile Picture" class="w-full h-full object-cover"
                                            onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullName}&background=ff7668&color=fff'"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDOWrA8Zen-Ps1bRrgIhw4Y5RFlOnUBSe9nYZ7bbyO9alnpDrSqOeUHSXpOcDdzzJ4bk2HY76OVtWtpffuRMCdyoAn2r89w5g2ebVZqcddHpq9-BbqK1ymk2-RIJzxAB-b8uiJx-dwUZv5ay9EtzMehaQ6uqQbaTAfxNqgE3xsF1fyL-GezGE5zyzvk9_IQc8uuEqq-m_WB6jBrGHR0dOn_ASZd3tpOav_jgvNqKitiKk6PPcAcS06Vl5OlaUXD6Y84He7OXBg5WfM" />
                                    </div>
                                    <h2 class="text-lg font-bold text-neutral-900 font-headline">
                                        ${sessionScope.currentUser.fullName}</h2>
                                    <p class="text-sm text-neutral-500 font-medium">Thành viên Platinum</p>
                                </div>
                                <nav class="flex flex-col py-4 font-['Inter'] text-sm">
                                    <a class="flex items-center gap-4 px-6 py-4 text-neutral-600 hover:bg-neutral-100 hover:translate-x-1 transition-all duration-200 cursor-pointer active:opacity-80"
                                        href="/profile">
                                        <span class="material-symbols-outlined" data-icon="person">person</span>
                                        <span>Hồ sơ cá nhân</span>
                                    </a>
                                    <a class="flex items-center gap-4 px-6 py-4 text-neutral-600 hover:bg-neutral-100 hover:translate-x-1 transition-all duration-200 cursor-pointer active:opacity-80"
                                        href="/tickets">
                                        <span class="material-symbols-outlined"
                                            data-icon="confirmation_number">confirmation_number</span>
                                        <span>Vé của tôi</span>
                                    </a>
                                    <a class="flex items-center gap-4 px-6 py-4 text-neutral-600 hover:bg-neutral-100 hover:translate-x-1 transition-all duration-200 cursor-pointer active:opacity-80"
                                        href="/favorites">
                                        <span class="material-symbols-outlined" data-icon="favorite">favorite</span>
                                        <span>Phim yêu thích</span>
                                    </a>
                                    <a class="flex items-center gap-4 px-6 py-4 text-neutral-600 hover:bg-neutral-100 hover:translate-x-1 transition-all duration-200 cursor-pointer active:opacity-80"
                                        href="/history">
                                        <span class="material-symbols-outlined" data-icon="history">history</span>
                                        <span>Lịch sử giao dịch</span>
                                    </a>
                                    <a class="flex items-center gap-4 px-6 py-4 bg-red-50 text-red-700 font-semibold border-r-4 border-red-700 transition-all duration-200 cursor-pointer active:opacity-80"
                                        href="/change-password">
                                        <span class="material-symbols-outlined" data-icon="lock"
                                            style="font-variation-settings: 'FILL' 1;">lock</span>
                                        <span>Đổi mật khẩu</span>
                                    </a>
                                    <div class="my-2 border-t border-neutral-100 mx-6"></div>
                                    <a class="flex items-center gap-4 px-6 py-4 text-error font-medium hover:bg-error/5 hover:translate-x-1 transition-all duration-200 cursor-pointer active:opacity-80"
                                        href="/logout">
                                        <span class="material-symbols-outlined" data-icon="logout">logout</span>
                                        <span>Đăng xuất</span>
                                    </a>
                                </nav>
                            </div>
                        </aside>
                        <!-- Main Content -->
                        <div class="col-span-12 md:col-span-9 space-y-8">
                            <!-- Hero Banner -->
                            <section
                                class="hero-gradient rounded-2xl p-10 text-white relative overflow-hidden shadow-xl">
                                <div class="relative z-10">
                                    <h1 class="text-4xl font-black font-headline tracking-tight mb-2">Đổi mật khẩu</h1>
                                    <p class="text-white/90 text-lg max-w-xl font-medium">Cập nhật mật khẩu để tăng
                                        cường
                                        bảo mật tài khoản của bạn, ${sessionScope.currentUser.fullName}.</p>
                                </div>
                                <div class="absolute -right-20 -bottom-20 opacity-10 rotate-12">
                                    <span class="material-symbols-outlined text-[300px]"
                                        data-icon="security">security</span>
                                </div>
                            </section>
                            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                                <!-- Form Section -->
                                <div class="lg:col-span-2">
                                    <div
                                        class="bg-surface-container-lowest rounded-xl p-8 shadow-sm border border-neutral-100">
                                        <c:if test="${not empty changePasswordError}">
                                            <div
                                                class="mb-6 p-4 bg-error/10 border border-error/20 rounded-xl text-error font-medium">
                                                ${changePasswordError}
                                            </div>
                                        </c:if>
                                        <c:if test="${not empty changePasswordSuccess}">
                                            <div
                                                class="mb-6 p-4 bg-primary/10 border border-primary/20 rounded-xl text-primary font-medium">
                                                ${changePasswordSuccess}
                                            </div>
                                        </c:if>
                                        <form action="/change-password" method="post" class="space-y-6">
                                            <div class="space-y-2">
                                                <label
                                                    class="text-sm font-semibold text-on-surface-variant flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-sm"
                                                        data-icon="lock">lock</span>
                                                    Mật khẩu hiện tại
                                                </label>
                                                <div class="relative">
                                                    <input
                                                        class="w-full bg-surface-container-low border-none rounded-xl px-5 py-4 focus:ring-2 focus:ring-primary/20 transition-all text-on-surface"
                                                        placeholder="••••••••" type="password" name="currentPassword"
                                                        required />
                                                    <button type="button"
                                                        class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-primary toggle-password">
                                                        <span class="material-symbols-outlined"
                                                            data-icon="visibility">visibility</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="space-y-2">
                                                <label
                                                    class="text-sm font-semibold text-on-surface-variant flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-sm"
                                                        data-icon="password">password</span>
                                                    Mật khẩu mới
                                                </label>
                                                <div class="relative">
                                                    <input id="newPassword"
                                                        class="w-full bg-surface-container-low border-none rounded-xl px-5 py-4 focus:ring-2 focus:ring-primary/20 transition-all text-on-surface"
                                                        placeholder="Nhập mật khẩu mới" type="password"
                                                        name="newPassword" minlength="8" required />
                                                    <button type="button"
                                                        class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-primary toggle-password">
                                                        <span class="material-symbols-outlined"
                                                            data-icon="visibility">visibility</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="space-y-2">
                                                <label
                                                    class="text-sm font-semibold text-on-surface-variant flex items-center gap-2">
                                                    <span class="material-symbols-outlined text-sm"
                                                        data-icon="verified_user">verified_user</span>
                                                    Xác nhận mật khẩu mới
                                                </label>
                                                <div class="relative">
                                                    <input id="confirmPassword"
                                                        class="w-full bg-surface-container-low border-none rounded-xl px-5 py-4 focus:ring-2 focus:ring-primary/20 transition-all text-on-surface"
                                                        placeholder="Nhập lại mật khẩu mới" type="password"
                                                        name="confirmPassword" minlength="8" required />
                                                    <button type="button"
                                                        class="absolute right-4 top-1/2 -translate-y-1/2 text-outline hover:text-primary toggle-password">
                                                        <span class="material-symbols-outlined"
                                                            data-icon="visibility">visibility</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div id="passwordRequirements"
                                                class="space-y-2 px-4 py-4 rounded-2xl border border-neutral-200 bg-surface-container-highest text-sm text-on-surface-variant">
                                                <p class="font-semibold text-on-surface mb-2">Yêu cầu mật khẩu mới:</p>
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
                                                <p id="passwordValidationMessage" class="text-error text-sm hidden"></p>
                                            </div>
                                            <div class="pt-4 flex flex-col sm:flex-row gap-4">
                                                <button
                                                    class="hero-gradient text-white px-10 py-4 rounded-xl font-bold text-base shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-95 transition-all flex-1"
                                                    type="submit">
                                                    Đổi mật khẩu
                                                </button>
                                                <button
                                                    class="bg-surface-container-highest text-on-surface px-10 py-4 rounded-xl font-bold text-base hover:bg-surface-container-high transition-all"
                                                    type="reset">
                                                    Huỷ
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                <!-- Sidebar Info -->
                                <div class="lg:col-span-1 space-y-6">
                                    <!-- Security Info Box -->
                                    <div
                                        class="bg-surface-container-low rounded-xl p-6 border border-outline-variant/20">
                                        <div class="flex items-center gap-3 mb-4 text-primary">
                                            <span class="material-symbols-outlined" data-icon="shield"
                                                style="font-variation-settings: 'FILL' 1;">shield</span>
                                            <h3 class="font-bold text-on-surface">Quy định bảo mật</h3>
                                        </div>
                                        <p class="text-sm text-on-surface-variant leading-relaxed mb-4">
                                            Mật khẩu mạnh giúp bảo vệ tài khoản của bạn tốt hơn khỏi các rủi ro xâm
                                            nhập.
                                        </p>
                                        <ul class="space-y-3">
                                            <li class="flex items-start gap-3 text-sm text-on-surface">
                                                <span class="material-symbols-outlined text-primary text-xs mt-0.5"
                                                    data-icon="check_circle">check_circle</span>
                                                <span>Ít nhất 6 ký tự</span>
                                            </li>
                                            <li class="flex items-start gap-3 text-sm text-on-surface">
                                                <span class="material-symbols-outlined text-primary text-xs mt-0.5"
                                                    data-icon="check_circle">check_circle</span>
                                                <span>Chữ hoa và chữ thường</span>
                                            </li>
                                            <li class="flex items-start gap-3 text-sm text-on-surface">
                                                <span class="material-symbols-outlined text-primary text-xs mt-0.5"
                                                    data-icon="check_circle">check_circle</span>
                                                <span>Số hoặc ký tự đặc biệt (!@#...)</span>
                                            </li>
                                        </ul>
                                    </div>
                                    <!-- Promotion Card -->
                                    <div
                                        class="bg-inverse-surface rounded-xl p-6 text-inverse-on-surface relative overflow-hidden group">
                                        <div class="relative z-10">
                                            <span
                                                class="bg-primary-fixed-dim text-on-primary-fixed px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider mb-2 inline-block">Mẹo
                                                bảo mật</span>
                                            <h4 class="text-lg font-bold text-white mb-2">Đăng xuất từ xa</h4>
                                            <p class="text-white/60 text-xs mb-4">Bạn có thể đăng xuất khỏi tất cả các
                                                thiết
                                                bị khác nếu nghi ngờ tài khoản bị lộ.</p>
                                            <a class="text-primary-fixed font-bold text-xs flex items-center gap-1 group-hover:gap-2 transition-all"
                                                href="#">
                                                Kiểm tra thiết bị <span class="material-symbols-outlined text-xs"
                                                    data-icon="arrow_forward">arrow_forward</span>
                                            </a>
                                        </div>
                                        <div
                                            class="absolute top-0 right-0 w-32 h-32 bg-primary/20 rounded-full -mr-16 -mt-16 blur-2xl">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <!-- Simple Footer -->
                <footer class="bg-surface-container border-t border-neutral-200/50 py-12">
                    <div class="max-w-screen-2xl mx-auto px-6 grid grid-cols-1 md:grid-cols-4 gap-10">
                        <div class="col-span-1 md:col-span-2">
                            <div class="text-2xl font-black italic text-red-700 mb-4">CinemaVN</div>
                            <p class="text-on-surface-variant text-sm max-w-sm leading-relaxed">
                                Hệ thống rạp chiếu phim hiện đại hàng đầu Việt Nam, mang đến trải nghiệm điện ảnh chân
                                thực
                                và đẳng cấp nhất cho khán giả.
                            </p>
                        </div>
                        <div>
                            <h4 class="font-bold text-on-surface mb-4">Liên kết</h4>
                            <ul class="space-y-2 text-sm text-on-surface-variant">
                                <li><a class="hover:text-primary transition-colors" href="#">Về chúng tôi</a></li>
                                <li><a class="hover:text-primary transition-colors" href="#">Chính sách bảo mật</a></li>
                                <li><a class="hover:text-primary transition-colors" href="#">Điều khoản sử dụng</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-on-surface mb-4">Kết nối</h4>
                            <div class="flex gap-4">
                                <a class="w-10 h-10 bg-surface-container-high rounded-full flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                                    href="#">
                                    <span class="material-symbols-outlined" data-icon="public">public</span>
                                </a>
                                <a class="w-10 h-10 bg-surface-container-high rounded-full flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                                    href="#">
                                    <span class="material-symbols-outlined" data-icon="share">share</span>
                                </a>
                                <a class="w-10 h-10 bg-surface-container-high rounded-full flex items-center justify-center hover:bg-primary hover:text-white transition-all"
                                    href="#">
                                    <span class="material-symbols-outlined"
                                        data-icon="contact_support">contact_support</span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div
                        class="max-w-screen-2xl mx-auto px-6 mt-12 pt-8 border-t border-outline-variant/10 text-center text-xs text-on-surface-variant">
                        © 2024 CinemaVN. All rights reserved. Designed for Cinematic Editorial.
                    </div>
                </footer>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Toggle password visibility
                        document.querySelectorAll('.toggle-password').forEach(button => {
                            button.addEventListener('click', function () {
                                const input = this.previousElementSibling;
                                const icon = this.querySelector('.material-symbols-outlined');
                                if (input.type === 'password') {
                                    input.type = 'text';
                                    icon.setAttribute('data-icon', 'visibility_off');
                                    icon.textContent = 'visibility_off';
                                } else {
                                    input.type = 'password';
                                    icon.setAttribute('data-icon', 'visibility');
                                    icon.textContent = 'visibility';
                                }
                            });
                        });

                        // Password strength / validation
                        const newPasswordInput = document.getElementById('newPassword');
                        const confirmPasswordInput = document.getElementById('confirmPassword');
                        const passwordRequirements = [
                            { id: 'requirementLength', regex: /.{8,}/ },
                            { id: 'requirementUpper', regex: /[A-Z]/ },
                            { id: 'requirementLower', regex: /[a-z]/ },
                            { id: 'requirementDigit', regex: /[0-9]/ },
                            { id: 'requirementSpecial', regex: /[!@#$%^&*]/ }
                        ];
                        const requirementMatch = document.getElementById('requirementMatch');
                        const validationMessage = document.getElementById('passwordValidationMessage');
                        const form = document.querySelector('form[action="/change-password"]');

                        function updatePasswordRequirements() {
                            const password = newPasswordInput.value;
                            passwordRequirements.forEach(rule => {
                                const element = document.getElementById(rule.id);
                                const passed = rule.regex.test(password);
                                element.classList.toggle('text-green-600', passed);
                                element.classList.toggle('text-on-surface-variant', !passed);
                                element.querySelector('span').classList.toggle('bg-green-600', passed);
                                element.querySelector('span').classList.toggle('bg-error', !passed);
                            });
                            updatePasswordMatch();
                        }

                        function updatePasswordMatch() {
                            const match = newPasswordInput.value !== '' && newPasswordInput.value === confirmPasswordInput.value;
                            requirementMatch.classList.toggle('text-green-600', match);
                            requirementMatch.classList.toggle('text-on-surface-variant', !match);
                            requirementMatch.querySelector('span').classList.toggle('bg-green-600', match);
                            requirementMatch.querySelector('span').classList.toggle('bg-error', !match);
                            return match;
                        }

                        if (newPasswordInput && confirmPasswordInput) {
                            newPasswordInput.addEventListener('input', updatePasswordRequirements);
                            confirmPasswordInput.addEventListener('input', updatePasswordMatch);
                        }

                        if (form) {
                            form.addEventListener('submit', function (event) {
                                const password = newPasswordInput.value;
                                const allRulesPassed = passwordRequirements.every(rule => rule.regex.test(password));
                                const passwordsMatch = updatePasswordMatch();
                                if (!allRulesPassed || !passwordsMatch) {
                                    event.preventDefault();
                                    validationMessage.textContent = 'Mật khẩu mới phải đáp ứng tất cả yêu cầu và khớp với xác nhận.';
                                    validationMessage.classList.remove('hidden');
                                    newPasswordInput.focus();
                                }
                            });
                        }

                        // Profile dropdown toggle
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