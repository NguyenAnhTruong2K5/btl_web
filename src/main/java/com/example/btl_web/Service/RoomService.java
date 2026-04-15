package com.example.btl_web.Service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.btl_web.Model.SeatStatus;
import com.example.btl_web.Repository.SeatStatusRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RoomService {

    private final SeatStatusRepo seatStatusRepo;

    public boolean isRoomFull(Integer showtimeId) {
        List<SeatStatus> seatStatuses = seatStatusRepo.findByShowtime_ShowtimeId(showtimeId);
        if (seatStatuses.isEmpty()) {
            return true;
        }

        for (SeatStatus seatStatus : seatStatuses) {
            if ("AVAILABLE".equalsIgnoreCase(seatStatus.getStatus())) {
                return false;
            }
        }

        return true;
    }
}
