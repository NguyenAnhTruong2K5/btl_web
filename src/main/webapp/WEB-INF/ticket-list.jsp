<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vé Của Tôi</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#bb000c',
                        'primary-container': '#ff7668',
                        'on-primary': '#ffefed',
                        'surface-container-high': '#e1e3e3',
                        'on-surface': '#2d2f2f',
                        error: '#b41340'
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif']
                    }
                }
            }
        }
    </script>

    <style>
        body { background-color: #f6f6f6; font-family: 'Inter', sans-serif; }
    </style>
</head>
<body class="min-h-screen text-on-surface p-4 md:p-8">

    <div class="max-w-4xl mx-auto">

        <div class="flex items-center gap-3 mb-8 border-b border-gray-200 pb-4">
            <a href="${pageContext.request.contextPath}/profile"
               class="w-10 h-10 rounded-full bg-white shadow-sm hover:bg-gray-50 flex items-center justify-center transition-colors text-gray-500 hover:text-primary group/back">
                <span class="material-symbols-outlined text-2xl group-hover/back:-translate-x-1 transition-transform">arrow_back</span>
            </a>
            <h1 class="text-2xl md:text-3xl font-bold flex items-center gap-2">
                <span class="material-symbols-outlined text-primary text-3xl">confirmation_number</span>
                Danh Sách Vé Của Tôi
            </h1>
        </div>

        <c:if test="${empty ticket_list}">
            <div class="bg-white rounded-2xl shadow-sm p-12 text-center flex flex-col items-center">
                <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mb-4">
                    <span class="material-symbols-outlined text-5xl text-gray-400">receipt_long</span>
                </div>
                <h2 class="text-xl font-bold text-gray-800 mb-2">Bạn chưa có vé nào</h2>
                <p class="text-gray-500 mb-6 max-w-md mx-auto">Có vẻ như bạn chưa thực hiện giao dịch nào. Hãy đặt ngay một vé để trải nghiệm những bộ phim tuyệt vời nhé!</p>

                <a href="${pageContext.request.contextPath}/"
                   class="bg-primary hover:bg-primary-container text-white font-bold py-3 px-8 rounded-xl transition-colors shadow-md">
                    Đặt vé ngay
                </a>
            </div>
        </c:if>

        <c:if test="${not empty ticket_list}">
            <div class="space-y-4">

                <c:forEach var="ticket" items="${ticket_list}">
                    <div class="relative bg-white rounded-2xl shadow-sm hover:shadow-md border border-gray-100 p-5 pl-8 flex flex-col md:flex-row md:items-center justify-between gap-4 transition-all duration-300 overflow-hidden group">
                        <div class="absolute left-0 top-0 bottom-0 w-2 ${ticket.verified ? 'bg-green-500' : 'bg-blue-500'}"></div>

                        <div class="flex items-start gap-4 flex-grow">
                            <div class="mt-1 hidden sm:block">
                                <span class="material-symbols-outlined text-4xl ${ticket.verified ? 'text-gray-300' : 'text-primary-container'}">movie</span>
                            </div>
                            <div>
                                <h3 class="text-xl font-bold text-gray-800 mb-1 leading-tight group-hover:text-primary transition-colors">
                                    ${ticket.movieName}
                                </h3>
                                <p class="text-sm text-gray-500 flex items-center gap-1.5">
                                    <span class="material-symbols-outlined text-[16px]">shopping_bag</span>
                                    Ngày đặt: <span class="font-medium text-gray-700">${ticket.createAt}</span>
                                </p>
                            </div>
                        </div>

                        <div class="flex flex-col sm:flex-row items-start sm:items-center gap-4 border-t md:border-t-0 md:border-l border-dashed border-gray-200 pt-4 md:pt-0 md:pl-6 w-full md:w-auto shrink-0">

                            <div class="flex flex-wrap gap-2 sm:flex-grow-0">
                                <%-- 1. Verification Status --%>
                                <c:choose>
                                    <c:when test="${ticket.verified}">
                                        <span class="px-3 py-1 bg-green-50 text-green-700 text-xs font-bold uppercase rounded-full border border-green-200 flex items-center gap-1 w-fit">
                                            <span class="material-symbols-outlined text-[14px]">verified</span>
                                            Đã xác thực
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${ticket.paid}">
                                                <span class="px-3 py-1 bg-green-50 text-green-700 text-xs font-bold uppercase rounded-full border border-green-200 flex items-center gap-1 w-fit">
                                                    <span class="material-symbols-outlined text-[14px]">payments</span>
                                                    Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-3 py-1 bg-amber-50 text-amber-700 text-xs font-bold uppercase rounded-full border border-amber-200 flex items-center gap-1 w-fit">
                                                    <span class="material-symbols-outlined text-[14px]">error</span>
                                                    Chưa thanh toán
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="flex items-center gap-2 w-full sm:w-auto">

                                <a href="${pageContext.request.contextPath}/ticket/${ticket.bookingId}/detail"
                                   class="flex-1 sm:flex-none px-4 py-2.5 text-sm font-bold text-white bg-gray-800 hover:bg-gray-900 rounded-xl transition-colors flex justify-center items-center gap-1.5">
                                    <span class="material-symbols-outlined text-[18px]">visibility</span>
                                    Chi tiết
                                </a>

                                <c:if test="${!ticket.paid}">
                                    <a href="${pageContext.request.contextPath}/ticket/${ticket.bookingId}/cancel"
                                       onclick="return confirm('Bạn có chắc chắn muốn hủy vé này không? Hành động này không thể hoàn tác.');"
                                       class="flex-1 sm:flex-none px-4 py-2.5 text-sm font-bold text-error bg-error/10 hover:bg-error hover:text-white border border-error/20 rounded-xl transition-all flex justify-center items-center gap-1.5 group/cancel">
                                        <span class="material-symbols-outlined text-[18px] group-hover/cancel:rotate-90 transition-transform">close</span>
                                        Hủy vé
                                    </a>
                                </c:if>

                            </div>

                        </div>
                    </div>
                </c:forEach>

            </div>
        </c:if>

    </div>

</body>
</html>