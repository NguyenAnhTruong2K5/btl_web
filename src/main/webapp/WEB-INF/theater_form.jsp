
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
                            <h1 class="text-2xl font-bold mb-6">Thông tin rạp</h1>
                            
                            <form method="post" action="/superAdmin/theaters/save" class="space-y-4">
                            
                                <input type="hidden" name="cinemaId" value="${cinema.cinemaId}" />
                            
                                <div>
                                    <label>Tên rạp</label>
                                    <input type="text" name="cinemaName" value="${cinema.cinemaName}" class="w-full border rounded p-2" />
                                </div>
                            
                                <div>
                                    <label>Thành phố</label>
                                    <input type="text" name="city" value="${cinema.city}" class="w-full border rounded p-2" />
                                </div>
                            
                                <div>
                                    <label>Địa chỉ</label>
                                    <input type="text" name="address" value="${cinema.address}" class="w-full border rounded p-2" />
                                </div>
                                <div>
                                    <label>Hãng</label>
                                    <input type="text" name="brand" value="${cinema.brand}" class="w-full border rounded p-2" />
                                </div>
                                <div>
                                    <label>Ảnh</label>
                                    <input type="text" name="imageUrl" value="${cinema.imageUrl}" class="w-full border rounded p-2" />
                                </div>
                                <div>
                                    <label>Số điện thoại</label>
                                    <input type="text" name="phone" value="${cinema.phone}" class="w-full border rounded p-2" />
                                </div>
                                <input type="hidden" name="rating" value="${cinema.rating}" />
                                <button class="bg-red-600 text-white px-6 py-2 rounded">
                                    Lưu
                                </button>
                            
                            </form>
                        </div>
                    </main>

                </c:when>

                <c:otherwise>
                    <script>window.location = '/login'</script>
                </c:otherwise>

            </c:choose>

        </body>

        </html>