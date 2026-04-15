<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn vé</title>
        <style>
          :root {
            --color-primary: #bb000c;
            --color-primary-container: #ff7668;
            --color-on-primary: #ffefed;

            --color-on-surface: #2d2f2f;
            --color-on-surface-variant: #5a5c5c;

            --color-surface: #f6f6f6;
            --color-surface-container-low: #f0f1f1;
            --color-surface-container-lowest: #ffffff;
            --color-surface-container-high: #e1e3e3;

            --color-error: #b41340;
            --color-outline: #767777;
          }

          * {
            box-sizing: border-box;
          }

          body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: var(--color-surface);
            color: var(--color-on-surface);
          }

          .page {
            max-width: 980px;
            margin: 32px auto;
            padding: 0 16px;
          }

          .card {
            background: var(--color-surface-container-lowest);
            border: 1px solid var(--color-surface-container-high);
            border-radius: 16px;
            padding: 24px;
          }

          .page-title {
            margin: 0 0 8px 0;
            font-size: 28px;
            color: var(--color-primary);
          }

          .page-subtitle {
            margin: 0 0 24px 0;
            color: var(--color-on-surface-variant);
            font-size: 14px;
          }

          .message {
            padding: 12px 14px;
            border-radius: 10px;
            margin-bottom: 16px;
            font-size: 14px;
          }

          .message-success {
            background: var(--color-primary-container);
            color: var(--color-on-primary);
          }

          .message-error {
            background: #fdecef;
            color: var(--color-error);
            border: 1px solid #f3bcc9;
          }

          .section {
            background: var(--color-surface-container-low);
            border: 1px solid var(--color-surface-container-high);
            border-radius: 14px;
            padding: 18px;
            margin-bottom: 18px;
          }

          .section-title {
            margin: 0 0 14px 0;
            font-size: 18px;
            color: var(--color-primary);
          }

          .info-grid {
            display: grid;
            grid-template-columns: 180px 1fr;
            gap: 10px 16px;
            align-items: start;
          }

          .label {
            font-weight: 700;
            color: var(--color-on-surface);
          }

          .value {
            color: var(--color-on-surface-variant);
            word-break: break-word;
          }

          .status-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            border: 1px solid var(--color-surface-container-high);
            background: var(--color-surface-container-lowest);
            color: var(--color-on-surface);
          }

          .status-confirmed {
            background: #e8f5e9;
            color: #2e7d32;
            border-color: #a5d6a7;
          }

          .status-pending {
            background: #e3f2fd;
            color: #1565c0;
            border-color: #90caf9;
          }

          .status-canceled {
            background: #fdecef;
            color: #b41340;
            border-color: #f3bcc9;
          }

          .status-default {
            background: var(--color-surface-container-lowest);
            color: var(--color-on-surface-variant);
          }

          .actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 8px;
          }

          .actions form,
          .actions a {
            margin: 0;
          }

          .btn {
            display: inline-block;
            padding: 10px 14px;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            cursor: pointer;
            font-weight: 600;
            transition: 0.2s ease;
          }

          .btn-primary {
            background: var(--color-primary);
            color: var(--color-on-primary);
          }

          .btn-primary:hover {
            opacity: 0.92;
          }

          .btn-secondary {
            background: var(--color-surface-container-high);
            color: var(--color-on-surface);
          }

          .btn-danger {
            background: var(--color-error);
            color: #ffffff;
          }

          .btn-soft {
            background: var(--color-primary-container);
            color: var(--color-on-primary);
          }

          hr {
            border: none;
            border-top: 1px solid var(--color-surface-container-high);
            margin: 18px 0;
          }

          @media (max-width: 768px) {
            .info-grid {
              grid-template-columns: 1fr;
            }
          }
        </style>
      </head>

      <body>
        <div class="page">
          <div class="card">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
              <h1 class="page-title" style="margin:0; color:#bb000c;">Chi tiết đơn vé #${booking.bookingId}</h1>

              <a href="${pageContext.request.contextPath}/logout" style="
           display:inline-block;
           background:#bb000c;
           color:white;
           text-decoration:none;
           padding:10px 18px;
           border-radius:10px;
           font-weight:600;
       ">
                Đăng xuất
              </a>
            </div>
            <div style="margin-bottom:24px;">
              <a href="${pageContext.request.contextPath}/admin/bookings" style="
           display:inline-flex;
           align-items:center;
           background:#e5e7eb;
           color:#111827;
           text-decoration:none;
           padding:12px 18px;
           border-radius:14px;
           font-weight:500;
           font-size:16px;
           transition:0.2s ease;
       " onmouseover="this.style.background='#d1d5db'" onmouseout="this.style.background='#e5e7eb'">
                ← Quản lý đơn vé
              </a>
            </div>
            <p class="page-subtitle">Theo dõi thông tin booking, thanh toán và thao tác xử lý đơn.</p>

            <c:if test="${not empty successMsg}">
              <div class="message message-success">${successMsg}</div>
            </c:if>

            <c:if test="${not empty errorMsg}">
              <div class="message message-error">${errorMsg}</div>
            </c:if>

            <div class="section">
              <h2 class="section-title">Thông tin người đặt</h2>
              <div class="info-grid">
                <div class="label">Họ tên</div>
                <div class="value">${booking.user.fullName}</div>

                <div class="label">Email</div>
                <div class="value">${booking.user.email}</div>

                <div class="label">Số điện thoại</div>
                <div class="value">${booking.user.phone}</div>
              </div>
            </div>

            <div class="section">
              <h2 class="section-title">Thông tin vé</h2>
              <div class="info-grid">
                <div class="label">Phim</div>
                <div class="value">${booking.showtime.movie.title}</div>

                <div class="label">Rạp</div>
                <div class="value">${booking.showtime.room.cinema.cinemaName}</div>

                <div class="label">Phòng</div>
                <div class="value">${booking.showtime.room.roomName}</div>

                <div class="label">Ngày chiếu</div>
                <div class="value">${booking.showtime.showDate}</div>

                <div class="label">Khung giờ</div>
                <div class="value">${booking.showtime.startTime} - ${booking.showtime.endTime}</div>

                <div class="label">Tổng tiền</div>
                <div class="value">${booking.totalPrice}</div>

                <div class="label">Trạng thái booking</div>
                <div class="value">
                  <c:choose>
                    <c:when test="${booking.bookingStatus == 'PENDING'}">
                      <span class="status-badge status-pending">PENDING</span>
                    </c:when>
                    <c:when test="${booking.bookingStatus == 'CONFIRMED'}">
                      <span class="status-badge status-confirmed">CONFIRMED</span>
                    </c:when>
                    <c:when test="${booking.bookingStatus == 'CANCELED'}">
                      <span class="status-badge status-canceled">CANCELED</span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-badge status-default">${booking.bookingStatus}</span>
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="label">Thời gian đặt</div>
                <div class="value">
                  <c:set var="bookingTimeStr" value="${booking.bookingTime}" />
                  <c:set var="datePart" value="${fn:substring(bookingTimeStr, 0, 10)}" />
                  <c:set var="timePart" value="${fn:substringAfter(bookingTimeStr, 'T')}" />
                  <c:set var="yyyy" value="${fn:substring(datePart, 0, 4)}" />
                  <c:set var="MM" value="${fn:substring(datePart, 5, 7)}" />
                  <c:set var="dd" value="${fn:substring(datePart, 8, 10)}" />
                  ${timePart} ${dd}/${MM}/${yyyy}
                </div>
              </div>
            </div>

            <div class="section">
              <h2 class="section-title">Thanh toán</h2>
              <div class="info-grid">
                <div class="label">Trạng thái thanh toán</div>
                <div class="value">
                  <c:choose>
                    <c:when test="${payment != null}">
                      Đã thanh toán
                    </c:when>
                    <c:otherwise>
                      Chưa thanh toán
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="label">Phương thức</div>
                <div class="value">
                  <c:choose>
                    <c:when test="${payment != null}">
                      ${payment.paymentMethod}
                    </c:when>
                    <c:otherwise>
                      -
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="label">Thời gian thanh toán</div>
                <div class="value">
                  <c:choose>
                    <c:when test="${payment != null}">
                      <c:set var="paymentTimeStr" value="${payment.paymentTime}" />
                      <c:set var="paymentDatePart" value="${fn:substring(paymentTimeStr, 0, 10)}" />
                      <c:set var="paymentTimePart" value="${fn:substringAfter(paymentTimeStr, 'T')}" />
                      <c:set var="paymentYyyy" value="${fn:substring(paymentDatePart, 0, 4)}" />
                      <c:set var="paymentMM" value="${fn:substring(paymentDatePart, 5, 7)}" />
                      <c:set var="paymentDd" value="${fn:substring(paymentDatePart, 8, 10)}" />
                      ${paymentTimePart} ${paymentDd}/${paymentMM}/${paymentYyyy}
                    </c:when>
                    <c:otherwise>
                      -
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>

              <div class="actions">
                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/admin/bookings">Quay lại</a>

                <c:choose>
                  <c:when test="${booking.bookingStatus == 'CANCELED'}">
                    <form method="post"
                      action="${pageContext.request.contextPath}/admin/bookings/${booking.bookingId}/delete"
                      onsubmit="return confirm('Bạn có chắc muốn xóa vĩnh viễn đơn đã hủy này?');">
                      <button class="btn btn-danger" type="submit">Xóa đơn đã hủy</button>
                    </form>
                  </c:when>
                  <c:otherwise>
                    <form method="post"
                      action="${pageContext.request.contextPath}/admin/bookings/${booking.bookingId}/confirm">
                      <button class="btn btn-primary" type="submit">Xác nhận đơn</button>
                    </form>

                    <form method="post"
                      action="${pageContext.request.contextPath}/admin/bookings/${booking.bookingId}/cancel">
                      <button class="btn btn-danger" type="submit">Hủy đơn</button>
                    </form>

                    <form method="post"
                      action="${pageContext.request.contextPath}/admin/bookings/${booking.bookingId}/send-mail">
                      <button class="btn btn-soft" type="submit">Gửi mail</button>
                    </form>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
      </body>

      </html>