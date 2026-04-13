<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>

        <html class="light" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>CinemaVN - Đặt vé xem phim nhanh chóng</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800;900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
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
                                "on-secondary-fixed-variant": "#5c5b5b",
                                "surface-container-high": "#e1e3e3",
                                "primary-fixed": "#ff7668",
                                "surface": "#f6f6f6",
                                "secondary-container": "#e5e2e1",
                                "on-error": "#ffefef",
                                "surface-container-highest": "#dbdddd",
                                "surface-dim": "#d3d5d5",
                                "tertiary-fixed-dim": "#c68af3",
                                "background": "#f6f6f6",
                                "on-primary-container": "#4f0002",
                                "surface-variant": "#dbdddd",
                                "surface-tint": "#bb000c",
                                "outline": "#767777",
                                "secondary": "#5c5b5b",
                                "on-secondary-fixed": "#403f3f",
                                "surface-container-low": "#f0f1f1",
                                "on-error-container": "#510017",
                                "on-tertiary": "#fceeff",
                                "surface-container": "#e7e8e8",
                                "on-tertiary-fixed": "#290045",
                                "on-tertiary-container": "#4b0b75",
                                "tertiary": "#7941a4",
                                "outline-variant": "#acadad",
                                "inverse-surface": "#0c0f0f",
                                "on-primary": "#ffefed",
                                "surface-container-lowest": "#ffffff",
                                "secondary-fixed": "#e5e2e1",
                                "secondary-fixed-dim": "#d6d4d3",
                                "primary-container": "#ff7668",
                                "inverse-on-surface": "#9c9d9d",
                                "inverse-primary": "#ff5446",
                                "tertiary-container": "#d398ff",
                                "tertiary-dim": "#6c3497",
                                "on-surface-variant": "#5a5c5c",
                                "primary": "#bb000c",
                                "on-secondary-container": "#525151",
                                "error-dim": "#a70138",
                                "tertiary-fixed": "#d398ff",
                                "on-surface": "#2d2f2f",
                                "surface-bright": "#f6f6f6",
                                "on-secondary": "#f5f2f1",
                                "on-primary-fixed-variant": "#610003",
                                "on-background": "#2d2f2f",
                                "error-container": "#f74b6d",
                                "on-primary-fixed": "#000000",
                                "secondary-dim": "#504f4f",
                                "primary-fixed-dim": "#ff5b4c",
                                "primary-dim": "#a40009",
                                "on-tertiary-fixed-variant": "#54197f",
                                "error": "#b41340"
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

                .hero-gradient {
                    background: linear-gradient(135deg, rgba(187, 0, 12, 0.95) 0%, rgba(255, 118, 104, 0.8) 100%);
                }

                .dropdown-menu {
                    display: none;
                }

                .dropdown-menu.open {
                    display: block;
                }

                .editorial-text {
                    letter-spacing: -0.02em;
                }

                ::-webkit-scrollbar {
                    height: 6px;
                }

                ::-webkit-scrollbar-track {
                    background: #f1f1f1;
                }

                ::-webkit-scrollbar-thumb {
                    background: #bb000c;
                    border-radius: 10px;
                }
            </style>
        </head>

        <body class="bg-surface text-on-surface font-body selection:bg-primary selection:text-white">
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
                                            href="/ticket"><span
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
            <main class="pt-20">
                <c:if test="${empty sessionScope.currentUser}">
                    <!-- Hero Section -->
                    <section class="relative h-[819px] flex items-center overflow-hidden">
                        <div class="absolute inset-0 z-0">
                            <img class="w-full h-full object-cover"
                                data-alt="Cinematic theater interior with red velvet seats and a large screen glowing with soft warm ambient light from a movie projection"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuABPNTI2v55FpjhvKToQLwf86JAqA3QhZJtaFTTUoS6cZ_V-SEtzjoO99o1uhvxCnx_BUalkBSjny_gPuzgu63K8ZTDCA5JnVnKbo5w6OTPHZqKNqKpeWBI5S5fnJ-OAVke_k2lJxEndMAC3yfS0zEWRayfsIAVkbns0BsBcWluyqpRUnj5AheOi0DRmxGNrXMBVj6eVgCivgL2HjjkINwmNCld_vPvRhAsRD1B_Unb9a7w5qweYkQGisQTh5QdJhlT7a93ujFsVjk" />
                            <div class="absolute inset-0 hero-gradient"></div>
                        </div>
                        <div class="relative z-10 max-w-7xl mx-auto px-8 w-full">
                            <div class="max-w-2xl space-y-6">
                                <span
                                    class="inline-block px-4 py-1.5 bg-white/20 backdrop-blur-md rounded-full text-white font-semibold text-sm tracking-wider uppercase">Trải
                                    nghiệm điện ảnh đỉnh cao</span>
                                <h1
                                    class="font-headline text-6xl md:text-7xl font-black text-white editorial-text leading-[1.1]">
                                    Đặt vé xem phim nhanh chóng</h1>
                                <p class="text-white/90 text-xl font-medium max-w-lg">Chọn phim hot - Chọn rạp - Đặt
                                    vé
                                    ngay
                                    chỉ
                                    trong vài bước chạm.</p>
                                <div class="flex flex-wrap gap-4 pt-4">
                                    <button
                                        class="bg-white text-primary px-8 py-4 rounded-full font-bold text-lg hover:scale-105 active:scale-95 transition-all shadow-xl shadow-black/10">Xem
                                        phim hot</button>
                                    <a href="/login"
                                        class="inline-flex items-center justify-center bg-white/10 backdrop-blur-md border border-white/30 text-white px-8 py-4 rounded-full font-bold text-lg hover:bg-white/20 transition-all">
                                        Đăng nhập
                                    </a>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:if>
                <!-- Hot Movies Section (Bento Grid Style) -->
                <section id="hot-movies" class="max-w-7xl mx-auto px-8 py-20">
                    <div class="flex justify-between items-end mb-12">
                        <div class="space-y-2">
                            <h2 class="font-headline text-4xl font-bold text-on-surface">Phim Đang Hot</h2>
                            <div class="w-20 h-1.5 bg-primary rounded-full"></div>
                        </div>
                        <a class="text-primary font-bold flex items-center gap-2 group" href="#">
                            Xem tất cả <span
                                class="material-symbols-outlined transition-transform group-hover:translate-x-1">arrow_forward</span>
                        </a>
                    </div>
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                        <c:choose>
                            <c:when test="${not empty nowShowingMovies}">
                                <c:forEach var="movie" items="${nowShowingMovies}" varStatus="status">
                                    <c:if test="${status.index < 3}">
                                        <div
                                            class="group bg-surface-container-lowest p-5 rounded-xl shadow-sm hover:shadow-2xl transition-all duration-500 hover:-translate-y-2">
                                            <div class="relative aspect-[2/3] overflow-hidden rounded-lg mb-6">
                                                <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                                                    data-alt="Poster ${movie.title}" src="${movie.poster}" />
                                                <div
                                                    class="absolute top-4 right-4 bg-primary text-white font-bold px-3 py-1 rounded-full text-xs">
                                                    HOT</div>
                                            </div>
                                            <div class="space-y-3">
                                                <div class="flex justify-between items-start">
                                                    <h3 class="font-headline text-xl font-bold leading-tight">
                                                        ${movie.title}</h3>
                                                    <span class="flex items-center gap-1 text-primary font-bold"><span
                                                            class="material-symbols-outlined text-sm"
                                                            style="font-variation-settings: 'FILL' 1;">star</span>
                                                        ${movie.duration}</span>
                                                </div>
                                                <div
                                                    class="flex flex-wrap gap-2 text-xs font-semibold uppercase text-outline">
                                                    <span>${movie.status}</span> • <span>${movie.duration}
                                                        phút</span>
                                                </div>
                                                <p class="text-on-surface-variant text-sm line-clamp-2">
                                                    ${movie.description}</p>
                                                <%-- 1. Generate the URL and store it in a variable called 'bookingUrl' --%>
                                                <c:url var="bookingUrl" value="/booking/book">
                                                    <c:param name="movie_id" value="${movie.movieId}" />
                                                </c:url>

                                                <%-- 2. Use that variable in your anchor tag --%>
                                                <a href="${bookingUrl}"
                                                   class="w-full bg-surface-container-high hover:bg-primary hover:text-white text-on-surface font-bold py-3 rounded-full transition-colors flex justify-center items-center gap-2 group/btn">
                                                    Đặt vé ngay
                                                    <span class="material-symbols-outlined text-lg group-hover/btn:translate-x-1 transition-transform">
                                                        confirmation_number
                                                    </span>
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div
                                    class="col-span-1 sm:col-span-2 lg:col-span-3 rounded-xl border border-outline-variant/40 p-8 text-center text-outline text-sm">
                                    Hiện chưa có phim đang chiếu để hiển thị.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    </div>
                </section>
                <!-- Now Showing Horizontal Scroll -->
                <section class="bg-surface-container-low py-20">
                    <div class="max-w-7xl mx-auto px-8">
                        <div class="flex items-center gap-4 mb-10">
                            <h2 class="font-headline text-3xl font-bold text-on-surface">Phim Đang Chiếu</h2>
                            <span
                                class="bg-green-100 text-green-700 px-3 py-1 rounded-md text-xs font-bold uppercase tracking-wider">Live
                                Now</span>
                        </div>
                        <div class="flex overflow-x-auto gap-8 pb-8 no-scrollbar scroll-smooth">
                            <div class="flex overflow-x-auto gap-8 pb-8 no-scrollbar scroll-smooth">
                                <c:choose>
                                    <c:when test="${not empty nowShowingMovies}">
                                        <c:forEach var="movie" items="${nowShowingMovies}">
                                            <div class="flex-none w-64 group cursor-pointer">
                                                <div class="relative aspect-[3/4] rounded-2xl overflow-hidden mb-4">
                                                    <img class="w-full h-full object-cover group-hover:scale-105 transition-transform"
                                                        data-alt="Poster ${movie.title}" src="${movie.poster}" />
                                                </div>
                                                <h4 class="font-bold text-lg leading-snug">${movie.title}</h4>
                                                <p class="text-sm text-on-surface-variant">${movie.duration} phút
                                                </p>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-base text-outline font-semibold">Hiện tại chưa
                                            có
                                            phim đang chiếu.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                </section>
                <!-- Coming Soon Section -->
                <section class="max-w-7xl mx-auto px-8 py-20">
                    <div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
                        <div class="lg:col-span-4 space-y-6">
                            <h2 class="font-headline text-5xl font-bold text-on-surface leading-tight">Phim Sắp
                                Chiếu
                            </h2>
                            <p class="text-on-surface-variant text-lg">Đừng bỏ lỡ những siêu phẩm điện ảnh sắp đổ bộ
                                vào
                                hệ
                                thống rạp CinemaVN. Đăng ký nhận thông báo ngay!</p>
                            <div class="flex flex-col gap-4">
                                <div
                                    class="flex items-center gap-4 p-4 bg-white rounded-xl shadow-sm border border-outline-variant/20">
                                    <div
                                        class="w-12 h-12 bg-primary/10 text-primary rounded-full flex items-center justify-center">
                                        <span class="material-symbols-outlined">notifications_active</span>
                                    </div>
                                    <div>
                                        <p class="font-bold">Bật thông báo</p>
                                        <p class="text-xs text-outline">Nhận tin khi có lịch chiếu</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="lg:col-span-8">
                            <div class="grid grid-cols-2 md:grid-cols-3 gap-6">
                                <c:choose>
                                    <c:when test="${not empty upcomingMovies}">
                                        <c:forEach var="movie" items="${upcomingMovies}">
                                            <div class="group relative rounded-2xl overflow-hidden">
                                                <img class="aspect-[3/4] object-cover group-hover:scale-110 transition-transform duration-500"
                                                    data-alt="Poster ${movie.title}" src="${movie.poster}" />
                                                <div class="absolute inset-0 bg-black/40 flex flex-col justify-end p-4">
                                                    <span
                                                        class="bg-primary-fixed-dim text-white text-[10px] font-black w-fit px-2 py-0.5 rounded mb-2 uppercase">Sắp
                                                        chiếu</span>
                                                    <h5 class="text-white font-bold leading-tight">${movie.title}
                                                    </h5>
                                                    <p class="text-xs text-white/90">${movie.releaseDate}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div
                                            class="col-span-2 md:col-span-3 text-center text-base text-outline font-semibold">
                                            Chưa có phim sắp chiếu.</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Cinema Locations -->
                <section class="bg-surface-container py-24">
                    <div class="max-w-7xl mx-auto px-8">
                        <div class="text-center mb-16 space-y-4">
                            <h2 class="font-headline text-4xl font-bold text-on-surface">Tìm Rạp Chiếu Gần Bạn</h2>
                            <p class="text-on-surface-variant max-w-xl mx-auto">Hệ thống rạp chiếu hiện đại với âm
                                thanh
                                Dolby
                                Atmos và màn hình IMAX đỉnh cao.</p>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                            <div
                                class="bg-surface-container-lowest p-6 rounded-2xl shadow-sm hover:shadow-xl transition-all group">
                                <div
                                    class="w-14 h-14 bg-red-50 rounded-2xl flex items-center justify-center mb-6 text-primary transition-transform group-hover:rotate-12">
                                    <span class="material-symbols-outlined text-3xl">location_on</span>
                                </div>
                                <h4 class="font-headline text-xl font-bold mb-2">CGV Vincom</h4>
                                <p class="text-sm text-on-surface-variant mb-6 line-clamp-2">Tầng 5, Vincom Center,
                                    72
                                    Lê
                                    Thánh
                                    Tôn, Quận 1, TP.HCM</p>
                                <button class="text-primary font-bold text-sm flex items-center gap-1 group/btn">
                                    Xem lịch chiếu <span
                                        class="material-symbols-outlined text-lg group-hover/btn:translate-x-1 transition-transform">chevron_right</span>
                                </button>
                            </div>
                            <div
                                class="bg-surface-container-lowest p-6 rounded-2xl shadow-sm hover:shadow-xl transition-all group">
                                <div
                                    class="w-14 h-14 bg-red-50 rounded-2xl flex items-center justify-center mb-6 text-primary transition-transform group-hover:rotate-12">
                                    <span class="material-symbols-outlined text-3xl">location_on</span>
                                </div>
                                <h4 class="font-headline text-xl font-bold mb-2">Beta Mỹ Đình</h4>
                                <p class="text-sm text-on-surface-variant mb-6 line-clamp-2">Tầng 4, Tòa nhà Golden
                                    Field,
                                    Mỹ
                                    Đình, Hà Nội</p>
                                <button class="text-primary font-bold text-sm flex items-center gap-1 group/btn">
                                    Xem lịch chiếu <span
                                        class="material-symbols-outlined text-lg group-hover/btn:translate-x-1 transition-transform">chevron_right</span>
                                </button>
                            </div>
                            <div
                                class="bg-surface-container-lowest p-6 rounded-2xl shadow-sm hover:shadow-xl transition-all group">
                                <div
                                    class="w-14 h-14 bg-red-50 rounded-2xl flex items-center justify-center mb-6 text-primary transition-transform group-hover:rotate-12">
                                    <span class="material-symbols-outlined text-3xl">location_on</span>
                                </div>
                                <h4 class="font-headline text-xl font-bold mb-2">Galaxy Nguyễn Du</h4>
                                <p class="text-sm text-on-surface-variant mb-6 line-clamp-2">116 Nguyễn Du, Quận 1,
                                    TP.HCM
                                </p>
                                <button class="text-primary font-bold text-sm flex items-center gap-1 group/btn">
                                    Xem lịch chiếu <span
                                        class="material-symbols-outlined text-lg group-hover/btn:translate-x-1 transition-transform">chevron_right</span>
                                </button>
                            </div>
                            <div
                                class="bg-surface-container-lowest p-6 rounded-2xl shadow-sm hover:shadow-xl transition-all group">
                                <div
                                    class="w-14 h-14 bg-red-50 rounded-2xl flex items-center justify-center mb-6 text-primary transition-transform group-hover:rotate-12">
                                    <span class="material-symbols-outlined text-3xl">location_on</span>
                                </div>
                                <h4 class="font-headline text-xl font-bold mb-2">Lotte Cinema</h4>
                                <p class="text-sm text-on-surface-variant mb-6 line-clamp-2">Tầng 3, Lotte Center,
                                    54
                                    Liễu
                                    Giai,
                                    Ba Đình, Hà Nội</p>
                                <button class="text-primary font-bold text-sm flex items-center gap-1 group/btn">
                                    Xem lịch chiếu <span
                                        class="material-symbols-outlined text-lg group-hover/btn:translate-x-1 transition-transform">chevron_right</span>
                                </button>
                            </div>
                        </div>
                        <div class="mt-12 h-64 w-full rounded-2xl overflow-hidden grayscale contrast-125 opacity-70">
                            <img class="w-full h-full object-cover"
                                data-alt="Aerial urban map view of a vibrant city center with major roads and building layouts in a minimal aesthetic"
                                data-location="Hanoi, Vietnam"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZf7gHOw3FgORgrvgulGznXGaYKGF-NyOWihcB0EMG7WM9dRinduzvrv4bdEk7ElkpJBoLTUP7LB2lQLwqe_te3-yMV13srIzthTpIrs8tLtxfCf7A0tgrkxU-4uQAOmsz1K5InvQXDDQJGN-SAaa2sQ-R-JhTxvXz83zgWrsd14UHLHKqEKJfI3QUUigZMrU5oVhb08HMcTfxJJsszf_-FrEU4VGDkQf3kWqW7RhO74XG7CINdxM8_9d4Y9k5SGC183pi0GfTYfI" />
                        </div>
                    </div>
                </section>
            </main>
            <!-- Footer -->
            <footer
                class="w-full py-12 mt-20 bg-neutral-50 dark:bg-neutral-950 border-t border-neutral-200 dark:border-neutral-800">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8 px-8 max-w-7xl mx-auto font-['Inter'] text-sm">
                    <div class="space-y-4">
                        <div class="text-xl font-bold text-neutral-800 dark:text-neutral-200">CinemaVN</div>
                        <p class="text-neutral-500 dark:text-neutral-400">Trải nghiệm điện ảnh tuyệt vời nhất tại
                            Việt
                            Nam.
                            Đặt
                            vé nhanh, thanh toán tiện lợi.</p>
                        <div class="flex gap-4">
                            <a class="w-8 h-8 rounded-full bg-surface-container flex items-center justify-center text-primary hover:scale-110 transition-transform"
                                href="#">
                                <span class="material-symbols-outlined text-lg">public</span>
                            </a>
                            <a class="w-8 h-8 rounded-full bg-surface-container flex items-center justify-center text-primary hover:scale-110 transition-transform"
                                href="#">
                                <span class="material-symbols-outlined text-lg">share</span>
                            </a>
                        </div>
                    </div>
                    <div class="space-y-4">
                        <h5 class="font-bold text-neutral-800 dark:text-neutral-200">Về Chúng Tôi</h5>
                        <ul class="space-y-2">
                            <li><a class="text-neutral-500 hover:text-neutral-900 dark:text-neutral-400 dark:hover:text-white transition-all underline decoration-red-500/30 underline-offset-4"
                                    href="#">Thông tin liên hệ</a></li>
                            <li><a class="text-neutral-500 hover:text-neutral-900 dark:text-neutral-400 dark:hover:text-white transition-all underline decoration-red-500/30 underline-offset-4"
                                    href="#">Chính sách bảo mật</a></li>
                        </ul>
                    </div>
                    <div class="space-y-4">
                        <h5 class="font-bold text-neutral-800 dark:text-neutral-200">Hỗ Trợ</h5>
                        <ul class="space-y-2">
                            <li><a class="text-neutral-500 hover:text-neutral-900 dark:text-neutral-400 dark:hover:text-white transition-all underline decoration-red-500/30 underline-offset-4"
                                    href="#">Điều khoản sử dụng</a></li>
                            <li><a class="text-neutral-500 hover:text-neutral-900 dark:text-neutral-400 dark:hover:text-white transition-all underline decoration-red-500/30 underline-offset-4"
                                    href="#">Câu hỏi thường gặp</a></li>
                        </ul>
                    </div>
                    <div class="space-y-4">
                        <h5 class="font-bold text-neutral-800 dark:text-neutral-200">Tải Ứng Dụng</h5>
                        <div class="flex flex-col gap-2">
                            <button
                                class="bg-neutral-900 text-white flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-black transition-colors">
                                <span class="material-symbols-outlined">phone_iphone</span>
                                <div class="text-left">
                                    <p class="text-[10px] uppercase opacity-70">Download on</p>
                                    <p class="text-xs font-bold">App Store</p>
                                </div>
                            </button>
                            <button
                                class="bg-neutral-900 text-white flex items-center gap-3 px-4 py-2 rounded-lg hover:bg-black transition-colors">
                                <span class="material-symbols-outlined">play_arrow</span>
                                <div class="text-left">
                                    <p class="text-[10px] uppercase opacity-70">Get it on</p>
                                    <p class="text-xs font-bold">Google Play</p>
                                </div>
                            </button>
                        </div>
                    </div>
                </div>
                <div
                    class="max-w-7xl mx-auto px-8 mt-12 pt-8 border-t border-neutral-100 dark:border-neutral-900 flex flex-col md:flex-row justify-between items-center gap-4 text-neutral-400 text-xs">
                    <p>© 2024 CinemaVN. All rights reserved.</p>
                    <div class="flex gap-6">
                        <span>Made with ❤️ in Vietnam</span>
                    </div>
                </div>
            </footer>
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