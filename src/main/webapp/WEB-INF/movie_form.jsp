<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${isEdit ? 'Sửa phim' : 'Thêm phim'}</title>

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

            <main class="pt-10 px-6">
                <div class="max-w-3xl mx-auto bg-white rounded-2xl shadow p-8">

                    <h1 class="text-3xl font-bold mb-6">
                        ${isEdit ? 'Sửa phim' : 'Thêm phim'}
                    </h1>

                    <c:if test="${not empty error}">
                        <div class="mb-4 bg-red-100 text-red-700 border border-red-300 px-4 py-3 rounded-lg">
                            ${error}
                        </div>
                    </c:if>

                    <form method="post"
                        action="${pageContext.request.contextPath}${isEdit ? '/admin/movies/update' : '/admin/movies/create'}"
                        class="space-y-5">

                        <c:if test="${isEdit}">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                        </c:if>

                        <div>
                            <label class="block font-semibold mb-2">Tên phim</label>
                            <input type="text" name="title" value="${movie.title}" required
                                class="w-full border rounded-lg px-4 py-2">
                        </div>

                        <div>
                            <label class="block font-semibold mb-2">Mô tả</label>
                            <textarea name="description" rows="4"
                                class="w-full border rounded-lg px-4 py-2">${movie.description}</textarea>
                        </div>

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-5">
                            <div>
                                <label class="block font-semibold mb-2">Thời lượng (phút)</label>
                                <input type="number" name="duration" value="${movie.duration}" required min="1"
                                    class="w-full border rounded-lg px-4 py-2">
                            </div>

                            <div>
                                <label class="block font-semibold mb-2">Ngày phát hành</label>
                                <input type="date" name="releaseDate" value="${movie.releaseDate}"
                                    class="w-full border rounded-lg px-4 py-2">
                            </div>
                        </div>

                        <div>
                            <label class="block font-semibold mb-2">Poster URL</label>
                            <input type="text" name="poster" value="${movie.poster}"
                                class="w-full border rounded-lg px-4 py-2">
                        </div>

                        <div>
                            <label class="block font-semibold mb-2">Trailer URL</label>
                            <input type="text" name="trailer" value="${movie.trailer}"
                                class="w-full border rounded-lg px-4 py-2">
                        </div>

                        <div>
                            <label class="block font-semibold mb-2">Trạng thái</label>
                            <select name="status" class="w-full border rounded-lg px-4 py-2">
                                <option value="Đang chiếu" ${movie.status=='Đang chiếu' || movie.status=='ACTIVE'
                                    ? 'selected' : '' }>Đang chiếu</option>
                                <option value="Sắp chiếu" ${movie.status=='Sắp chiếu' || movie.status=='INACTIVE'
                                    ? 'selected' : '' }>Sắp chiếu</option>
                            </select>
                        </div>

                        <div class="flex gap-3 pt-4">
                            <button type="submit"
                                class="bg-green-600 text-white px-6 py-2 rounded-lg font-bold hover:bg-green-700">
                                ${isEdit ? 'Cập nhật' : 'Thêm mới'}
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/movies"
                                class="bg-gray-300 text-black px-6 py-2 rounded-lg font-medium hover:bg-gray-400">
                                Quay lại
                            </a>
                        </div>
                    </form>
                </div>
            </main>

        </body>

        </html>