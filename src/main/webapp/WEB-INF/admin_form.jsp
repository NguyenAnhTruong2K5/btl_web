<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="utf-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1" />
            <title>Form Admin - CinemaVN</title>

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
                        <div class="max-w-2xl mx-auto">

                            <!-- ERROR MESSAGE -->
                            <c:if test="${not empty error}">
                                <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-800 rounded-lg">
                                    ${error}
                                </div>
                            </c:if>

                            <!-- HEADER -->
                            <div class="mb-8">
                                <h1 class="text-3xl font-bold mb-2">
                                    <c:choose>
                                        <c:when test="${not empty admin.adminId}">
                                            Sửa Thông Tin Admin
                                        </c:when>
                                        <c:otherwise>
                                            Thêm Admin Mới
                                        </c:otherwise>
                                    </c:choose>
                                </h1>
                            </div>

                            <!-- FORM -->
                            <div class="bg-white rounded-xl shadow p-8">
                                <c:choose>
                                    <c:when test="${not empty admin.adminId}">
                                        <form action="/superAdmin/admins/update/${admin.adminId}" method="POST"
                                            class="space-y-6">
                                    </c:when>
                                    <c:otherwise>
                                        <form action="/superAdmin/admins/save" method="POST"
                                            class="space-y-6">
                                    </c:otherwise>
                                </c:choose>

                                <!-- USER SELECTION -->
                                <div>
                                    <label class="block text-sm font-semibold text-gray-900 mb-2">
                                        Cinema Admin <span class="text-red-600">*</span>
                                    </label>
                                    <p class="text-xs text-gray-500 mb-2">
                                    </p>
                                    <select name="user.userId" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-600"
                                        required>
                                        <option value="">-- Chọn Cinema Admin --</option>
                                        <c:forEach var="user" items="${users}">
                                            <option value="${user.userId}"
                                                ${admin.user.userId == user.userId ? 'selected' : ''}>
                                                ${user.fullName} (${user.email})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- CINEMA SELECTION -->
                                <div>
                                    <label class="block text-sm font-semibold text-gray-900 mb-2">
                                        Rạp Quản Lý <span class="text-red-600">*</span>
                                    </label>
                                    <select name="cinema.cinemaId" class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-600"
                                        required>
                                        <option value="">-- Chọn Rạp --</option>
                                        <c:forEach var="cinema" items="${cinemas}">
                                            <option value="${cinema.cinemaId}"
                                                ${admin.cinema.cinemaId == cinema.cinemaId ? 'selected' : ''}>
                                                ${cinema.cinemaName} (${cinema.city})
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- BUTTONS -->
                                <div class="flex justify-between items-center pt-6 border-t">
                                    <a href="/superAdmin/admins" class="text-gray-600 hover:text-gray-900">
                                        ← Quay Lại
                                    </a>
                                    <button type="submit" class="btn-primary bg-red-600 text-white hover:bg-red-700">
                                        <c:choose>
                                            <c:when test="${not empty admin.adminId}">
                                                Cập Nhật
                                            </c:when>
                                            <c:otherwise>
                                                Thêm Mới
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                </div>

                                </form>
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
