<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Quản lý Admin - CinemaVN</title>

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

                                <a class="text-neutral-700 hover:text-red-600"
                                    href="/superAdmin">Dashboard</a>

                                <a class="${pageContext.request.requestURI.contains('theaters') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/theaters">Quản lý rạp</a>

                                <a class="${pageContext.request.requestURI.contains('users') && !pageContext.request.requestURI.contains('admins') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/users">Quản lý người dùng</a>

                                <a class="${pageContext.request.requestURI.contains('admins') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/admins">Quản lý admin</a>

                                <a class="${pageContext.request.requestURI.contains('reports') ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
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
                    <main class="pt-28 px-6">
                        <div class="max-w-7xl mx-auto">

                            <!-- SUCCESS MESSAGE -->
                            <c:if test="${not empty param.success}">
                                <div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-800 rounded-lg">
                                    ${param.success}
                                </div>
                            </c:if>

                            <!-- ERROR MESSAGE -->
                            <c:if test="${not empty param.error}">
                                <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-800 rounded-lg">
                                    ${param.error}
                                </div>
                            </c:if>

                            <!-- HEADER -->
                            <div class="flex justify-between items-center mb-8">
                                <div>
                                    <h1 class="text-3xl font-bold mb-2">Quản lý Admin Rạp</h1>
                                    <p class="text-gray-600">Danh sách quản lý rạp/cấp phó</p>
                                </div>
                                <a href="/superAdmin/admins/create"
                                    class="btn-primary bg-red-600 text-white hover:bg-red-700">
                                    + Thêm Admin Mới
                                </a>
                            </div>

                            <!-- TABLE -->
                            <div class="bg-white rounded-xl shadow overflow-hidden">
                                <table class="w-full">
                                    <thead class="bg-gray-100 border-b">
                                        <tr>
                                            <th class="px-6 py-4 text-left font-semibold text-gray-900">ID</th>
                                            <th class="px-6 py-4 text-left font-semibold text-gray-900">Tên Đăng Nhập</th>
                                            <th class="px-6 py-4 text-left font-semibold text-gray-900">Tên Người Dùng</th>
                                            <th class="px-6 py-4 text-left font-semibold text-gray-900">Email</th>
                                            <th class="px-6 py-4 text-left font-semibold text-gray-900">Rạp Chiếu</th>
                                            <th class="px-6 py-4 text-left font-semibold text-gray-900">Hành Động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="admin" items="${admins}">
                                            <tr class="border-b hover:bg-gray-50">
                                                <td class="px-6 py-4 text-sm text-gray-900">
                                                    ${admin.adminId}
                                                </td>
                                                <td class="px-6 py-4 text-sm text-gray-900">
                                                    ${admin.user.username}
                                                </td>
                                                <td class="px-6 py-4 text-sm text-gray-900">
                                                    ${admin.user.fullName}
                                                </td>
                                                <td class="px-6 py-4 text-sm text-gray-900">
                                                    ${admin.user.email}
                                                </td>
                                                <td class="px-6 py-4 text-sm text-gray-900">
                                                    ${admin.cinema.cinemaName}
                                                </td>
                                                <td class="px-6 py-4 text-sm space-x-2">
                                                    <a href="/superAdmin/admins/edit/${admin.adminId}"
                                                        class="inline-block px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 text-xs">
                                                        Sửa
                                                    </a>
                                                    <a href="/superAdmin/admins/delete/${admin.adminId}"
                                                        onclick="return confirm('Bạn chắc chắn muốn xóa admin này?')"
                                                        class="inline-block px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 text-xs">
                                                        Xóa
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <!-- EMPTY STATE -->
                                <c:if test="${empty admins}">
                                    <div class="p-12 text-center text-gray-500">
                                        <p>Chưa có admin nào. Bắt đầu bằng cách thêm một admin mới.</p>
                                    </div>
                                </c:if>
                            </div>

                        </div>
                    </main>

                </c:when>

                <c:otherwise>
                    <div class="flex items-center justify-center min-h-screen">
                        <div class="text-center">
                            <p class="text-red-600 text-lg font-semibold">Vui lòng đăng nhập để tiếp tục.</p>
                            <p class="text-gray-600 mt-2"><a href="/login"
                                    class="text-red-600 hover:underline">Quay lại đăng nhập</a></p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>

        </body>

        </html>
