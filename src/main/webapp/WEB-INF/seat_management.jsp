<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/11/2026
  Time: 9:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <title>Quản lý ghế</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        .seat {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
        }

        .seat-normal {
            background-color: #22c55e;
            color: white;
        }

        .seat-vip {
            background-color: #facc15;
            color: black;
        }

        .seat:hover {
            transform: scale(1.1);
        }
    </style>
</head>

<body class="bg-gray-50 min-h-screen">

<c:choose>
    <c:when test="${not empty sessionScope.currentUser}">

        <!-- NAVBAR -->
        <nav class="fixed top-0 w-full z-50 bg-white shadow-sm border-b">
            <div class="flex justify-between items-center px-8 h-20 max-w-7xl mx-auto">
                <div class="text-2xl font-black text-red-700 italic">
                    CinemaVN
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
            <div class="max-w-5xl mx-auto">

                <h1 class="text-3xl font-bold mb-6">Quản lý ghế</h1>

                <!-- MÀN HÌNH -->
                <div class="text-center mb-6">
                    <div class="bg-gray-300 py-2 rounded-lg w-1/2 mx-auto">
                        SCREEN
                    </div>
                </div>

                <!-- GHẾ -->
                <div class="bg-white p-6 rounded-xl shadow">

                    <div class="flex flex-col items-center gap-3">

                        <c:forEach var="row" items="${seats.stream().map(s -> s.seatRow).distinct().toList()}">

                            <div class="flex gap-2 items-center">

                                <!-- Tên hàng -->
                                <span class="w-6 font-bold">${row}</span>

                                <!-- Ghế trong hàng -->
                                <c:forEach var="s" items="${seats}">
                                    <c:if test="${s.seatRow == row}">

                                        <form action="/admin/seats/update" method="post">
                                            <input type="hidden" name="seatId" value="${s.seatId}" />

                                            <button type="submit"
                                                    class="seat ${s.seatType == 'VIP' ? 'seat-vip' : 'seat-normal'}">
                                                    ${s.seatNumber}
                                            </button>
                                        </form>

                                    </c:if>
                                </c:forEach>

                            </div>

                        </c:forEach>

                    </div>

                </div>

                <!-- CHÚ THÍCH -->
                <div class="flex justify-center gap-6 mt-6">

                    <div class="flex items-center gap-2">
                        <div class="w-5 h-5 bg-green-500 rounded"></div>
                        <span>Ghế thường</span>
                    </div>

                    <div class="flex items-center gap-2">
                        <div class="w-5 h-5 bg-yellow-400 rounded"></div>
                        <span>Ghế VIP</span>
                    </div>

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
