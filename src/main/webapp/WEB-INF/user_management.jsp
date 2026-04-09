<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Admin Dashboard - CinemaVN</title>

            <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>

            <link
                href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap"
                rel="stylesheet" />

            <style>
                body {
                    font-family: 'Inter', sans-serif;
                }

                .font-headline {
                    font-family: 'Be Vietnam Pro', sans-serif;
                }

                .btn-primary {
                    padding: 0.625rem 1.5rem;
                    border-radius: 9999px;
                    font-weight: 700;
                }
            </style>

        </head>

        <body class="bg-gray-50 min-h-screen">

            <c:choose>
                <c:when test="${not empty sessionScope.currentUser}">

                    <!-- NAVBAR -->
                    <nav class="fixed top-0 w-full z-50 bg-white shadow-sm border-b">
                        <div class="flex justify-between items-center px-8 h-20 max-w-7xl mx-auto">

                            <div class="text-2xl font-black text-red-700 italic tracking-tighter">
                                CinemaVN
                            </div>

                            <c:set var="currentUri" value="${pageContext.request.servletPath}" />

                            <div class="hidden md:flex items-center space-x-8 font-headline text-sm">

                                <a class="${pageContext.request.requestURI.contains('admin') && !pageContext.request.requestURI.contains('admins') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin">Dashboard</a>

                                <a class="${pageContext.request.requestURI.contains('theaters') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/theaters">Quản lý rạp</a>

                                <a class="${pageContext.request.requestURI.contains('users') && !pageContext.request.requestURI.contains('admins') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/users">Quản lý người dùng</a>

                                <a class="${pageContext.request.requestURI.contains('admins') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/admins">Quản lý admin</a>

                                <a class="${currentUri == '/admin/reports' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/reports">Báo cáo</a>

                            </div>

                            <div class="flex items-center gap-4">
                                <span class="font-bold text-sm">${sessionScope.currentUser.fullName}</span>

                                <a href="/logout" class="bg-red-600 text-white px-6 py-2 rounded-full font-bold">
                                    Đăng xuất
                                </a>

                            </div>

                        </div>
                    </nav>

                    <!-- MAIN -->
                    <main class="pt-28 px-6 pb-12">
                        <div class="max-w-7xl mx-auto">
                            <!-- HEADER -->
                            <div class="flex justify-between items-center mb-8">
                                <div>
                                    <h1 class="text-4xl font-bold text-gray-900">Quản lý Người Dùng</h1>
                                    <p class="text-gray-600 mt-2">Danh sách tất cả tài khoản người dùng</p>
                                </div>
                                <a href="/superAdmin/users/create" class="btn-primary bg-red-600 text-white hover:bg-red-700 shadow-lg">
                                    + Thêm Người Dùng Mới
                                </a>
                            </div>

                            <!-- TABLE -->
                            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                                <div class="overflow-x-auto">
                                    <table class="w-full">
                                        <thead>
                                            <tr class="bg-gray-100 border-b-2 border-gray-300">
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">ID</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Tên Đăng Nhập</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Họ Tên</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Email</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Vai Trò</th>
                                                <th class="px-6 py-4 text-center font-semibold text-gray-900 text-sm">Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${users}" var="u">
                                                <tr class="border-b hover:bg-gray-50 transition">
                                                    <td class="px-6 py-4 text-sm text-gray-900 font-medium">${u.userId}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">${u.username}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">${u.fullName}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">${u.email}</td>
                                                    <td class="px-6 py-4 text-sm">
                                                        <span class="inline-block px-3 py-1 rounded-full text-xs font-semibold 
                                                            <c:choose>
                                                                <c:when test="${u.role.roleName == 'SUPER_ADMIN'}">bg-red-100 text-red-800</c:when>
                                                                <c:when test="${u.role.roleName == 'CINEMA_ADMIN'}">bg-blue-100 text-blue-800</c:when>
                                                                <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                                            </c:choose>">
                                                            ${u.role.roleName}
                                                        </span>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm">
                                                        <div class="flex justify-center gap-2">
                                                            <a href="/superAdmin/users/edit/${u.userId}" 
                                                                class="inline-flex items-center px-3 py-2 bg-blue-600 text-white text-xs font-semibold rounded hover:bg-blue-700 transition shadow">
                                                                ✎ Sửa
                                                            </a>
                                                            <c:if test="${u.role.roleName != 'SUPER_ADMIN'}">
                                                                <a href="/superAdmin/users/delete/${u.userId}" 
                                                                    onclick="return confirm('Bạn chắc chắn muốn xóa người dùng này?')"
                                                                    class="inline-flex items-center px-3 py-2 bg-red-600 text-white text-xs font-semibold rounded hover:bg-red-700 transition shadow">
                                                                    🗑 Xóa
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- EMPTY STATE -->
                                <c:if test="${empty users}">
                                    <div class="p-12 text-center text-gray-500">
                                        <p class="text-lg">Chưa có người dùng nào. Hãy thêm người dùng mới.</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </main>

                </c:when>

                <c:otherwise>
                    <script>window.location = '/login'</script>
                </c:otherwise>

            </c:choose>

        </body>

        </html>