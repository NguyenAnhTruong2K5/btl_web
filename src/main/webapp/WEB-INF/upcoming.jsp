<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html class="light" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Phim sắp chiếu - CinemaVN</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,600;0,700;0,800;0,900;1,800;1,900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
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
                            colors: {
                                "outline-variant": "#acadad",
                                "on-error-container": "#510017",
                                "on-secondary-container": "#525151",
                                "on-tertiary-fixed": "#290045",
                                "primary-fixed": "#ff7668",
                                "surface-container-low": "#f0f1f1",
                                "tertiary": "#7941a4",
                                "outline": "#767777",
                                "surface-container-highest": "#dbdddd",
                                "on-secondary-fixed-variant": "#5c5b5b",
                                "surface-variant": "#dbdddd",
                                "secondary-fixed": "#e5e2e1",
                                "on-secondary-fixed": "#403f3f",
                                "error": "#b41340",
                                "primary-container": "#ff7668",
                                "on-surface": "#2d2f2f",
                                "surface-container-high": "#e1e3e3",
                                "on-primary-fixed": "#000000",
                                "on-tertiary-fixed-variant": "#54197f",
                                "surface-tint": "#bb000c",
                                "primary-dim": "#a40009",
                                "surface": "#f6f6f6",
                                "on-secondary": "#f5f2f1",
                                "secondary-container": "#e5e2e1",
                                "on-background": "#2d2f2f",
                                "inverse-surface": "#0c0f0f",
                                "secondary-dim": "#504f4f",
                                "on-primary-container": "#4f0002",
                                "background": "#f6f6f6",
                                "tertiary-container": "#d398ff",
                                "on-error": "#ffefef",
                                "secondary-fixed-dim": "#d6d4d3",
                                "primary-fixed-dim": "#ff5b4c",
                                "on-surface-variant": "#5a5c5c",
                                "secondary": "#5c5b5b",
                                "on-primary-fixed-variant": "#610003",
                                "tertiary-fixed": "#d398ff",
                                "primary": "#bb000c",
                                "surface-container-lowest": "#ffffff",
                                "on-primary": "#ffefed",
                                "inverse-on-surface": "#9c9d9d",
                                "inverse-primary": "#ff5446",
                                "surface-dim": "#d3d5d5",
                                "on-tertiary": "#fceeff",
                                "tertiary-dim": "#6c3497",
                                "error-container": "#f74b6d",
                                "tertiary-fixed-dim": "#c68af3",
                                "surface-container": "#e7e8e8",
                                "surface-bright": "#f6f6f6",
                                "error-dim": "#a70138",
                                "on-tertiary-container": "#4b0b75"
                            },
                            fontFamily: {
                                "headline": ["Be Vietnam Pro"],
                                "body": ["Inter"],
                                "label": ["Inter"]
                            },
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
                        },
                    },
                }
            </script>
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }

                .glass-nav {
                    background: rgba(246, 246, 246, 0.8);
                    backdrop-filter: blur(20px);
                }

                .hero-gradient {
                    background: linear-gradient(135deg, #bb000c 0%, #ff7668 100%);
                }

                .dropdown-menu {
                    display: none;
                }

                .dropdown-menu.open {
                    display: block;
                }
            </style>
        </head>

        <body class="bg-surface font-body text-on-surface">
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
                            href="/promotion">Khuyến mãi</a>
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
            <main class="pt-32 pb-20 px-6 md:px-12 max-w-[1440px] mx-auto">
                <!-- Hero Section Title -->
                <section class="mb-16">
                    <div
                        class="flex flex-col md:flex-row md:items-end justify-between gap-6 border-l-8 border-primary pl-6">
                        <div>
                            <span class="text-primary font-bold tracking-widest text-sm uppercase">Coming
                                Soon</span>
                            <h1
                                class="font-headline text-6xl md:text-7xl font-black text-on-surface editorial-text leading-[1.1] mt-2">
                                Phim
                                sắp chiếu</h1>
                        </div>
                        <p class="max-w-md text-on-surface-variant font-medium text-lg leading-relaxed">
                            Khám phá những siêu phẩm điện ảnh sắp đổ bộ tại CinemaVN. Đặt lịch nhắc nhở để không bỏ
                            lỡ
                            ngày khởi chiếu.
                        </p>
                    </div>
                </section>
                <!-- Bento Grid Layout for Movie Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-x-8 gap-y-16">
                    <c:if test="${empty upcomingMovies}">
                        <div class="col-span-1 md:col-span-2 lg:col-span-4 text-center p-12 text-on-surface-variant">
                            Hiện không có phim sắp chiếu trong database (status = "Sắp chiếu").
                        </div>
                    </c:if>
                    <c:forEach var="movie" items="${upcomingMovies}">
                        <article class="group">
                            <div
                                class="relative overflow-hidden rounded-xl shadow-xl transition-all duration-500 hover:translate-y-[-8px]">
                                <img alt="${movie.title} poster"
                                    class="w-full aspect-[2/3] object-cover transition-transform duration-700 group-hover:scale-110"
                                    src="${movie.poster}" />
                                <div class="absolute top-4 left-4">
                                    <span
                                        class="bg-primary-fixed-dim text-on-primary-container px-3 py-1 rounded-lg text-xs font-bold uppercase tracking-wider backdrop-blur-md">Sắp
                                        chiếu</span>
                                </div>
                            </div>
                            <div class="mt-8 space-y-3">
                                <div class="flex justify-between items-start">
                                    <h2 class="font-headline text-2xl font-extrabold text-on-surface leading-tight">
                                        ${movie.title}</h2>
                                </div>
                                <div class="flex gap-2 text-xs font-bold text-outline uppercase tracking-widest">
                                    <span>${movie.duration} phút</span>
                                </div>
                                <div class="flex items-center gap-2 text-primary font-bold">
                                    <span class="material-symbols-outlined text-lg"
                                        data-icon="calendar_today">calendar_today</span>
                                    <span class="text-sm">Ngày khởi chiếu: ${movie.releaseDate}</span>
                                </div>
                                <p class="text-sm text-on-surface-variant line-clamp-3">${movie.description}</p>
                                <div class="flex gap-3 pt-4">
                                    <a href="${movie.trailer}" target="_blank"
                                        class="flex-1 bg-surface-container-highest text-on-surface py-3 rounded-xl font-bold text-sm transition-all hover:bg-surface-container-high flex items-center justify-center gap-2">
                                        <span class="material-symbols-outlined text-lg"
                                            data-icon="play_circle">play_circle</span>
                                        Xem trailer
                                    </a>
                                    <button
                                        class="w-14 h-12 border-2 border-primary text-primary flex items-center justify-center rounded-xl transition-all hover:bg-primary hover:text-white">
                                        <span class="material-symbols-outlined" data-icon="favorite">favorite</span>
                                    </button>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </main>
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const profileToggle = document.getElementById('profileToggle');
                    const profileMenu = document.getElementById('profileDropdownMenu');

                    if (profileToggle && profileMenu) {
                        profileToggle.addEventListener('click', function (event) {
                            event.stopPropagation();
                            profileMenu.classList.toggle('open');
                            profileMenu.classList.toggle('hidden');
                        });

                        document.addEventListener('click', function () {
                            profileMenu.classList.add('hidden');
                            profileMenu.classList.remove('open');
                        });

                        profileMenu.addEventListener('click', function (event) {
                            event.stopPropagation();
                        });
                    }
                });
            </script>
        </body>

        </html>