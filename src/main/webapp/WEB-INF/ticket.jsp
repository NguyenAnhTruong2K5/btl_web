<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Vé</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Libre+Barcode+39+Text&display=swap" rel="stylesheet">
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
                        sans: ['Inter', 'sans-serif'],
                        barcode: ['"Libre Barcode 39 Text"', 'cursive']
                    }
                }
            }
        }
    </script>

    <style>
        body { background-color: #f6f6f6; }

        /* The ticket cutout circles on the left and right */
        .ticket-divider::before, .ticket-divider::after {
            content: '';
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 30px;
            height: 30px;
            background-color: #f6f6f6; /* Matches body background */
            border-radius: 50%;
            box-shadow: inset 0px 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .ticket-divider::before { left: -15px; }
        .ticket-divider::after { right: -15px; }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 md:p-8">

    <div class="w-full max-w-md mx-auto">

        <div class="flex items-center gap-3 mb-6 px-2">
            <button onclick="window.history.back();"
               class="w-10 h-10 rounded-full bg-white shadow hover:bg-gray-50 flex items-center justify-center transition-colors text-gray-600 hover:text-primary group/back">
                <span class="material-symbols-outlined text-2xl group-hover/back:-translate-x-1 transition-transform">arrow_back</span>
            </button>
            <h1 class="text-xl font-bold text-gray-800">Thông tin vé</h1>
        </div>

        <div class="bg-white rounded-3xl shadow-xl overflow-hidden">

            <div class="bg-gradient-to-br from-primary to-primary-container text-on-primary p-8 text-center relative">
                <span class="material-symbols-outlined text-5xl mb-2 opacity-80">local_movies</span>
                <h2 class="text-2xl font-bold uppercase tracking-wide mb-1 leading-tight">
                    ${ticket_detail.movieName}
                </h2>
            </div>

            <div class="p-8">
                <div class="grid grid-cols-2 gap-y-6 gap-x-4">

                    <div>
                        <p class="text-xs text-gray-500 font-semibold mb-1 uppercase tracking-wider">Ngày chiếu</p>
                        <p class="font-bold text-lg text-on-surface flex items-center gap-1.5">
                            <span class="material-symbols-outlined text-primary text-xl">calendar_month</span>
                            ${ticket_detail.showDate}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs text-gray-500 font-semibold mb-1 uppercase tracking-wider">Giờ chiếu</p>
                        <p class="font-bold text-lg text-on-surface flex items-center gap-1.5">
                            <span class="material-symbols-outlined text-primary text-xl">schedule</span>
                            ${ticket_detail.startTime} - ${ticket_detail.endTime}
                        </p>
                    </div>

                    <div class="col-span-2">
                        <p class="text-xs text-gray-500 font-semibold mb-1 uppercase tracking-wider">Rạp</p>
                        <p class="font-bold text-lg text-on-surface flex items-center gap-1.5">
                            <span class="material-symbols-outlined text-primary text-xl">location_on</span>
                            ${ticket_detail.cinemaName}
                        </p>
                    </div>

                    <div>
                        <p class="text-xs text-gray-500 font-semibold mb-1 uppercase tracking-wider">Phòng chiếu</p>
                        <p class="font-bold text-2xl text-on-surface">
                            ${ticket_detail.roomName}
                        </p>
                    </div>
                    <div>
                        <p class="text-xs text-gray-500 font-semibold mb-1 uppercase tracking-wider">Ghế</p>
                        <p class="font-bold text-2xl text-primary">
                            <c:forEach var="seat" items="${ticket_detail.seatList}" varStatus="status">
                                ${seat}${!status.last ? ', ' : ''}
                            </c:forEach>
                        </p>
                    </div>
                </div>
            </div>

            <div class="ticket-divider relative h-0 border-t-2 border-dashed border-gray-300 mx-4 my-2 z-10"></div>

            <div class="p-8 text-center bg-gray-50">

                <div class="mb-8">
                    <p class="font-barcode text-6xl text-gray-800 tracking-widest opacity-80"></p>
                    <p class="text-xs text-gray-400 mt-1 font-mono tracking-widest">ID: ${booking_id}</p>
                </div>

                <a href="${pageContext.request.contextPath}/payment/${booking_id}/invoice"
                   class="flex-1 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-bold py-3.5 rounded-xl transition-colors flex justify-center items-center gap-2">
                    <span class="material-symbols-outlined text-lg">receipt_long</span>
                    Xem hoá đơn
                </a>

            </div>

        </div>
    </div>

</body>
</html>