<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn vé</title>
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
            max-width: 1280px;
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

        .managed-cinema {
            margin: 0 0 24px 0;
            font-size: 15px;
            font-weight: 600;
            color: var(--color-on-surface);
        }

        .managed-cinema span {
            color: var(--color-primary);
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

        .filter-box {
            background: var(--color-surface-container-low);
            border: 1px solid var(--color-surface-container-high);
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 24px;
        }

        .filter-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 12px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-group label {
            font-size: 13px;
            color: var(--color-on-surface-variant);
            font-weight: 600;
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--color-outline);
            border-radius: 10px;
            background: var(--color-surface-container-lowest);
            color: var(--color-on-surface);
            outline: none;
        }

        .form-control:focus {
            border-color: var(--color-primary);
        }

        .btn {
            display: inline-block;
            padding: 10px 14px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
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

        .btn-view {
            background: var(--color-primary);
            color: var(--color-on-primary);
            padding: 8px 12px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
        }

        .table-wrap {
            overflow-x: auto;
            border: 1px solid var(--color-surface-container-high);
            border-radius: 14px;
            background: var(--color-surface-container-lowest);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 950px;
        }

        thead th {
            background: var(--color-surface-container-low);
            color: var(--color-on-surface);
            font-size: 14px;
            text-align: left;
            padding: 14px 12px;
            border-bottom: 1px solid var(--color-surface-container-high);
        }

        tbody td {
            padding: 14px 12px;
            border-bottom: 1px solid var(--color-surface-container-high);
            font-size: 14px;
            vertical-align: top;
            color: var(--color-on-surface);
        }

        tbody tr:hover {
            background: #fcfcfc;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            border: 1px solid var(--color-surface-container-high);
            background: var(--color-surface-container-low);
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

        .empty-row {
            text-align: center;
            padding: 28px 12px;
            color: var(--color-on-surface-variant);
        }
    </style>
</head>
<body>
<div class="page">
    <div class="card">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
            <h1 style="margin:0; color:#bb000c;">Quản lý đơn vé</h1>

            <a href="${pageContext.request.contextPath}/logout"
               style="
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
            <a href="${pageContext.request.contextPath}/admin/cinema"
               style="
           display:inline-flex;
           align-items:center;
           gap:8px;
           background:#e5e7eb;
           color:#111827;
           text-decoration:none;
           padding:10px 16px;
           border-radius:10px;
           font-weight:500;
           transition:0.2s ease;
       "
               onmouseover="this.style.background='#d1d5db'"
               onmouseout="this.style.background='#e5e7eb'">
                ← Dashboard
            </a>
        </div>
        <c:if test="${not empty cinemas}">
            <p class="managed-cinema">Rạp đang quản lý: <span>${cinemas[0].cinemaName}</span></p>
        </c:if>

        <c:if test="${not empty successMsg}">
            <div class="message message-success">${successMsg}</div>
        </c:if>

        <c:if test="${not empty errorMsg}">
            <div class="message message-error">${errorMsg}</div>
        </c:if>

        <div class="filter-box">
            <form class="filter-form" method="get" action="${pageContext.request.contextPath}/admin/bookings">
                <div class="form-group">
                    <label for="movieId">Phim</label>
                    <select class="form-control" id="movieId" name="movieId">
                        <option value="">-- Chọn phim --</option>
                        <c:forEach var="movie" items="${movies}">
                            <option value="${movie.movieId}" ${filter.movieId == movie.movieId ? 'selected' : ''}>
                                    ${movie.title}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="showDate">Ngày chiếu</label>
                    <input class="form-control" type="date" id="showDate" name="showDate" value="${filter.showDate}" />
                </div>

                <div class="form-group">
                    <label for="bookingStatus">Trạng thái</label>
                    <select class="form-control" id="bookingStatus" name="bookingStatus">
                        <option value="">-- Trạng thái --</option>
                        <option value="PENDING" ${filter.bookingStatus == 'PENDING' ? 'selected' : ''}>PENDING</option>
                        <option value="CONFIRMED" ${filter.bookingStatus == 'CONFIRMED' ? 'selected' : ''}>CONFIRMED</option>
                        <option value="CANCELED" ${filter.bookingStatus == 'CANCELED' ? 'selected' : ''}>CANCELED</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>&nbsp;</label>
                    <button class="btn btn-primary" type="submit">Lọc đơn</button>
                </div>
            </form>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Người đặt</th>
                    <th>Phim</th>
                    <th>Phòng</th>
                    <th>Ngày chiếu</th>
                    <th>Khung giờ</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty bookings}">
                        <tr>
                            <td class="empty-row" colspan="9">Không có đơn vé nào.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>#${booking.bookingId}</td>
                                <td>
                                    <strong>${booking.user.fullName}</strong>
                                </td>
                                <td>${booking.showtime.movie.title}</td>
                                <td>${booking.showtime.room.roomName}</td>
                                <td>
                                    <fmt:parseDate value="${booking.showtime.showDate}" pattern="yyyy-MM-dd" var="parsedShowDate" type="date"/>
                                    <fmt:formatDate value="${parsedShowDate}" pattern="MM/dd/yyyy"/>
                                </td>
                                <td>${booking.showtime.startTime} - ${booking.showtime.endTime}</td>
                                <td>${booking.totalPrice}</td>
                                <td>
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
                                            <span class="status-badge">${booking.bookingStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a class="btn-view" href="${pageContext.request.contextPath}/admin/bookings/${booking.bookingId}">
                                        Xem
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>