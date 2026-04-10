<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chọn Rạp và Suất Chiếu</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variable.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .select-input {
            background-color: var(--color-surface-container-low);
            border: 1px solid var(--color-outline);
            color: var(--color-on-surface);
        }
        .select-input:focus {
            border-color: var(--color-primary);
            outline: none;
            box-shadow: 0 0 0 2px var(--color-primary-container);
        }
        .btn-submit {
            background: linear-gradient(135deg, var(--color-primary), var(--color-primary-container));
            color: var(--color-on-primary);
        }
        .btn-submit:disabled {
            background: var(--color-surface-container-high);
            color: var(--color-on-surface-variant);
            cursor: not-allowed;
            transform: none !important;
        }
    </style>
</head>
<body class="bg-login-pattern flex items-center justify-center p-4">

    <div class="w-full max-w-2xl auth-card p-8">
        <a href="${pageContext.request.contextPath}/"
               class="w-10 h-10 rounded-full hover:bg-gray-100 flex items-center justify-center transition-colors text-gray-500 hover:text-primary group/back">
                <span class="material-symbols-outlined text-2xl group-hover/back:-translate-x-1 transition-transform">arrow_back</span>
        </a>

        <h1 class="text-2xl font-bold mb-6 flex items-center gap-2 border-b pb-4" style="color: var(--color-primary)">
            <span class="material-symbols-outlined text-3xl">theaters</span>
            Chọn Rạp & Suất Chiếu
        </h1>

        <c:if test="${not empty msg}">
            <div class="px-4 py-3 rounded-xl mb-6 flex items-center gap-2"
                 style="background-color: #fde8e8; border: 1px solid var(--color-error); color: var(--color-error);">
                <span class="material-symbols-outlined">error</span>
                <p class="font-medium">${msg}</p>
            </div>
        </c:if>

        <form:form action="${pageContext.request.contextPath}/booking/cinema_showtime_room"
                   modelAttribute="cinema_showtime" method="POST" class="space-y-6">

            <div>
                <label class="block text-sm font-semibold mb-2" style="color: var(--color-on-surface)" for="cinemaId">
                    1. Chọn Rạp Chiếu
                </label>
                <div class="relative">
                    <form:select path="cinemaId" id="cinemaSelect"
                        class="select-input w-full appearance-none rounded-xl py-3 px-4 transition-all">
                        <form:option value="" label="-- Vui lòng chọn rạp --" disabled="true" selected="true"/>

                        <c:forEach var="cinema" items="${cinema_list}">
                            <form:option value="${cinema.cinemaId}" label="${cinema.cinemaName}"/>
                        </c:forEach>
                    </form:select>
                    <span class="material-symbols-outlined absolute right-4 top-3.5 pointer-events-none" style="color: var(--color-on-surface-variant)">expand_more</span>
                </div>
            </div>

            <div>
                <label class="block text-sm font-semibold mb-2" style="color: var(--color-on-surface)" for="showtimeId">
                    2. Chọn Suất Chiếu & Phòng
                </label>
                <div class="relative">
                    <form:select path="showtimeId" id="showtimeSelect"
                        class="select-input w-full appearance-none rounded-xl py-3 px-4 transition-all disabled:opacity-50">
                        <form:option value="" label="-- Vui lòng chọn rạp trước --" disabled="true" selected="true"/>

                        <c:forEach var="showtime" items="${showtime_list}">
                            <form:option value="${showtime.showtimeId}"
                                         data-cinema-id="${showtime.room.cinema.cinemaId}"
                                         class="showtime-option"
                                         label="Bắt đầu: ${showtime.startTime} | Phòng: ${showtime.room.roomName}"/>
                        </c:forEach>
                    </form:select>
                    <span class="material-symbols-outlined absolute right-4 top-3.5 pointer-events-none" style="color: var(--color-on-surface-variant)">expand_more</span>
                </div>
            </div>

            <button type="submit" id="submitBtn" disabled
                class="btn-submit w-full mt-8 font-bold py-4 rounded-2xl transition-transform flex justify-center items-center gap-2">
                Tiếp tục đặt vé
                <span class="material-symbols-outlined text-lg">arrow_forward</span>
            </button>

        </form:form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const cinemaSelect = document.getElementById('cinemaSelect');
            const showtimeSelect = document.getElementById('showtimeSelect');
            const submitBtn = document.getElementById('submitBtn');
            const showtimeOptions = Array.from(document.querySelectorAll('.showtime-option'));

            cinemaSelect.addEventListener('change', function() {
                const selectedCinemaId = this.value;

                // Reset showtime dropdown
                showtimeSelect.value = "";
                showtimeSelect.options[0].label = "-- Vui lòng chọn suất chiếu --";
                showtimeSelect.disabled = false;
                submitBtn.disabled = true;

                let hasAvailableShowtimes = false;

                // Filter options dynamically matching data-cinema-id
                showtimeOptions.forEach(option => {
                    const optionCinemaId = option.getAttribute('data-cinema-id');
                    if (optionCinemaId === selectedCinemaId) {
                        option.style.display = '';
                        hasAvailableShowtimes = true;
                    } else {
                        option.style.display = 'none';
                    }
                });

                if(!hasAvailableShowtimes) {
                    showtimeSelect.options[0].label = "-- Không có suất chiếu tại rạp này --";
                    showtimeSelect.disabled = true;
                }
            });

            // Enable submit button when a showtime is selected
            showtimeSelect.addEventListener('change', function() {
                submitBtn.disabled = this.value === "";
            });
        });
    </script>
</body>
</html>