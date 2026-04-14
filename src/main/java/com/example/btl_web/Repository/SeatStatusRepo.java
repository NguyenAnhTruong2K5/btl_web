package com.example.btl_web.Repository;

import com.example.btl_web.Model.SeatStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface SeatStatusRepo extends JpaRepository<SeatStatus, Integer> {
    List<SeatStatus> findByShowtime_ShowtimeId(Integer showtimeId);
    List<SeatStatus> findBySeat_SeatId(Integer seatId);
    Optional<SeatStatus> findBySeat_SeatIdAndShowtime_ShowtimeId(Integer seatId, Integer showtimeId);
}