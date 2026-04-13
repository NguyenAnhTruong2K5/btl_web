<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phòng chiếu</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700;800;900&family=Inter:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
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
                    <a href="/admin/rooms" class="text-red-700 font-bold border-b-2 border-red-700">
                        Phòng chiếu
                    </a>
                </div>

                <div class="flex items-center gap-4">
                <span class="font-bold text-sm">
                        ${sessionScope.currentUser.fullName}
                </span>

                    <a href="/logout"
                       class="bg-red-600 text-white px-6 py-2 rounded-full font-bold hover:bg-red-700">
                        Đăng xuất
                    </a>
                </div>

            </div>
        </nav>

        <!-- MAIN -->
        <main class="pt-28 px-6">
            <div class="max-w-6xl mx-auto space-y-6">

                <h1 class="text-3xl font-bold">Quản lý phòng chiếu</h1>

                <!-- 🔍 SEARCH + ADD -->
                <div class="flex justify-between items-center">

                    <!-- SEARCH -->
                    <form method="get" action="/admin/rooms" class="flex gap-2">
                        <input type="text" name="keyword" value="${keyword}"
                               placeholder="Tìm phòng..."
                               class="border px-4 py-2 rounded-lg w-64"/>

                        <button class="bg-blue-500 text-white px-4 py-2 rounded-lg">
                            Tìm
                        </button>
                    </form>

                    <!-- ADD -->
                    <a href="/admin/rooms/create"
                       class="bg-green-500 text-white px-5 py-2 rounded-lg font-bold hover:bg-green-600">
                        + Thêm phòng
                    </a>

                </div>

                <!-- CARD -->
                <div class="bg-white rounded-xl shadow p-6">

                    <table class="w-full text-center border-collapse">

                        <thead class="border-b bg-gray-100">
                        <tr>
                            <th class="py-3">ID</th>
                            <th>Tên phòng</th>
                            <th>Số ghế</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:forEach var="r" items="${rooms}">
                            <tr class="border-b hover:bg-gray-50">

                                <td class="py-3">${r.roomId}</td>
                                <td>${r.roomName}</td>
                                <td>${r.totalSeats}</td>

                                <td class="flex justify-center gap-2 py-3">

                                    <!-- SỬA -->
                                    <a href="/admin/rooms/edit/${r.roomId}"
                                       class="bg-yellow-500 text-white px-3 py-1 rounded-lg hover:bg-yellow-600">
                                        Sửa
                                    </a>

                                    <!-- XÓA -->
                                    <a href="/admin/rooms/delete/${r.roomId}"
                                       onclick="return confirm('Bạn chắc chắn muốn xóa phòng này?')"
                                       class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600">
                                        Xóa
                                    </a>

                                    <!-- GHẾ -->
                                    <a href="/admin/seats/${r.roomId}"
                                       class="bg-blue-500 text-white px-3 py-1 rounded-lg hover:bg-blue-600">
                                        Ghế
                                    </a>

                                </td>

                            </tr>
                        </c:forEach>

                        </tbody>

                    </table>

                    <!-- EMPTY -->
                    <c:if test="${empty rooms}">
                        <p class="text-center text-gray-500 mt-4">
                            Chưa có phòng nào.
                        </p>
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