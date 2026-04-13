<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/14/2026
  Time: 1:35 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ghế của suất chiếu</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">

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
            <span class="font-bold text-sm">${sessionScope.currentUser.fullName}</span>
            <a href="${pageContext.request.contextPath}/logout"
               class="bg-red-600 text-white px-6 py-2 rounded-full font-bold hover:bg-red-700">
                Đăng xuất
            </a>
        </div>
    </div>
</nav>

<main class="pt-28 px-6">
    <div class="max-w-6xl mx-auto space-y-6">
        <h1 class="text-3xl font-bold">Trạng thái ghế của suất chiếu</h1>

        <div class="bg-white rounded-xl shadow p-5">
            <p><strong>Phim:</strong> ${showtime.movie.title}</p>
            <p><strong>Phòng:</strong> ${showtime.room.roomName}</p>
            <p><strong>Ngày chiếu:</strong> ${showtime.showDate}</p>
            <p><strong>Giờ:</strong> ${showtime.startTime} - ${showtime.endTime}</p>
        </div>

        <a href="${pageContext.request.contextPath}/admin/showtimes"
           class="inline-flex items-center gap-2 bg-gray-200 hover:bg-gray-300 text-black px-4 py-2 rounded-lg font-medium transition">
            ← Quay lại danh sách suất chiếu
        </a>

        <div class="bg-white rounded-xl shadow p-6 overflow-x-auto">
            <table class="w-full text-center border-collapse min-w-[800px]">
                <thead class="border-b bg-gray-100">
                <tr>
                    <th class="py-3">ID ghế</th>
                    <th>Hàng</th>
                    <th>Số ghế</th>
                    <th>Loại ghế</th>
                    <th>Trạng thái</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="ss" items="${seatStatuses}">
                    <tr class="border-b hover:bg-gray-50">
                        <td class="py-3">${ss.seat.seatId}</td>
                        <td>${ss.seat.seatRow}</td>
                        <td>${ss.seat.seatNumber}</td>
                        <td>${ss.seat.seatType}</td>
                        <td>
                            <c:choose>
                                <c:when test="${ss.status == 'AVAILABLE'}">
                                    <span class="px-3 py-1 rounded-full bg-green-100 text-green-700 font-semibold text-sm">
                                        Còn trống
                                    </span>
                                </c:when>
                                <c:when test="${ss.status == 'BOOKED'}">
                                    <span class="px-3 py-1 rounded-full bg-red-100 text-red-700 font-semibold text-sm">
                                        Đã đặt
                                    </span>
                                </c:when>
                                <c:when test="${ss.status == 'HOLD'}">
                                    <span class="px-3 py-1 rounded-full bg-yellow-100 text-yellow-700 font-semibold text-sm">
                                        Đang giữ
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="px-3 py-1 rounded-full bg-gray-100 text-gray-700 font-semibold text-sm">
                                            ${ss.status}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <c:if test="${empty seatStatuses}">
                <p class="text-center text-gray-500 mt-4">
                    Suất chiếu này chưa có dữ liệu trạng thái ghế.
                </p>
            </c:if>
        </div>
    </div>
</main>

</body>
</html>