<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>

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
                        'surface-container-high': '#e1e3e3',
                        'on-surface': '#2d2f2f',
                        success: '#10b981',
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
        .dashed-border {
            background-image: linear-gradient(to right, #d1d5db 50%, rgba(255,255,255,0) 0%);
            background-position: bottom;
            background-size: 10px 2px;
            background-repeat: repeat-x;
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center p-4 md:p-8 text-on-surface">

    <div class="w-full max-w-lg bg-white rounded-3xl shadow-xl overflow-hidden border border-gray-100">

        <div class="p-6 md:p-8 pt-4">

            <div class="relative flex items-center justify-center mb-8 px-2">
                <h1 class="text-2xl font-extrabold text-gray-800 tracking-tight">Hoá đơn</h1>
            </div>

            <div class="bg-amber-50 border border-amber-200 rounded-2xl p-5 mb-8 flex items-start gap-4 shadow-sm">
                <div class="bg-amber-100 p-2.5 rounded-full flex items-center justify-center shrink-0">
                    <span class="material-symbols-outlined text-amber-600 text-2xl animate-pulse">timer</span>
                </div>
                <div>
                    <h4 class="font-bold text-amber-900 text-base mb-1">Lưu ý thời gian thanh toán</h4>
                    <p class="text-amber-800 text-sm leading-relaxed">
                        Hãy thanh toán vé trong vòng <strong class="text-amber-900 font-extrabold underline decoration-2 underline-offset-2">2h</strong> kể từ bây giờ.
                        Nếu không, hệ thống sẽ tự động hủy vé của bạn!
                    </p>
                </div>
            </div>

            </div>

        <div class="p-6 md:p-8">

            <c:if test="${not empty error_msg}">
                <div class="bg-red-50 border border-error/20 text-error px-4 py-3 rounded-xl mb-6 flex items-start gap-3">
                    <span class="material-symbols-outlined mt-0.5">error</span>
                    <p class="font-medium text-sm leading-relaxed">${error_msg}</p>
                </div>
            </c:if>

            <c:if test="${not empty success_msg}">
                <div class="bg-green-50 border border-success/20 text-success px-4 py-3 rounded-xl mb-6 flex items-start gap-3">
                    <span class="material-symbols-outlined mt-0.5">check_circle</span>
                    <p class="font-medium text-sm leading-relaxed">${success_msg}</p>
                </div>
            </c:if>

            <form:form action="" modelAttribute="invoice_dto" method="POST" class="space-y-6">

                <div class="bg-gray-50 rounded-2xl p-6 text-center border border-gray-100">
                    <p class="text-sm text-gray-500 font-semibold uppercase tracking-wider mb-2">Tổng thanh toán</p>
                    <div class="text-4xl font-extrabold text-primary flex justify-center items-start gap-1">
                        <form:hidden path="amount"/>
                        <fmt:formatNumber value="${invoice_dto.amount}" type="number" maxFractionDigits="0"/>
                        <span class="text-xl mt-1 underline decoration-2 underline-offset-4">đ</span>
                    </div>
                </div>

                <div class="dashed-border h-1 w-full my-6 opacity-50"></div>

                <div>
                    <label class="block text-sm font-semibold text-gray-700 mb-2 flex items-center justify-between" for="discountCode">
                        <span>Mã giảm giá</span>
                        <span class="text-gray-400 font-normal text-xs bg-gray-100 px-2 py-0.5 rounded-md">Không bắt buộc</span>
                    </label>

                    <div class="flex gap-2">
                        <div class="relative flex-grow">
                            <span class="material-symbols-outlined absolute left-4 top-3.5 text-gray-400">loyalty</span>
                            <form:input path="discountCode" id="discountCode"
                                class="w-full bg-white border-2 border-gray-200 rounded-xl py-3.5 pl-12 pr-4 text-gray-800 font-medium placeholder-gray-400 focus:border-primary focus:ring-4 focus:ring-primary/10 outline-none transition-all uppercase"
                                placeholder="Nhập mã giảm giá" />
                        </div>

                        <button type="submit" name="action" value="apply_discount"
                            class="bg-gray-800 hover:bg-gray-900 text-white font-bold px-6 rounded-xl transition-colors shrink-0">
                            Áp dụng
                        </button>
                    </div>

                </div>

                <div class="pt-6 space-y-3">

                    <button type="submit" name="action" value="pay_now"
                        onclick="alert('Thanh toán thành công, vé của bạn đã được xác thực. Thông tin chi tiết sẽ được gửi về email của bạn!');"
                        class="w-full bg-success hover:bg-emerald-600 text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-emerald-500/30 flex justify-center items-center gap-2 text-lg group">
                        <span class="material-symbols-outlined group-hover:scale-110 transition-transform">check_circle</span>
                        Thanh toán ngay
                    </button>

                    <div class="flex items-center gap-3 w-full">
                        <a href="${pageContext.request.contextPath}/ticket"
                           class="flex-1 bg-white border-2 border-gray-200 hover:border-gray-300 hover:bg-gray-50 text-gray-700 font-bold py-3.5 rounded-xl transition-colors flex justify-center items-center gap-2">
                            <span class="material-symbols-outlined text-lg">schedule</span>
                            Thanh toán sau
                        </a>

                        <a href="${pageContext.request.contextPath}/ticket/${booking_id}/cancel"
                           onclick="return confirm('Bạn có chắc chắn muốn hủy giao dịch này? Ghế đã chọn sẽ bị hủy.');"
                           class="flex-1 bg-white border-2 border-error/20 hover:bg-error/10 text-error font-bold py-3.5 rounded-xl transition-colors flex justify-center items-center gap-2 group/cancel">
                            <span class="material-symbols-outlined text-lg group-hover/cancel:rotate-90 transition-transform duration-300">close</span>
                            Hủy vé
                        </a>
                    </div>
                </div>

            </form:form>
        </div>
    </div>

</body>
</html>