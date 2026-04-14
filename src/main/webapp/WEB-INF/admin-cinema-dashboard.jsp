<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Cinema Admin</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f6f6f6;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 1100px;
            margin: 40px auto;
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }
        h1 {
            color: #bb000c;
            margin-bottom: 8px;
        }
        .subtitle {
            color: #555;
            margin-bottom: 24px;
        }
        .cinema-box {
            background: #f0f1f1;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 24px;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .card {
            display: block;
            text-decoration: none;
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 14px;
            padding: 24px;
            color: #222;
            transition: 0.2s;
        }
        .card:hover {
            border-color: #bb000c;
            transform: translateY(-2px);
        }
        .card h3 {
            margin-top: 0;
            color: #bb000c;
        }
        .card p {
            margin-bottom: 0;
            color: #555;
        }
    </style>
</head>
<body>
<div class="container">
    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h1 style="margin:0; color:#bb000c;">Trang quản lý Cinema Admin</h1>

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
    <div class="subtitle">Chọn chức năng bạn muốn quản lý.</div>

    <div class="cinema-box">
        <strong>Tài khoản:</strong> ${currentUser.fullName} <br/>
        <strong>Rạp phụ trách:</strong> ${cinema.cinemaName}
    </div>

    <div class="grid">
        <a class="card" href="${pageContext.request.contextPath}/admin/bookings">
            <h3>Quản lý đơn vé</h3>
            <p>Xem danh sách đơn, xem chi tiết, xác nhận, hủy, gửi mail xác nhận.</p>
        </a>

        <a class="card" href="${pageContext.request.contextPath}/admin/rooms">
            <h3>Quản lý phòng chiếu & ghế</h3>
            <p>Đi tới module quản lý phòng chiếu, ghế ngồi của rạp.</p>
        </a>
    </div>
</div>
</body>
</html>