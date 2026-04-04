<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <!DOCTYPE html>

            <html class="light" lang="vi">

            <head>
                <meta charset="utf-8" />
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                <title>Khuyến mại - CinemaVN</title>
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
                                borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
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
                        background-color: #f6f6f6;
                    }

                    h1,
                    h2,
                    h3,
                    .brand-logo {
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

                </nav>
                <main class="pt-32 pb-20 px-6 md:px-12 max-w-[1440px] mx-auto">
                    <!-- Hero Section Header -->
                    <header class="mb-16">
                        <h1
                            class="font-headline text-6xl md:text-7xl font-black text-on-surface editorial-text leading-[1.1] mb-4">
                            KHUYẾN MẠI</h1>
                        <p class="text-on-surface-variant max-w-2xl text-lg font-medium leading-relaxed">Khám phá các ưu
                            đãi
                            độc
                            quyền dành cho tín đồ điện ảnh tại CinemaVN. Tận hưởng trải nghiệm đẳng cấp với chi phí tối
                            ưu.
                        </p>
                    </header>
                    <!-- Bento Grid Promotions -->
                    <div class="grid grid-cols-1 md:grid-cols-12 gap-8">
                        <!-- Featured Promotion (Large) -->
                        <div
                            class="md:col-span-8 group relative overflow-hidden bg-surface-container-lowest rounded-xl shadow-[0_12px_40px_rgba(45,47,47,0.06)] hover:shadow-xl transition-all duration-500">
                            <div class="flex flex-col md:flex-row h-full">
                                <div class="md:w-3/5 overflow-hidden">
                                    <img class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                                        data-alt="vibrant cinema lobby with neon lights and popcorn cinematic aesthetic soft bokeh background"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuDI2KM-aJGpcXDo3fQrz7C1roCar4UN3N-ubNOTwVZXV5WbtThW85j3v_nFmCRNsQcjwETvrSp-skO_6WzIqCbdd1BSw_gQvcqkLLSMBAeFMc3gjHkO7ytjenPyVZBBKSyGhysNqozumogZE7INqYkAJ1RsxiU4Eu0jlegq5wkKzFNXX9_R3XjqP696m832yboUxxHCuq_kGK1HNXyNesW3CeLVlr0_jP_V5Dnch4UQQzkMyZ70NqRiGhkJlj53VIDtHlJc67VAYt8" />
                                </div>
                                <div class="md:w-2/5 p-8 flex flex-col justify-between">
                                    <div>
                                        <div class="flex gap-2 mb-4">
                                            <span
                                                class="bg-primary-fixed-dim text-on-primary-fixed px-3 py-1 rounded-full text-[10px] font-bold tracking-widest uppercase">Hot</span>
                                            <span
                                                class="bg-tertiary-fixed text-on-tertiary-fixed px-3 py-1 rounded-full text-[10px] font-bold tracking-widest uppercase">New</span>
                                        </div>
                                        <h2
                                            class="text-3xl font-black italic tracking-tight text-primary leading-tight mb-4">
                                            Thành
                                            viên mới tặng vé</h2>
                                        <p class="text-on-surface-variant text-sm mb-6 leading-relaxed">Chào mừng bạn
                                            đến
                                            với
                                            cộng
                                            đồng điện ảnh CinemaVN. Đăng ký tài khoản ngay hôm nay để nhận ngay một vé
                                            xem
                                            phim
                                            miễn
                                            phí cho bộ phim bất kỳ.</p>
                                        <div class="flex items-center gap-2 text-outline text-xs font-semibold">
                                            <span class="material-symbols-outlined text-sm">calendar_today</span>
                                            <span>Hạn dùng: 31/12/2024</span>
                                        </div>
                                    </div>
                                    <button
                                        class="mt-8 bg-surface-container-highest text-on-surface py-3 px-6 rounded-full font-bold text-sm flex items-center justify-between group-hover:bg-primary group-hover:text-white transition-colors duration-300">
                                        Xem chi tiết
                                        <span class="material-symbols-outlined">arrow_forward</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <!-- Promotion Card 1 -->
                        <div
                            class="md:col-span-4 group bg-surface-container-lowest rounded-xl p-5 shadow-[0_12px_40px_rgba(45,47,47,0.06)] transition-all duration-300 hover:translate-y-[-4px]">
                            <div class="relative rounded-lg overflow-hidden h-48 mb-6">
                                <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    data-alt="close-up of a movie ticket and red velvet cinema seats dramatic low lighting"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAzqTXHNjupSc6WncHkv0Mj8pGq7kE_5s0WWhRfi-dAJAN8eWNDK0Ngdqsr42PHxZbqw8cxcamMUrv3Z8ygE8qtAg2gYyL0r652DY6s04N6DNKBapQQUcZadJ4OebUgZwz8HkeR4Kc6j29vvkjNM0J0cgANVzFGkyuzCo_niRdq4m97Kda0TlWF2_woYMnHlr2g3dniWtCz-r9VavJ-QfFchb_25iLhnIKbxIDICXrdekuy44NzevfV1A3PZItbbzOOGO6aDYC4zVo" />
                                <div
                                    class="absolute top-3 left-3 bg-primary text-white px-3 py-1 rounded-full text-[10px] font-bold uppercase">
                                    Limited</div>
                            </div>
                            <h3 class="text-xl font-bold text-on-surface mb-2">Thứ 2 vui vẻ - Vé 45K</h3>
                            <p class="text-on-surface-variant text-sm mb-4 line-clamp-2">Khởi đầu tuần mới đầy hứng khởi
                                với
                                mức
                                giá
                                vé đồng hạng cực ưu đãi cho tất cả các suất chiếu.</p>
                            <div class="flex items-center gap-2 text-outline text-xs mb-6">
                                <span class="material-symbols-outlined text-sm">calendar_today</span>
                                <span>Hạn dùng: Tới khi có thông báo mới</span>
                            </div>
                            <button
                                class="w-full py-3 rounded-xl border border-outline-variant/30 text-primary font-bold text-sm transition-all hover:bg-primary/5">Xem
                                chi tiết</button>
                        </div>
                        <!-- Promotion Card 2 -->
                        <div
                            class="md:col-span-4 group bg-surface-container-lowest rounded-xl p-5 shadow-[0_12px_40px_rgba(45,47,47,0.06)] transition-all duration-300 hover:translate-y-[-4px]">
                            <div class="relative rounded-lg overflow-hidden h-48 mb-6">
                                <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    data-alt="delicious buttery popcorn in a red striped bucket with a cold soda on a cinema counter"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBFJTSSvcNFTNBT1L_PbV7EwpjdgSn4EScmFzjdeR1vqd8ilFBWjO9VrNjpqZNZN0QNflWI7xrhmKdvgSWn_y3gSipj8_lHBXVgv-JWoeW92LrH4k8y0A-NmUdYRNjhDvEqQIK82uAk5W7X12Wuc_DJvWKfhZtA77jRRYmm2K3f5N08Ix12RzXfmTVMA1LhdbcsdfyNM5HF0BlMuLLv-Li-udC3LJmfaBUNh0wngnNjovQ4UaEWXmOkywdn0WcXdKhsieAJLwCklDY" />
                                <div
                                    class="absolute top-3 left-3 bg-primary-fixed-dim text-on-primary-fixed px-3 py-1 rounded-full text-[10px] font-bold uppercase">
                                    Hot</div>
                            </div>
                            <h3 class="text-xl font-bold text-on-surface mb-2">Combo bắp nước giảm 20%</h3>
                            <p class="text-on-surface-variant text-sm mb-4 line-clamp-2">Trải nghiệm xem phim trọn vẹn
                                hơn
                                với
                                bộ
                                đôi bắp nước thơm ngon với mức giá tiết kiệm hơn bao giờ hết.</p>
                            <div class="flex items-center gap-2 text-outline text-xs mb-6">
                                <span class="material-symbols-outlined text-sm">calendar_today</span>
                                <span>Hạn dùng: 30/11/2024</span>
                            </div>
                            <button
                                class="w-full py-3 rounded-xl border border-outline-variant/30 text-primary font-bold text-sm transition-all hover:bg-primary/5">Xem
                                chi tiết</button>
                        </div>
                        <!-- Promotion Card 3 -->
                        <div
                            class="md:col-span-4 group bg-surface-container-lowest rounded-xl p-5 shadow-[0_12px_40px_rgba(45,47,47,0.06)] transition-all duration-300 hover:translate-y-[-4px]">
                            <div class="relative rounded-lg overflow-hidden h-48 mb-6">
                                <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-110"
                                    data-alt="group of young students laughing together in a modern library or student lounge sunlit"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuDJ2DZlk1yyffxjy79DcWTMDTyjQOpzDrA9iTQ4vaSgzJxy3Qwhs1-jrNJT_akIQctTeOGpAZnP5CBDJA3CjnHCrwdkuRTUQG2sQ5hczcoSWVue0VkPBabWzTPEWk8PveYXf0J9jEUuF1bcXFlDyXpI5rWCVpjP3B3oWypSjjYjhMdVTNX3Ffoy-R5Qn7EW9Hj3U-nvMS-fewrL8SlaJWgdtyESJ1lpq5UTxmFzEUeE-eb8HjgG4MW6P_TSXYx6dhSDRpGNIFZX9Bs" />
                            </div>
                            <h3 class="text-xl font-bold text-on-surface mb-2">Sinh viên giảm giá</h3>
                            <p class="text-on-surface-variant text-sm mb-4 line-clamp-2">Ưu đãi dành riêng cho HSSV. Chỉ
                                cần
                                xuất
                                trình thẻ HSSV để nhận ngay mức giá đặc biệt cho mọi phim.</p>
                            <div class="flex items-center gap-2 text-outline text-xs mb-6">
                                <span class="material-symbols-outlined text-sm">calendar_today</span>
                                <span>Hạn dùng: Vĩnh viễn</span>
                            </div>
                            <button
                                class="w-full py-3 rounded-xl border border-outline-variant/30 text-primary font-bold text-sm transition-all hover:bg-primary/5">Xem
                                chi tiết</button>
                        </div>
                        <!-- App Banner (Asymmetric Layout Piece) -->
                        <div
                            class="md:col-span-4 rounded-xl bg-gradient-to-br from-primary to-primary-dim p-8 text-on-primary flex flex-col justify-center items-center text-center">
                            <span class="material-symbols-outlined text-6xl mb-4"
                                style="font-variation-settings: 'FILL' 1;">smartphone</span>
                            <h3 class="text-2xl font-black italic tracking-tighter mb-2">TẢI APP NHẬN QUÀ</h3>
                            <p class="text-sm opacity-80 mb-6">Săn deal hời, đặt vé nhanh chóng chỉ với vài lần chạm
                                tay.
                            </p>
                            <div class="flex gap-4">
                                <div class="bg-white/10 backdrop-blur-md p-3 rounded-lg border border-white/20">
                                    <span class="material-symbols-outlined">qr_code_2</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <!-- Footer -->
                <footer
                    class="w-full py-12 mt-20 border-t border-zinc-200 dark:border-zinc-800 bg-zinc-100 dark:bg-zinc-950">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-8 px-12 max-w-[1440px] mx-auto">
                        <div class="space-y-4">
                            <div class="text-lg font-bold text-[#bb000c]">CinemaVN</div>
                            <p class="font-['Inter'] text-xs text-zinc-500 leading-relaxed">Hệ thống rạp chiếu phim hiện
                                đại
                                hàng
                                đầu Việt Nam, mang đến trải nghiệm điện ảnh chuẩn quốc tế.</p>
                        </div>
                        <div>
                            <h4 class="font-bold text-sm mb-4 text-on-surface">Về chúng tôi</h4>
                            <ul class="space-y-2">
                                <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] transition-all underline underline-offset-4"
                                        href="#">Về chúng tôi</a></li>
                                <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] transition-all underline underline-offset-4"
                                        href="#">Hệ thống rạp</a></li>
                                <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] transition-all underline underline-offset-4"
                                        href="#">Tuyển dụng</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-sm mb-4 text-on-surface">Chính sách</h4>
                            <ul class="space-y-2">
                                <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] transition-all underline underline-offset-4"
                                        href="#">Chính sách bảo mật</a></li>
                                <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] transition-all underline underline-offset-4"
                                        href="#">Điều khoản sử dụng</a></li>
                                <li><a class="font-['Inter'] text-xs text-zinc-600 hover:text-[#bb000c] transition-all underline underline-offset-4"
                                        href="#">Câu hỏi thường gặp</a></li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-bold text-sm mb-4 text-on-surface">Kết nối</h4>
                            <div class="flex gap-4">
                                <span
                                    class="material-symbols-outlined text-zinc-600 hover:text-[#bb000c] cursor-pointer">public</span>
                                <span
                                    class="material-symbols-outlined text-zinc-600 hover:text-[#bb000c] cursor-pointer">chat</span>
                                <span
                                    class="material-symbols-outlined text-zinc-600 hover:text-[#bb000c] cursor-pointer">mail</span>
                            </div>
                            <div class="mt-8">
                                <p class="font-['Inter'] text-[10px] text-zinc-400">© 2026 CinemaVN. All Rights
                                    Reserved.
                                </p>
                            </div>
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