package com.example.btl_web.Repository;

import com.example.btl_web.Model.Seat;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SeatRepo extends JpaRepository<Seat, Integer> {
    List<Seat> findByRoom_RoomId(Integer roomId);
}
