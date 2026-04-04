package com.example.btl_web.Repository;

import com.example.btl_web.Model.SeatStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface SeatStatusRepo extends JpaRepository<SeatStatus, Integer> {
    Optional<SeatStatus> findBySeat_SeatId(Integer seatId);
}
