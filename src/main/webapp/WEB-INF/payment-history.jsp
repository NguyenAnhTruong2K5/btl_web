<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Giao Dịch</title>

    <script src="https://cdn.tailwindcss.com"></script>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#bb000c',
                        'primary-container': '#ff7668',
                        'on-primary': '#ffefed',
                        success: '#10b981',
                        'surface-container-high': '#e1e3e3',
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
    </style>
</head>
<body class="min-h-screen text-on-surface p-4 md:p-8">

    <div class="max-w-4xl mx-auto">
        <div class="flex items-center justify-between mb-8 border-b border-gray-200 pb-4">
            <div class="flex items-center gap-3">
                <a href="${pageContext.request.contextPath}/"
                   class="w-10 h-10 rounded-full bg-white shadow-sm hover:bg-gray-50 flex items-center justify-center transition-colors text-gray-500 hover:text-primary group/back">
                    <span class="material-symbols-outlined text-2xl group-hover/back:-translate-x-1 transition-transform">arrow_back</span>
                </a>
                <h1 class="text-2xl md:text-3xl font-bold flex items-center gap-2 text-gray-800">
                    <span class="material-symbols-outlined text-primary text-3xl">history</span>
                    Lịch Sử Giao Dịch
                </h1>
            </div>
        </div>

        <c:if test="${empty payment_list}">
            <div class="bg-white rounded-3xl shadow-sm border border-gray-100 p-12 text-center flex flex-col items-center">
                <div class="w-24 h-24 bg-gray-50 rounded-full flex items-center justify-center mb-4 border border-gray-100">
                    <span class="material-symbols-outlined text-5xl text-gray-300">account_balance_wallet</span>
                </div>
                <h2 class="text-xl font-bold text-gray-800 mb-2">Chưa có giao dịch nào</h2>
                <p class="text-gray-500 mb-6 max-w-md mx-auto">Lịch sử thanh toán của bạn hiện đang trống. Các giao dịch mua vé thành công sẽ xuất hiện tại đây.</p>

                <a href="${pageContext.request.contextPath}/profile"
                   class="bg-gray-800 hover:bg-gray-900 text-white font-bold py-3 px-8 rounded-xl transition-colors shadow-md">
                    Trở về trang chủ
                </a>
            </div>
        </c:if>

        <c:if test="${not empty payment_list}">
            <div class="space-y-4">

                <c:forEach var="payment" items="${payment_list}">

                    <div class="bg-white rounded-2xl shadow-sm hover:shadow-md border border-gray-100 p-5 flex flex-col md:flex-row md:items-center justify-between gap-6 transition-all duration-300 group">

                        <div class="flex items-center gap-4">
                            <div class="w-14 h-14 rounded-full bg-green-50 flex items-center justify-center shrink-0 border border-green-100">
                                <span class="material-symbols-outlined text-3xl text-success">check_circle</span>
                            </div>
                            <div>
                                <p class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-0.5">Mã Giao Dịch</p>
                                <span class="text-xl font-bold text-gray-800 font-mono tracking-tight">
                                    #PAY-${payment.paymentId}
                                </span>
                            </div>

                        </div>

                        <div class="flex-grow grid grid-cols-2 gap-4 border-t md:border-t-0 md:border-l border-gray-100 pt-4 md:pt-0 md:pl-8">

                            <div class="flex flex-col">
                                <span class="text-xs text-gray-500 flex items-center gap-1 mb-1">
                                    <span class="material-symbols-outlined text-[14px]">receipt_long</span>
                                    Hóa Đơn
                                </span>
                                <span class="font-semibold text-gray-700 bg-gray-50 px-2.5 py-1 rounded-md w-fit border border-gray-200 text-sm font-mono">
                                    INV-${payment.invoiceId}
                                </span>
                            </div>

                            <div class="flex flex-col">
                                <span class="text-xs text-gray-500 flex items-center gap-1 mb-1">
                                    <span class="material-symbols-outlined text-[14px]">confirmation_number</span>
                                    Mã Vé
                                </span>
                                <span class="font-semibold text-gray-700 bg-gray-50 px-2.5 py-1 rounded-md w-fit border border-gray-200 text-sm font-mono">
                                    TKT-${payment.ticketId}
                                </span>
                            </div>

                        </div>

                        <div class="shrink-0 flex flex-row md:flex-col items-center justify-between md:items-end w-full md:w-auto border-t md:border-t-0 pt-4 md:pt-0 gap-3">

                            <span class="px-4 py-1.5 bg-green-50 text-success text-sm font-bold rounded-full border border-green-200 flex items-center gap-1.5 shadow-sm">
                                <span class="w-2 h-2 rounded-full bg-success animate-pulse"></span>
                                Thành công
                            </span>

                            <a href="${pageContext.request.contextPath}/payment/${payment.bookingId}/invoice"
                               class="px-4 py-1.5 text-sm font-bold text-gray-700 bg-gray-100 hover:bg-gray-200 hover:text-gray-900 border border-gray-200 rounded-full transition-colors flex items-center gap-1.5 group/btn">
                                <span class="material-symbols-outlined text-[18px] group-hover/btn:scale-110 transition-transform">receipt_long</span>
                                Xem hoá đơn
                            </a>

                        </div>

                    </div>

                </c:forEach>
            </div>
        </c:if>

    </div>

</body>
</html>