<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán Thành Công</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#bb000c',
                        success: '#10b981',
                        'surface-container': '#f6f6f6',
                        'on-surface': '#2d2f2f'
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
        .receipt-edge {
            background-image: radial-gradient(circle at 10px 0, transparent 10px, white 11px);
            background-size: 24px 20px;
            background-repeat: repeat-x;
            height: 20px;
            width: 100%;
        }
        .dashed-border {
            background-image: linear-gradient(to right, #e5e7eb 50%, rgba(255,255,255,0) 0%);
            background-position: bottom;
            background-size: 12px 2px;
            background-repeat: repeat-x;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 md:p-8 text-on-surface">

    <div class="w-full max-w-sm">
        <a href="${pageContext.request.contextPath}/payment/history"
           class="w-full bg-white border border-gray-200 hover:bg-gray-50 text-gray-600 font-bold py-4 rounded-xl transition-all shadow-sm flex justify-center items-center gap-2">
            <span class="material-symbols-outlined">arrow_back</span>
            Trở lại lịch sử thanh toán
        </a>

        <div class="bg-white rounded-t-3xl shadow-xl p-8 pb-4 text-center relative z-10">

            <div class="w-20 h-20 bg-green-50 rounded-full flex items-center justify-center mx-auto mb-4 border-8 border-white shadow-sm">
                <span class="material-symbols-outlined text-5xl text-success">check_circle</span>
            </div>

            <h1 class="text-2xl font-extrabold text-gray-800 tracking-tight mb-1">Thanh toán thành công!</h1>
            <p class="text-sm text-gray-500 mb-8">Cảm ơn bạn đã sử dụng dịch vụ</p>

            <div class="bg-gray-50 rounded-2xl p-6 border border-gray-100">
                <p class="text-xs text-gray-500 font-bold uppercase tracking-wider mb-2">Số tiền đã thanh toán</p>
                <div class="text-4xl font-extrabold text-gray-800 flex justify-center items-start gap-1">
                    <fmt:formatNumber value="${invoice_dto.amount}" type="number" maxFractionDigits="0"/>
                    <span class="text-xl mt-1 underline decoration-2 underline-offset-4 text-gray-400">đ</span>
                </div>
            </div>

            <div class="dashed-border h-1 w-full my-6"></div>

            <c:if test="${not empty invoice_dto.discountCode}">
                <div class="flex items-center justify-between bg-emerald-50 border border-emerald-100 p-4 rounded-xl">
                    <div class="flex items-center gap-2 text-emerald-700">
                        <span class="material-symbols-outlined text-lg">loyalty</span>
                        <span class="text-sm font-semibold">Mã áp dụng</span>
                    </div>
                    <span class="font-mono font-bold text-emerald-800 bg-emerald-200/50 px-2 py-1 rounded">
                        ${invoice_dto.discountCode}
                    </span>
                </div>
                <div class="dashed-border h-1 w-full my-6"></div>
            </c:if>
        </div>

        <div class="receipt-edge rotate-180 drop-shadow-xl relative z-0 -mt-1"></div>

        <div class="mt-8 flex flex-col gap-3 px-2">
            <a href="${pageContext.request.contextPath}/ticket/${invoice_dto.bookingId}/detail"
               class="w-full bg-primary hover:bg-red-800 text-white font-bold py-4 rounded-xl transition-all shadow-md flex justify-center items-center gap-2">
                <span class="material-symbols-outlined">confirmation_number</span>
                Xem vé của tôi
            </a>

        </div>

    </div>

</body>
</html>