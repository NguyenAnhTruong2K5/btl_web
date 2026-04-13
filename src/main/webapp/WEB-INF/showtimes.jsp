<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/13/2026
  Time: 10:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý suất chiếu</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
        }

        .fade-message {
            opacity: 1;
            transition: opacity 0.5s ease;
        }

        .fade-out {
            opacity: 0;
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

                <div class="hidden md:flex items-center space-x-8 font-semibold text-sm">
                    <a href="${pageContext.request.contextPath}/admin/rooms"
                       class="text-gray-800 font-semibold hover:text-red-600 pb-1">
                        Phòng chiếu
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/showtimes"
                       class="text-red-700 font-bold border-b-2 border-red-700">
                        Suất chiếu
                    </a>
                </div>

                <div class="flex items-center gap-4">
                    <span class="font-bold text-sm">
                            ${sessionScope.currentUser.fullName}
                    </span>

                    <a href="${pageContext.request.contextPath}/logout"
                       class="bg-red-600 text-white px-6 py-2 rounded-full font-bold hover:bg-red-700">
                        Đăng xuất
                    </a>
                </div>

            </div>
        </nav>

        <!-- MAIN -->
        <main class="pt-28 px-6">
            <div class="max-w-6xl mx-auto space-y-6">

                <h1 class="text-3xl font-bold">Quản lý suất chiếu</h1>

                <!-- QUAY LẠI DASHBOARD -->
                <a href="${pageContext.request.contextPath}/admin/cinema"
                   class="inline-flex items-center gap-2 bg-gray-200 hover:bg-gray-300 text-black px-4 py-2 rounded-lg font-medium transition">
                    ← Dashboard
                </a>

                <!-- SUCCESS MESSAGE -->
                <c:if test="${not empty message}">
                    <div id="successBox"
                         class="fade-message bg-green-100 text-green-700 border border-green-200 px-4 py-3 rounded-lg">
                            ${message}
                    </div>
                </c:if>

                <!-- ERROR MESSAGE -->
                <c:if test="${not empty error}">
                    <div id="errorBox"
                         class="fade-message bg-red-100 text-red-700 border border-red-300 px-4 py-3 rounded-lg">
                            ${error}
                    </div>
                </c:if>

                <!-- ACTION BAR -->
                <div class="flex justify-end items-center gap-4 flex-wrap">
                    <a href="${pageContext.request.contextPath}/admin/showtimes/create"
                       class="bg-green-500 text-white px-5 py-2 rounded-lg font-bold hover:bg-green-600">
                        + Thêm suất chiếu
                    </a>
                </div>

                <!-- CARD -->
                <div class="bg-white rounded-xl shadow p-6 overflow-x-auto">

                    <table class="w-full text-center border-collapse min-w-[1000px]">
                        <thead class="border-b bg-gray-100">
                        <tr>
                            <th class="py-3">ID</th>
                            <th>Phim</th>
                            <th>Phòng</th>
                            <th>Ngày chiếu</th>
                            <th>Giờ bắt đầu</th>
                            <th>Giờ kết thúc</th>
                            <th>Giá vé</th>
                            <th>Trạng thái</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach var="s" items="${showtimes}">
                            <tr class="border-b hover:bg-gray-50">
                                <td class="py-3">${s.showtimeId}</td>
                                <td>${s.movie.title}</td>
                                <td>${s.room.roomName}</td>
                                <td>${s.showDate}</td>
                                <td>${s.startTime}</td>
                                <td>${s.endTime}</td>
                                <td>${s.price}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${s.status == 'ACTIVE'}">
                                            <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 font-semibold text-sm">
                                                Đang mở bán
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="px-3 py-1 rounded-full bg-red-100 text-red-700 font-semibold text-sm">
                                                Tạm ngưng
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="py-3">
                                    <div class="flex justify-center gap-2 flex-wrap">
                                        <a href="${pageContext.request.contextPath}/admin/showtimes/edit/${s.showtimeId}"
                                           class="bg-yellow-500 text-white px-3 py-1 rounded-lg hover:bg-yellow-600">
                                            Sửa
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin/showtimes/delete/${s.showtimeId}"
                                           onclick="return confirm('Bạn chắc chắn muốn xóa suất chiếu này?')"
                                           class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600">
                                            Xóa
                                        </a>

                                        <a href="${pageContext.request.contextPath}/admin/showtimes/${s.showtimeId}/seats"
                                           class="bg-blue-500 text-white px-3 py-1 rounded-lg hover:bg-blue-600">
                                            Ghế
                                        </a>

                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <!-- EMPTY -->
                    <c:if test="${empty showtimes}">
                        <p class="text-center text-gray-500 mt-4">
                            Chưa có suất chiếu nào.
                        </p>
                    </c:if>

                </div>

            </div>
        </main>

        <script>
            setTimeout(() => {
                const successBox = document.getElementById("successBox");
                const errorBox = document.getElementById("errorBox");

                if (successBox) {
                    successBox.classList.add("fade-out");
                    setTimeout(() => successBox.remove(), 500);
                }

                if (errorBox) {
                    errorBox.classList.add("fade-out");
                    setTimeout(() => errorBox.remove(), 500);
                }
            }, 2500);
        </script>

    </c:when>

    <c:otherwise>
        <div class="flex items-center justify-center min-h-screen">
            <div class="bg-white p-8 rounded-xl shadow text-center">
                <h2 class="text-2xl font-bold text-red-600 mb-4">Bạn chưa đăng nhập</h2>
                <a href="${pageContext.request.contextPath}/login"
                   class="bg-red-600 text-white px-6 py-2 rounded-lg font-semibold hover:bg-red-700">
                    Đi đến đăng nhập
                </a>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
