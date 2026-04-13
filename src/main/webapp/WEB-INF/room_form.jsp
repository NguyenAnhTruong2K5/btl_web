<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 4/12/2026
  Time: 7:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<h2>Thêm / Sửa phòng</h2>

<form action="/admin/rooms/save" method="post">

    <input type="hidden" name="roomId" value="${room.roomId}"/>

    <div>
        Tên phòng:
        <input type="text" name="roomName" value="${room.roomName}"/>
    </div>

    <div>
        Số ghế:
        <input type="number" name="totalSeats" value="${room.totalSeats}"/>
    </div>

    <div>
        Cinema ID:
        <input type="number" name="cinema.cinemaId"
               value="${room.cinema.cinemaId}"/>
    </div>

    <button type="submit">Lưu</button>

</form>
