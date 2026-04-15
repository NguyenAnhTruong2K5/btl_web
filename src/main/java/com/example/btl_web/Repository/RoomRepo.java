package com.example.btl_web.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.Room;

public interface RoomRepo extends JpaRepository<Room, Integer> {
    List<Room> findByRoomNameContainingIgnoreCase(String keyword);

    // 🔐 CINEMA-BASED FILTERING (cho authorization)
    /**
     * Lấy tất cả phòng của một rạp (cinema)
     * Dùng cho cinema admin để chỉ xem phòng của rạp mình quản lý
     */
    List<Room> findByCinema_CinemaId(Integer cinemaId);
}
