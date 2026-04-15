package com.example.btl_web.Service;

import org.springframework.stereotype.Service;

import com.example.btl_web.Model.SeatStatus;
import com.example.btl_web.Repository.SeatStatusRepo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class SeatService {

    private final SeatStatusRepo seatStatusRepo;

    public boolean isSeatAvailable(Integer seatId, Integer showtimeId) {
        if (showtimeId == null) {
            return false;
        }

        SeatStatus seatStatus = seatStatusRepo.findBySeat_SeatIdAndShowtime_ShowtimeId(seatId, showtimeId).orElse(null);
        if (seatStatus == null) {
            return false;
        }

        return "AVAILABLE".equalsIgnoreCase(seatStatus.getStatus());
    }

    public void setSeatStatus(Integer seatId, Integer showtimeId, String status) {
        if (showtimeId == null) {
            return;
        }

        SeatStatus seatStatus = seatStatusRepo.findBySeat_SeatIdAndShowtime_ShowtimeId(seatId, showtimeId).orElse(null);
        if (seatStatus != null) {
            seatStatus.setStatus(status);
            seatStatusRepo.save(seatStatus);
        }
    }
}
