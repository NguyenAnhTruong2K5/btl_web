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
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="text-red-700 font-bold border-b-2 border-red-700">
                        Phòng chiếu
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/showtimes"
                       class="text-gray-800 font-semibold hover:text-red-600 pb-1">
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

                <h1 class="text-3xl font-bold">Quản lý phòng chiếu</h1>
                <!-- quay lai -->
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

                <!-- SEARCH + ADD -->
                <div class="flex justify-between items-center gap-4 flex-wrap">

                    <!-- SEARCH -->
                    <form method="get" action="${pageContext.request.contextPath}/admin/rooms" class="flex gap-2">
                        <input type="text" name="keyword" value="${keyword}"
                               placeholder="Tìm phòng..."
                               class="border px-4 py-2 rounded-lg w-64"/>

                        <button class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
                            Tìm
                        </button>
                    </form>

                    <!-- ADD -->
                    <button type="button"
                            onclick="openAddModal()"
                            class="bg-green-500 text-white px-5 py-2 rounded-lg font-bold hover:bg-green-600">
                        + Thêm phòng
                    </button>

                </div>

                <!-- CARD -->
                <div class="bg-white rounded-xl shadow p-6 overflow-x-auto">

                    <table class="w-full text-center border-collapse min-w-[700px]">

                        <thead class="border-b bg-gray-100">
                        <tr>
                            <th class="py-3">ID</th>
                            <th>Tên phòng</th>
                            <th>Tổng số ghế</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>

                        <c:forEach var="r" items="${rooms}">
                            <tr class="border-b hover:bg-gray-50">

                                <td class="py-3">${r.roomId}</td>
                                <td>${r.roomName}</td>
                                <td>${r.totalSeats}</td>

                                <td class="py-3">
                                    <div class="flex justify-center gap-2 flex-wrap">

                                        <!-- SỬA -->
                                        <button type="button"
                                                onclick="openEditModal('${r.roomId}', '${r.roomName}', '${r.totalSeats}')"
                                                class="bg-yellow-500 text-white px-3 py-1 rounded-lg hover:bg-yellow-600">
                                            Sửa
                                        </button>

                                        <!-- XÓA -->
                                        <a href="${pageContext.request.contextPath}/admin/rooms/delete/${r.roomId}"
                                           onclick="return confirm('Bạn chắc chắn muốn xóa phòng này?')"
                                           class="bg-red-500 text-white px-3 py-1 rounded-lg hover:bg-red-600">
                                            Xóa
                                        </a>

                                        <!-- GHẾ -->
                                        <a href="${pageContext.request.contextPath}/admin/seats/${r.roomId}"
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
                    <c:if test="${empty rooms}">
                        <p class="text-center text-gray-500 mt-4">
                            Chưa có phòng nào.
                        </p>
                    </c:if>

                </div>

            </div>
        </main>

        <!-- ADD ROOM MODAL -->
        <div id="addRoomModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-[60] px-4">
            <div class="bg-white rounded-2xl shadow-xl w-full max-w-lg">
                <div class="flex items-center justify-between px-6 py-4 border-b">
                    <h2 class="text-xl font-bold">Thêm phòng chiếu</h2>
                    <button type="button" onclick="closeAddModal()" class="text-gray-500 text-2xl leading-none">&times;</button>
                </div>

                <form action="${pageContext.request.contextPath}/admin/rooms/create" method="post" class="p-6 space-y-4">

                    <div>
                        <label class="block text-sm font-semibold mb-2">ID phòng</label>
                        <input type="number" name="roomId" min="1" placeholder="Ví dụ: 1"
                               class="w-full border rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-400" required>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-2">Tên phòng</label>
                        <input type="text" name="roomName" placeholder="Ví dụ: Phòng 1"
                               class="w-full border rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-400" required>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-2">Tổng số ghế</label>
                        <input type="number" name="totalSeats" min="1" placeholder="Ví dụ: 80"
                               class="w-full border rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-400" required>
                    </div>

                    <div class="flex justify-end gap-3 pt-2">
                        <button type="button" onclick="closeAddModal()"
                                class="px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100">
                            Hủy
                        </button>
                        <button type="submit"
                                class="px-5 py-2 rounded-lg bg-green-500 text-white font-semibold hover:bg-green-600">
                            Lưu phòng
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- EDIT ROOM MODAL -->
        <div id="editRoomModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-[60] px-4">
            <div class="bg-white rounded-2xl shadow-xl w-full max-w-lg">
                <div class="flex items-center justify-between px-6 py-4 border-b">
                    <h2 class="text-xl font-bold">Sửa phòng chiếu</h2>
                    <button type="button" onclick="closeEditModal()" class="text-gray-500 text-2xl leading-none">&times;</button>
                </div>

                <form action="${pageContext.request.contextPath}/admin/rooms/update" method="post" class="p-6 space-y-4">
                    <input type="hidden" name="roomId" id="editRoomId">

                    <div>
                        <label class="block text-sm font-semibold mb-2">Tên phòng</label>
                        <input type="text" name="roomName" id="editRoomName"
                               class="w-full border rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400" required>
                    </div>

                    <div>
                        <label class="block text-sm font-semibold mb-2">Tổng số ghế</label>
                        <input type="number" name="totalSeats" id="editTotalSeats" min="0"
                               class="w-full border rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-yellow-400" required>
                    </div>

                    <div class="flex justify-end gap-3 pt-2">
                        <button type="button" onclick="closeEditModal()"
                                class="px-4 py-2 rounded-lg border border-gray-300 hover:bg-gray-100">
                            Hủy
                        </button>
                        <button type="submit"
                                class="px-5 py-2 rounded-lg bg-yellow-500 text-white font-semibold hover:bg-yellow-600">
                            Cập nhật
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openAddModal() {
                const modal = document.getElementById('addRoomModal');
                modal.classList.remove('hidden');
                modal.classList.add('flex');
            }

            function closeAddModal() {
                const modal = document.getElementById('addRoomModal');
                modal.classList.add('hidden');
                modal.classList.remove('flex');
            }

            function openEditModal(roomId, roomName, totalSeats) {
                document.getElementById('editRoomId').value = roomId;
                document.getElementById('editRoomName').value = roomName;
                document.getElementById('editTotalSeats').value = totalSeats;

                const modal = document.getElementById('editRoomModal');
                modal.classList.remove('hidden');
                modal.classList.add('flex');
            }

            function closeEditModal() {
                const modal = document.getElementById('editRoomModal');
                modal.classList.add('hidden');
                modal.classList.remove('flex');
            }

            window.addEventListener('click', function (event) {
                const addModal = document.getElementById('addRoomModal');
                const editModal = document.getElementById('editRoomModal');

                if (event.target === addModal) {
                    closeAddModal();
                }

                if (event.target === editModal) {
                    closeEditModal();
                }
            });

            setTimeout(function () {
                const successBox = document.getElementById("successBox");
                const errorBox = document.getElementById("errorBox");

                if (successBox) {
                    successBox.classList.add("fade-out");
                    setTimeout(function () {
                        successBox.style.display = "none";
                    }, 500);
                }

                if (errorBox) {
                    errorBox.classList.add("fade-out");
                    setTimeout(function () {
                        errorBox.style.display = "none";
                    }, 500);
                }
            }, 3000);
        </script>

    </c:when>

    <c:otherwise>
        <script>window.location = '${pageContext.request.contextPath}/login'</script>
    </c:otherwise>
</c:choose>

</body>
</html>