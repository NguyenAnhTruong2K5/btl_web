package com.example.btl_web.Repository;

import com.example.btl_web.Model.Seat;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SeatRepo extends JpaRepository<Seat, Integer> {
    List<Seat> findByRoom_RoomId(Integer roomId);
    long countByRoom_RoomId(int roomId);

    List<Seat> findByRoom_RoomIdOrderBySeatRowAscSeatNumberAsc(Integer roomId);
    void deleteByRoom_RoomIdAndSeatRowAndSeatNumber(Integer roomId, String seatRow, Integer seatNumber);
}
