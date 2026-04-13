<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/14/2026
  Time: 12:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa suất chiếu</title>

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
            <div class="max-w-3xl mx-auto space-y-6">

                <h1 class="text-3xl font-bold">Sửa suất chiếu</h1>

                <!-- BACK -->
                <div>
                    <a href="${pageContext.request.contextPath}/admin/showtimes"
                       class="inline-flex items-center gap-2 bg-gray-200 hover:bg-gray-300 text-black px-4 py-2 rounded-lg font-medium transition">
                        ← Quay lại danh sách
                    </a>
                </div>

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

                <!-- FORM -->
                <div class="bg-white rounded-xl shadow p-6">
                    <form action="${pageContext.request.contextPath}/admin/showtimes/update" method="post" class="space-y-5">

                        <input type="hidden" name="showtimeId" value="${showtime.showtimeId}">

                        <div>
                            <label class="block mb-2 font-semibold text-gray-700">Phim</label>
                            <select name="movie.movieId"
                                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                    required>
                                <option value="">-- Chọn phim --</option>
                                <c:forEach var="m" items="${movies}">
                                    <option value="${m.movieId}"
                                            <c:if test="${showtime.movie.movieId == m.movieId}">selected</c:if>>
                                            ${m.title}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="block mb-2 font-semibold text-gray-700">Phòng</label>
                            <select name="room.roomId"
                                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                    required>
                                <option value="">-- Chọn phòng --</option>
                                <c:forEach var="r" items="${rooms}">
                                    <option value="${r.roomId}"
                                            <c:if test="${showtime.room.roomId == r.roomId}">selected</c:if>>
                                            ${r.roomName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="block mb-2 font-semibold text-gray-700">Ngày chiếu</label>
                            <input type="date"
                                   name="showDate"
                                   value="${showtime.showDate}"
                                   class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                   required>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block mb-2 font-semibold text-gray-700">Giờ bắt đầu</label>
                                <input type="time"
                                       name="startTime"
                                       value="${showtime.startTime}"
                                       class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                       required>
                            </div>

                            <div>
                                <label class="block mb-2 font-semibold text-gray-700">Giờ kết thúc</label>
                                <input type="time"
                                       name="endTime"
                                       value="${showtime.endTime}"
                                       class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                       required>
                            </div>
                        </div>

                        <div>
                            <label class="block mb-2 font-semibold text-gray-700">Giá vé</label>
                            <input type="number"
                                   name="price"
                                   value="${showtime.price}"
                                   min="0"
                                   step="0.01"
                                   placeholder="Ví dụ: 90000"
                                   class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                   required>
                        </div>

                        <div>
                            <label class="block mb-2 font-semibold text-gray-700">Trạng thái</label>
                            <select name="status"
                                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400"
                                    required>
                                <option value="">-- Chọn trạng thái --</option>
                                <option value="ACTIVE" <c:if test="${showtime.status == 'ACTIVE'}">selected</c:if>>
                                    Đang mở bán
                                </option>
                                <option value="INACTIVE" <c:if test="${showtime.status == 'INACTIVE'}">selected</c:if>>
                                    Tạm ngưng
                                </option>
                            </select>
                        </div>

                        <div class="flex items-center gap-3 pt-2">
                            <button type="submit"
                                    class="bg-yellow-500 text-white px-6 py-3 rounded-lg font-bold hover:bg-yellow-600 transition">
                                Cập nhật suất chiếu
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/showtimes"
                               class="bg-gray-200 text-gray-800 px-6 py-3 rounded-lg font-semibold hover:bg-gray-300 transition">
                                Hủy
                            </a>
                        </div>
                    </form>
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
