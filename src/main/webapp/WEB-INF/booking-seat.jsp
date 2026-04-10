<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn Ghế Ngồi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3b82f6', // Standard Blue
                        vip: '#eab308', // VIP Gold
                        'surface-container-high': '#e2e8f0',
                        'on-surface': '#0f172a'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-slate-100 text-on-surface min-h-screen flex items-center justify-center p-4">

    <div class="w-full max-w-4xl bg-white rounded-2xl shadow-xl p-8">

        <div class="flex items-center gap-3 mb-6 border-b pb-4">
            <a href="${pageContext.request.contextPath}/booking/cinema_showtime_room"
               class="w-10 h-10 rounded-full hover:bg-gray-100 flex items-center justify-center transition-colors text-gray-500 hover:text-primary group/back">
                <span class="material-symbols-outlined text-2xl group-hover/back:-translate-x-1 transition-transform">arrow_back</span>
            </a>

            <h1 class="text-2xl font-bold text-gray-800 flex items-center gap-2">
                <span class="material-symbols-outlined text-primary text-3xl">event_seat</span>
                Chọn Ghế Ngồi
            </h1>
        </div>

        <c:if test="${not empty error_msg}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-xl mb-6 flex items-center gap-2">
                <span class="material-symbols-outlined">error</span>
                <p class="font-medium">${error_msg}</p>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/booking/seat" method="POST">
            <div class="flex flex-wrap justify-center gap-3 mb-10 max-w-2xl mx-auto">
                <c:forEach var="seat" items="${seat_list}">

                    <c:set var="isAvailable" value="false" />
                    <c:forEach var="availSeat" items="${available_seat_list}">
                        <c:if test="${availSeat.seatId == seat.seatId}">
                            <c:set var="isAvailable" value="true" />
                        </c:if>
                    </c:forEach>

                    <c:set var="isSelected" value="false" />
                    <c:if test="${not empty selected_seat_list}">
                        <c:forEach var="selSeat" items="${selected_seat_list}">
                            <c:if test="${selSeat.seatId == seat.seatId}">
                                <c:set var="isSelected" value="true" />
                            </c:if>
                        </c:forEach>
                    </c:if>

                    <c:set var="isVip" value="${seat.seatType == 'VIP' || seat.seatType == 'vip'}" />

                    <label class="cursor-pointer">
                        <input type="checkbox"
                               name="seat_id_list"
                               value="${seat.seatId}"
                               class="hidden peer"
                               ${!isAvailable && !isSelected ? 'disabled' : ''}
                               ${isSelected ? 'checked' : ''} />

                        <div class="w-10 h-10 rounded-t-lg rounded-b-sm border-2 flex items-center justify-center text-xs font-bold transition-all duration-200
                                    ${isVip ? 'border-vip/50 text-vip hover:border-vip peer-checked:bg-vip peer-checked:border-vip peer-checked:text-white'
                                            : 'border-gray-300 text-gray-700 hover:border-primary peer-checked:bg-primary peer-checked:border-primary peer-checked:text-white'}
                                    peer-disabled:bg-gray-200 peer-disabled:border-gray-200 peer-disabled:text-gray-400 peer-disabled:cursor-not-allowed">

                            ${seat.seatRow}${seat.seatNumber}

                        </div>
                    </label>
                </c:forEach>
            </div>

            <div class="flex justify-center gap-6 mb-8 text-sm font-medium text-gray-600">
                <div class="flex items-center gap-2">
                    <div class="w-5 h-5 rounded-t-md border-2 border-gray-300 bg-white"></div>
                    <span>Thường</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-5 h-5 rounded-t-md border-2 border-vip/50 bg-white"></div>
                    <span class="text-vip font-bold">VIP</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-5 h-5 rounded-t-md bg-primary shadow-sm"></div>
                    <span>Đang chọn</span>
                </div>
                <div class="flex items-center gap-2">
                    <div class="w-5 h-5 rounded-t-md bg-gray-200 border-2 border-gray-200"></div>
                    <span>Đã bán</span>
                </div>
            </div>

            <div>
                <a href="${pageContext.request.contextPath}/"
                   class="px-4 py-2 rounded-full hover:bg-red-100 flex items-center justify-center gap-1 transition-colors text-gray-500 hover:text-red-800 font-bold group/cancel">
                    <span class="material-symbols-outlined text-xl group-hover/cancel:rotate-90 transition-transform duration-300 font-bold">
                        close
                    </span>
                    Hủy bỏ
                </a>
            </div>

            <button type="submit"
                class="w-full bg-surface-container-high hover:bg-primary hover:text-white text-gray-600 font-bold py-4 rounded-full transition-colors flex justify-center items-center gap-2 group/btn">
                Xác nhận
            </button>
        </form>
    </div>

</body>
</html>