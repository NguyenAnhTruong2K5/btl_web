<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Admin Dashboard - CinemaVN</title>
            <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800;900&amp;family=Inter:wght@400;500;600;700&amp;display=swap"
                rel="stylesheet" />
            <style>
                body {
                    font-family: 'Inter', sans-serif;
                }

                .font-headline {
                    font-family: 'Be Vietnam Pro', sans-serif;
                }

                .font-body {
                    font-family: 'Inter', sans-serif;
                }

                .btn-primary {
                    padding: 0.625rem 1.5rem;
                    border-radius: 9999px;
                    font-weight: 700;
                }
            </style>
        </head>

        <body class="bg-surface text-on-surface font-body selection:bg-primary selection:text-white min-h-screen">
            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">
                    <nav class="fixed top-0 w-full z-50 bg-white backdrop-blur-md shadow-sm border-b border-gray-200">
                        <div class="flex justify-between items-center px-8 h-20 max-w-7xl mx-auto">
                            <div class="text-2xl font-black text-red-700 italic tracking-tighter">CinemaVN</div>
                            <c:set var="currentUri" value="${pageContext.request.servletPath}" />
                            <div class="hidden md:flex items-center space-x-8 font-headline tracking-tight text-sm">
                                <a class="${currentUri == '/admin' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                                    href="/admin">Dashboard</a>
                                <a class="${currentUri == '/admin/manage-movies' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                                    href="/admin/manage-movies">Quản lý phim</a>
                                <a class="${currentUri == '/admin/manage-users' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                                    href="/admin/manage-users">Quản lý người dùng</a>
                                <a class="${currentUri == '/admin/reports' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'} transition-all duration-300 hover:scale-105"
                                    href="/admin/reports">Báo cáo</a>
                            </div>
                            <div class="flex items-center gap-4">
                                <span
                                    class="font-bold text-sm text-slate-700">${sessionScope.currentUser.fullName}</span>
                                <a href="/logout"
                                    class="bg-primary text-on-primary px-6 py-2.5 rounded-full font-bold transition-transform scale-95 active:scale-100 hover:scale-105">Đăng
                                    xuất</a>
                            </div>
                        </div>
                    </nav>

                    <main class="pt-28 px-6">
                        <div class="max-w-7xl mx-auto">
                            <section class="bg-white rounded-xl p-6 shadow-sm border border-gray-200">
                                <h1 class="text-2xl font-bold text-slate-900 mb-3">Admin Dashboard</h1>
                                <p class="text-base text-slate-600 leading-relaxed">Chào mừng
                                    <strong
                                        class="font-semibold text-slate-900">${sessionScope.currentUser.fullName}</strong>
                                    đến trang quản trị. Đây là khu
                                    vực admin, bạn có thể chọn tính năng cần dùng ở menu trên.
                                </p>
                            </section>
                        </div>
                    </main>
                </c:when>
                <c:otherwise>
                    <script>window.location = '/login';</script>
                </c:otherwise>
            </c:choose>
        </body>

        </html>