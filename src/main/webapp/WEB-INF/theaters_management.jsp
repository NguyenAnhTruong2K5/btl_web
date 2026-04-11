
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

                                <a class="${currentUri == '/admin' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin">Dashboard</a>

                                <a class="${currentUri == '/admin/theaters' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/theaters">Quản lý rạp</a>

                                <a class="${currentUri == '/admin/users' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
                                    href="/superAdmin/users">Quản lý người dùng</a>

                                <a class="${currentUri == '/admin/admins' ? 'text-red-700 font-bold border-b-2 border-red-700' : 'text-neutral-700 hover:text-red-600'}"
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
                                    <h1 class="text-4xl font-bold text-gray-900">Quản lý Rạp Chiếu Phim</h1>
                                    <p class="text-gray-600 mt-2">Danh sách tất cả các rạp thuộc hệ thống</p>
                                </div>
                                <a href="/superAdmin/theaters/create" class="btn-primary bg-red-600 text-white hover:bg-red-700 shadow-lg">
                                    + Thêm Rạp Mới
                                </a>
                            </div>

                            <!-- TABLE -->
                            <div class="bg-white rounded-xl shadow-lg overflow-hidden">
                                <div class="overflow-x-auto">
                                    <table class="w-full">
                                        <thead>
                                            <tr class="bg-gray-100 border-b-2 border-gray-300">
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">ID</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Tên Rạp</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Thành Phố</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Địa Chỉ</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Hãng</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Điện Thoại</th>
                                                <th class="px-6 py-4 text-left font-semibold text-gray-900 text-sm">Đánh Giá</th>
                                                <th class="px-6 py-4 text-center font-semibold text-gray-900 text-sm">Hành Động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${cinemas}" var="c">
                                                <tr class="border-b hover:bg-gray-50 transition">
                                                    <td class="px-6 py-4 text-sm text-gray-900 font-medium">${c.cinemaId}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900 font-semibold">${c.cinemaName}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">${c.city}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">${c.address}</td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">
                                                        <span class="inline-block px-2 py-1 rounded text-xs font-semibold bg-indigo-100 text-indigo-800">
                                                            ${c.brand}
                                                        </span>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm text-gray-900">${c.phone}</td>
                                                    <td class="px-6 py-4 text-sm">
                                                        <div class="flex items-center gap-1">
                                                            <span class="text-yellow-500">★</span>
                                                            <span class="font-semibold text-gray-900">${c.rating != null ? c.rating : 'N/A'}</span>
                                                        </div>
                                                    </td>
                                                    <td class="px-6 py-4 text-sm">
                                                        <div class="flex justify-center gap-2">
                                                            <a href="/superAdmin/theaters/edit/${c.cinemaId}" 
                                                                class="inline-flex items-center px-5 py-2 bg-blue-600 text-white text-xs font-semibold rounded hover:bg-blue-700 transition shadow">
                                                                ✎
                                                            </a>
                                                            <a href="/superAdmin/theaters/delete/${c.cinemaId}" 
                                                                onclick="return confirm('Bạn chắc chắn muốn xóa rạp này?')"
                                                                class="inline-flex items-center px-5 py-2 bg-red-600 text-white text-xs font-semibold rounded hover:bg-red-700 transition shadow">
                                                                🗑
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- EMPTY STATE -->
                                <c:if test="${empty cinemas}">
                                    <div class="p-12 text-center text-gray-500">
                                        <p class="text-lg">Chưa có rạp nào. Hãy thêm rạp mới.</p>
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