package com.example.btl_web.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.SeatStatus;

public interface SeatStatusRepo extends JpaRepository<SeatStatus, Integer> {

    Optional<SeatStatus> findBySeat_SeatIdAndShowtime_ShowtimeId(Integer seatId, Integer showtimeId);

    List<SeatStatus> findByShowtime_ShowtimeId(Integer showtimeId);
//    List<SeatStatus> findBySeat_SeatId(Integer seatId);
}
