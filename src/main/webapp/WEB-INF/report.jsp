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
                    <main class="pt-28 px-6">
                        <div class="max-w-7xl mx-auto space-y-8">
                            <h1 class="text-3xl font-bold mb-6">Báo cáo doanh thu</h1>
                            
                            <!-- Tổng doanh thu -->
                            <div class="bg-white p-6 shadow rounded-xl">
                                <h3 class="text-lg font-bold mb-2">Tổng doanh thu</h3>
                                <p class="text-4xl font-bold text-green-600">
                                    ${String.format("%,.0f", totalRevenue)} <span class="text-lg">VND</span>
                                </p>
                            </div>
                            
                            <!-- Doanh thu theo ngày -->
                            <div class="bg-white p-6 shadow rounded-xl">
                                <h2 class="text-xl font-bold mb-4">Doanh thu theo ngày</h2>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm">
                                        <thead>
                                            <tr class="border-b">
                                                <th class="text-left py-3 px-4">Ngày</th>
                                                <th class="text-right py-3 px-4">Doanh thu (VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${revenueByDay}" var="item">
                                                <tr class="border-b hover:bg-gray-50">
                                                    <td class="py-3 px-4">${item.date}</td>
                                                    <td class="text-right py-3 px-4 font-semibold text-green-600">
                                                        ${String.format("%,.0f", item.revenue)}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <c:if test="${empty revenueByDay}">
                                        <p class="text-gray-500 text-center py-4">Không có dữ liệu</p>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- Doanh thu theo tháng -->
                            <div class="bg-white p-6 shadow rounded-xl">
                                <h2 class="text-xl font-bold mb-4">Doanh thu theo tháng</h2>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm">
                                        <thead>
                                            <tr class="border-b">
                                                <th class="text-left py-3 px-4">Tháng/Năm</th>
                                                <th class="text-right py-3 px-4">Doanh thu (VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${revenueByMonth}" var="item">
                                                <tr class="border-b hover:bg-gray-50">
                                                    <td class="py-3 px-4">${item.month}/${item.year}</td>
                                                    <td class="text-right py-3 px-4 font-semibold text-green-600">
                                                        ${String.format("%,.0f", item.revenue)}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <c:if test="${empty revenueByMonth}">
                                        <p class="text-gray-500 text-center py-4">Không có dữ liệu</p>
                                    </c:if>
                                </div>
                            </div>
                            
                            <!-- Doanh thu theo năm -->
                            <div class="bg-white p-6 shadow rounded-xl">
                                <h2 class="text-xl font-bold mb-4">Doanh thu theo năm</h2>
                                <div class="overflow-x-auto">
                                    <table class="w-full text-sm">
                                        <thead>
                                            <tr class="border-b">
                                                <th class="text-left py-3 px-4">Năm</th>
                                                <th class="text-right py-3 px-4">Doanh thu (VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${revenueByYear}" var="item">
                                                <tr class="border-b hover:bg-gray-50">
                                                    <td class="py-3 px-4">${item.year}</td>
                                                    <td class="text-right py-3 px-4 font-semibold text-green-600">
                                                        ${String.format("%,.0f", item.revenue)}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <c:if test="${empty revenueByYear}">
                                        <p class="text-gray-500 text-center py-4">Không có dữ liệu</p>
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="mt-6">
                                <a href="/superAdmin/reports/export" class="bg-red-600 text-white px-6 py-2 rounded-lg font-semibold hover:bg-red-700">
                                    Xuất báo cáo Excel
                                </a>
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
