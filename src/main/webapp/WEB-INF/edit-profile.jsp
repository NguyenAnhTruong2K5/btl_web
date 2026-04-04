<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html class="light" lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1.0" name="viewport" />
            <title>Chỉnh sửa hồ sơ - CinemaVN Scarlet</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700;800;900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
                rel="stylesheet" />
            <link
                href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
                rel="stylesheet" />
            <style>
                .material-symbols-outlined {
                    font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                }

                .btn-gradient {
                    background: linear-gradient(135deg, #bb000c 0%, #ff7668 100%);
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

        <body class="bg-surface text-on-surface antialiased">
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <nav
                        class="fixed top-0 w-full z-50 bg-white/90 backdrop-blur-md shadow-sm border-b border-neutral-200">
                        <div class="flex justify-between items-center px-8 h-20 max-w-7xl mx-auto">
                            <div class="text-2xl font-black text-red-700 dark:text-red-600 italic tracking-tighter">
                                CinemaVN
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
                                                class="dropdown-menu hidden absolute right-0 mt-2 w-56 bg-white rounded-xl shadow-lg border border-neutral-200 py-2 z-50">
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
                    <main class="pt-28 pb-20 px-6 max-w-5xl mx-auto">
                        <div class="mb-12">
                            <h1 class="text-4xl md:text-5xl font-black tracking-tight mb-2 text-on-surface">Chỉnh
                                sửa hồ
                                sơ</h1>
                            <p class="text-on-surface-variant font-medium">Cập nhật thông tin cá nhân của bạn để
                                nhận ưu
                                đãi và trải nghiệm tốt nhất.</p>
                        </div>
                        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
                            <div
                                class="lg:col-span-4 bg-white p-8 rounded-xl shadow-sm border border-stone-200 flex flex-col items-center">
                                <div class="relative group">
                                    <div class="w-48 h-48 rounded-full overflow-hidden border-4 border-stone-200 mb-6">
                                        <img class="w-full h-full object-cover"
                                            src="https://ui-avatars.com/api/?name=${sessionScope.currentUser.fullName}&background=ff7668&color=fff"
                                            alt="Avatar" />
                                    </div>
                                    <label
                                        class="absolute bottom-6 right-2 w-12 h-12 bg-red-600 text-white rounded-full flex items-center justify-center cursor-pointer shadow-lg hover:scale-110 transition">
                                        <span class="material-symbols-outlined">photo_camera</span>
                                        <input class="hidden" id="avatar-upload" type="file" name="avatar"
                                            accept="image/*" />
                                    </label>
                                </div>
                                <div class="text-center">
                                    <h3 class="font-bold text-lg mb-1">Ảnh đại diện</h3>
                                    <p class="text-xs text-slate-500 leading-relaxed">Định dạng JPG, PNG hoặc GIF.
                                        Tối
                                        đa 5MB.</p>
                                </div>
                                <div class="mt-8 w-full space-y-4 pt-8 border-t border-stone-200">
                                    <div class="flex items-center space-x-3 text-slate-500">
                                        <span class="material-symbols-outlined text-red-700">verified_user</span>
                                        <span
                                            class="text-xs font-semibold uppercase tracking-wider">${sessionScope.currentUser.role.roleName}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="lg:col-span-8 bg-white p-8 rounded-xl shadow-sm border border-stone-200">
                                <c:if test="${not empty profileSuccess}">
                                    <div class="mb-4 p-4 rounded-lg bg-emerald-100 text-emerald-800">
                                        ${profileSuccess}
                                    </div>
                                </c:if>
                                <form action="/profile/edit" method="post" enctype="multipart/form-data"
                                    class="space-y-8">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                        <div class="space-y-2">
                                            <label class="block text-sm font-bold text-slate-800 uppercase"
                                                for="fullName">Họ tên</label>
                                            <div class="relative group">
                                                <span
                                                    class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-slate-400">person</span>
                                                <input id="fullName" name="fullName" type="text"
                                                    value="${sessionScope.currentUser.fullName}"
                                                    class="w-full bg-slate-50 border border-slate-200 rounded-lg py-4 pl-12 pr-4 focus:ring-2 focus:ring-red-200"
                                                    required />
                                            </div>
                                        </div>
                                        <div class="space-y-2">
                                            <label class="block text-sm font-bold text-slate-800 uppercase"
                                                for="phone">Số điện thoại</label>
                                            <div class="relative group">
                                                <span
                                                    class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-slate-400">phone_iphone</span>
                                                <input id="phone" name="phone" type="tel"
                                                    value="${sessionScope.currentUser.phone}"
                                                    class="w-full bg-slate-50 border border-slate-200 rounded-lg py-4 pl-12 pr-4 focus:ring-2 focus:ring-red-200"
                                                    required />
                                            </div>
                                        </div>
                                        <div class="space-y-2">
                                            <label class="block text-sm font-bold text-slate-800 uppercase"
                                                for="email">Email</label>
                                            <div class="relative group">
                                                <span
                                                    class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-slate-400">mail</span>
                                                <input id="email" name="email" type="email"
                                                    value="${sessionScope.currentUser.email}"
                                                    class="w-full bg-slate-100 border border-slate-200 rounded-lg py-4 pl-12 pr-4 cursor-not-allowed"
                                                    disabled />
                                            </div>
                                        </div>
                                        <div class="space-y-2">
                                            <label class="block text-sm font-bold text-slate-800 uppercase"
                                                for="role">Vai trò</label>
                                            <div class="relative group">
                                                <span
                                                    class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-red-700">shield</span>
                                                <input id="role" name="role" type="text"
                                                    value="${sessionScope.currentUser.role.roleName}"
                                                    class="w-full bg-slate-100 border border-slate-200 rounded-lg py-4 pl-12 pr-4 cursor-not-allowed"
                                                    disabled />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="flex flex-col sm:flex-row items-center justify-end gap-4 pt-6">
                                        <a href="/profile"
                                            class="px-8 py-4 rounded-xl border border-slate-300 text-slate-700 font-semibold hover:bg-slate-100 transition">Hủy</a>
                                        <button type="submit"
                                            class="px-10 py-4 rounded-xl text-white btn-gradient font-bold shadow-lg hover:shadow-xl transition">Lưu
                                            thay đổi</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </main>
                    <footer class="bg-stone-100 w-full py-8 px-6">
                        <div class="max-w-7xl mx-auto text-center text-sm text-slate-500">© 2024 CinemaVN Scarlet.
                        </div>
                    </footer>
                    <script>
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
                </c:when>
                <c:otherwise>
                    <script>window.location = '/login';</script>
                </c:otherwise>
            </c:choose>
        </body>

        </html>