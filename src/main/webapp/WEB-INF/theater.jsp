<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>

        <html class="light" lang="vi">

        <head>
            <meta charset="UTF-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Rạp chiếu - CinemaVN</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:ital,wght@0,400;0,600;0,700;0,900;1,900&amp;family=Inter:wght@400;500;600&amp;display=swap"
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
                            borderRadius: { "DEFAULT": "0.25rem", "lg": "1rem", "xl": "1.5rem", "full": "9999px" },
                        },
                    },
                }
            </script>
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }

                body {
                    font-family: 'Inter', sans-serif;
                }

                h1,
                h2,
                h3 {
                    font-family: 'Be Vietnam Pro', sans-serif;
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
                                    <button id="profileToggle" type="button"
                                        class="flex items-center gap-3 bg-surface-container-low hover:bg-surface-container-high px-4 py-2 rounded-full transition-all border border-outline-variant/20">
                                        <div class="w-8 h-8 rounded-full bg-primary-container overflow-hidden">
                                            <img alt="User Avatar" class="w-full h-full object-cover"
                                                onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullName}&background=ff7668&color=fff'"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCHXG6V7Y-Z6nE0lR8zQ6V4M7L1R3G5H7W9A2B4C6D8E0F2G4H6I8J0" />
                                        </div>
                                        <span
                                            class="font-bold text-sm hidden sm:inline-block">${sessionScope.currentUser.fullName}</span>
                                        <span
                                            class="material-symbols-outlined text-outline transition-transform">expand_more</span>
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
                                                lý hệ thống (Admin)</a>
                                        </c:if>
                                        <a class="flex items-center gap-3 px-4 py-3 hover:bg-red-50 text-error transition-colors text-sm font-bold"
                                            href="/logout"><span
                                                class="material-symbols-outlined text-lg">logout</span>Đăng xuất</a>
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
                <!-- Header Section -->
                <header class="mb-16">
                    <h1
                        class="font-headline text-6xl md:text-7xl font-black text-on-surface editorial-text leading-[1.1] mb-4">
                        Hệ thống rạp</h1>
                    <p class="text-on-surface-variant max-w-2xl text-lg font-body leading-relaxed">
                        Khám phá không gian điện ảnh đẳng cấp với hệ thống rạp hiện đại, âm thanh Dolby Atmos và ghế
                        ngồi
                        VIP
                        thoải mái nhất tại Việt Nam.
                    </p>
                </header>
                <!-- Search & Filter Bento -->
                <section class="grid grid-cols-1 lg:grid-cols-12 gap-6 mb-16">
                    <form method="get" action="/theater"
                        class="lg:col-span-8 bg-surface-container-low p-8 rounded-xl grid grid-cols-1 md:grid-cols-2 gap-8">
                        <div>
                            <label
                                class="block text-xs font-bold uppercase tracking-widest text-outline mb-3 ml-1">Thành
                                phố</label>
                            <div class="relative">
                                <select name="city"
                                    class="w-full appearance-none bg-surface-container-lowest border-none py-4 px-6 rounded-xl text-on-surface font-semibold focus:ring-2 focus:ring-primary/20">
                                    <option value="" <c:if test="${empty selectedCity}">selected</c:if>>Tất cả thành phố
                                    </option>
                                    <option value="Hà Nội" <c:if test="${selectedCity == 'Hà Nội'}">selected</c:if>>Hà
                                        Nội</option>
                                    <option value="TP. Hồ Chí Minh" <c:if test="${selectedCity == 'TP. Hồ Chí Minh'}">
                                        selected</c:if>>TP. Hồ Chí Minh</option>
                                </select>
                                <span
                                    class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-outline"
                                    data-icon="expand_more">expand_more</span>
                            </div>
                        </div>
                        <div>
                            <label class="block text-xs font-bold uppercase tracking-widest text-outline mb-3 ml-1">Hệ
                                thống
                                rạp</label>
                            <div class="relative">
                                <select name="brand"
                                    class="w-full appearance-none bg-surface-container-lowest border-none py-4 px-6 rounded-xl text-on-surface font-semibold focus:ring-2 focus:ring-primary/20">
                                    <option value="" <c:if test="${empty selectedBrand}">selected</c:if>>Tất cả hệ thống
                                    </option>
                                    <option value="CGV" <c:if test="${selectedBrand == 'CGV'}">selected</c:if>>CGV
                                    </option>
                                    <option value="Beta" <c:if test="${selectedBrand == 'Beta'}">selected</c:if>>Beta
                                    </option>
                                    <option value="Lotte" <c:if test="${selectedBrand == 'Lotte'}">selected</c:if>>Lotte
                                    </option>
                                    <option value="Galaxy" <c:if test="${selectedBrand == 'Galaxy'}">selected</c:if>
                                        >Galaxy</option>
                                </select>
                                <span
                                    class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 pointer-events-none text-outline"
                                    data-icon="filter_list">filter_list</span>
                            </div>
                        </div>
                        <div class="md:col-span-2 flex justify-end">
                            <button type="submit"
                                class="bg-primary text-on-primary px-8 py-3 rounded-full font-bold transition-all hover:bg-primary-container">Áp
                                dụng</button>
                        </div>
                    </form>
                    <div
                        class="lg:col-span-4 bg-primary text-on-primary p-8 rounded-xl flex flex-col justify-between overflow-hidden relative group">
                        <div class="z-10">
                            <h3 class="text-2xl font-bold mb-2">Tìm rạp gần bạn nhất</h3>
                            <p class="text-on-primary/80 text-sm font-body">Cho phép định vị để tìm các suất chiếu ngay
                                tại
                                khu
                                vực của bạn.</p>
                        </div>
                        <button
                            class="z-10 flex items-center gap-2 self-start bg-on-primary text-primary px-6 py-3 rounded-full font-bold transition-all group-hover:bg-primary-container group-hover:text-on-primary-container">
                            <span class="material-symbols-outlined text-sm" data-icon="near_me">near_me</span>
                            Định vị ngay
                        </button>
                        <div
                            class="absolute -right-8 -bottom-8 opacity-20 transform rotate-12 transition-transform group-hover:scale-110">
                            <span class="material-symbols-outlined text-[120px]" data-icon="map">map</span>
                        </div>
                    </div>
                </section>
                <!-- Main Content Layout (Cards + Map) -->
                <div class="grid grid-cols-1 xl:grid-cols-3 gap-12 items-start">
                    <!-- Cinema Cards List -->
                    <div class="xl:col-span-2 space-y-6">
                        <c:choose>
                            <c:when test="${not empty cinemas}">
                                <c:forEach var="cinema" items="${cinemas}">
                                    <div
                                        class="group bg-surface-container-lowest p-6 rounded-xl flex flex-col md:flex-row gap-8 transition-all hover:shadow-[0_12px_40px_rgba(45,47,47,0.06)] hover:scale-[1.01]">
                                        <div class="w-full md:w-64 h-48 rounded-lg overflow-hidden shrink-0">
                                            <c:choose>
                                                <c:when test="${not empty cinema.imageUrl}">
                                                    <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                                        src="${cinema.imageUrl}" alt="${cinema.cinemaName}" />
                                                </c:when>
                                                <c:otherwise>
                                                    <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                                        src="https://via.placeholder.com/640x384.png?text=Cinema"
                                                        alt="${cinema.cinemaName}" />
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="flex flex-col justify-between flex-1 py-1">
                                            <div>
                                                <div class="flex items-center gap-2 mb-2">
                                                    <span
                                                        class="bg-primary/10 text-primary px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-tighter">
                                                        <c:out value="${cinema.brand}" />
                                                    </span>
                                                    <span class="text-outline text-xs flex items-center gap-1"><span
                                                            class="material-symbols-outlined text-sm" data-icon="star"
                                                            data-weight="fill">star</span>
                                                        <c:out value="${cinema.rating}" />
                                                    </span>
                                                </div>
                                                <h3 class="text-2xl font-bold text-on-surface mb-3">
                                                    <c:out value="${cinema.cinemaName}" />
                                                </h3>
                                                <div class="space-y-2 text-sm font-body text-on-surface-variant">
                                                    <p class="flex items-center gap-2">
                                                        <span class="material-symbols-outlined text-primary text-lg"
                                                            data-icon="location_on">location_on</span>
                                                        <c:out value="${cinema.address}" />
                                                    </p>
                                                    <p class="flex items-center gap-2">
                                                        <span class="material-symbols-outlined text-primary text-lg"
                                                            data-icon="phone">call</span>
                                                        <c:out value="${cinema.phone}" />
                                                    </p>
                                                </div>
                                            </div>
                                            <div class="mt-6 flex items-center gap-4">
                                                <button
                                                    class="bg-gradient-to-r from-primary to-primary-container text-on-primary px-8 py-3 rounded-xl font-bold flex-1 md:flex-none transition-all active:scale-95">Xem
                                                    lịch chiếu</button>
                                                <button
                                                    class="p-3 rounded-xl bg-surface-container-high text-on-surface hover:bg-surface-container-highest transition-colors">
                                                    <span class="material-symbols-outlined"
                                                        data-icon="favorite">favorite</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div
                                    class="bg-surface-container-lowest p-6 rounded-xl text-center text-on-surface-variant">
                                    Hiện chưa có thông tin rạp chiếu. Vui lòng thử lại sau.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <!-- Map Sticky Section -->
                    <aside class="xl:sticky xl:top-32 h-[calc(100vh-160px)] min-h-[400px]">
                        <div
                            class="h-full w-full bg-surface-container rounded-xl overflow-hidden shadow-inner flex flex-col relative">
                            <div class="absolute inset-0 bg-cover bg-center"
                                data-alt="detailed stylized city map with custom red markers for cinema locations across a modern urban area"
                                data-location="Hanoi"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCVd_-FdNs4ZUPov0_Q1QjXm1ePnsuilHscWwk-krZXconS322POkncautmwSMlhLIgIvWWNgnEj0-1oJUhCpkShCUBGVVbDkczqfSCUbT1hV2dxNmLPkrv4MGntjihrI8fnc0D2iFEM2F3RFSxW_07OnOYxhhT88a7GU4L-bu_AiPjfjkRuwDSq4-VSFgiwKkC9XuWBiayuT6Fbr-7fmC4XEnO8WTLDoS3F-Inr32GSj3h3VBmzow99pZsUmsTJV4KBhmqnSbtils');">
                                <!-- Custom Map Markers -->
                                <div class="absolute top-1/4 left-1/3 group">
                                    <div
                                        class="bg-primary text-on-primary p-2 rounded-full shadow-lg group-hover:scale-110 transition-transform">
                                        <span class="material-symbols-outlined text-sm" data-icon="movie"
                                            data-weight="fill">movie</span>
                                    </div>
                                    <div
                                        class="hidden group-hover:block absolute bottom-full left-1/2 -translate-x-1/2 mb-2 bg-surface-container-lowest p-2 rounded-lg shadow-xl whitespace-nowrap text-xs font-bold border border-outline-variant/20">
                                        CGV Vincom Bà Triệu
                                    </div>
                                </div>
                                <div class="absolute top-1/2 right-1/4 group">
                                    <div
                                        class="bg-tertiary text-on-primary p-2 rounded-full shadow-lg group-hover:scale-110 transition-transform">
                                        <span class="material-symbols-outlined text-sm" data-icon="movie"
                                            data-weight="fill">movie</span>
                                    </div>
                                    <div
                                        class="hidden group-hover:block absolute bottom-full left-1/2 -translate-x-1/2 mb-2 bg-surface-container-lowest p-2 rounded-lg shadow-xl whitespace-nowrap text-xs font-bold border border-outline-variant/20">
                                        Beta Mỹ Đình
                                    </div>
                                </div>
                            </div>
                            <!-- Map Overlay UI -->
                            <div class="mt-auto p-6 z-10 bg-gradient-to-t from-surface-container-lowest to-transparent">
                                <div class="bg-surface-container-lowest/90 backdrop-blur-md p-4 rounded-xl shadow-lg">
                                    <h4 class="font-bold text-on-surface text-sm mb-1">Kết quả bản đồ</h4>
                                    <p class="text-xs text-on-surface-variant">Tìm thấy 24 rạp tại khu vực Hà Nội</p>
                                </div>
                            </div>
                            <!-- Zoom Controls -->
                            <div class="absolute top-6 right-6 flex flex-col gap-2">
                                <button
                                    class="w-10 h-10 bg-surface-container-lowest shadow-lg rounded-lg flex items-center justify-center text-on-surface hover:bg-surface-container-low"><span
                                        class="material-symbols-outlined" data-icon="add">add</span></button>
                                <button
                                    class="w-10 h-10 bg-surface-container-lowest shadow-lg rounded-lg flex items-center justify-center text-on-surface hover:bg-surface-container-low"><span
                                        class="material-symbols-outlined" data-icon="remove">remove</span></button>
                            </div>
                        </div>
                    </aside>
                </div>
            </main>
            <!-- Footer -->
            <footer
                class="bg-zinc-100 dark:bg-zinc-950 w-full py-12 mt-20 border-t border-zinc-200 dark:border-zinc-800">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-8 px-12 max-w-[1440px] mx-auto">
                    <div>
                        <div class="text-lg font-bold text-[#bb000c] mb-6">CinemaVN</div>
                        <p class="font-['Inter'] text-xs text-zinc-500 leading-relaxed">
                            Trải nghiệm điện ảnh đỉnh cao với hệ thống âm thanh, hình ảnh hiện đại nhất. Đặt vé nhanh
                            chóng,
                            ưu
                            đãi ngập tràn.
                        </p>
                    </div>
                    <div>
                        <h4 class="text-xs font-bold uppercase tracking-widest text-[#2d2f2f] dark:text-zinc-400 mb-6">
                            Điều
                            hướng</h4>
                        <ul class="space-y-3">
                            <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] underline underline-offset-4"
                                    href="#">Về chúng tôi</a></li>
                            <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] underline underline-offset-4"
                                    href="#">Phim đang chiếu</a></li>
                            <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] underline underline-offset-4"
                                    href="#">Phim sắp chiếu</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-xs font-bold uppercase tracking-widest text-[#2d2f2f] dark:text-zinc-400 mb-6">
                            Chính
                            sách</h4>
                        <ul class="space-y-3">
                            <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] underline underline-offset-4"
                                    href="#">Chính sách bảo mật</a></li>
                            <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] underline underline-offset-4"
                                    href="#">Điều khoản sử dụng</a></li>
                            <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] underline underline-offset-4"
                                    href="#">Quy định xem phim</a></li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-xs font-bold uppercase tracking-widest text-[#2d2f2f] dark:text-zinc-400 mb-6">
                            Kết
                            nối
                        </h4>
                        <div class="flex gap-4">
                            <a class="w-8 h-8 rounded-full bg-zinc-200 dark:bg-zinc-800 flex items-center justify-center text-[#bb000c] transition-all hover:scale-110"
                                href="#">
                                <span class="material-symbols-outlined text-sm" data-icon="share">share</span>
                            </a>
                            <a class="w-8 h-8 rounded-full bg-zinc-200 dark:bg-zinc-800 flex items-center justify-center text-[#bb000c] transition-all hover:scale-110"
                                href="#">
                                <span class="material-symbols-outlined text-sm" data-icon="language">language</span>
                            </a>
                        </div>
                        <p class="mt-8 font-['Inter'] text-xs text-zinc-500">© 2026 CinemaVN. All Rights Reserved.</p>
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