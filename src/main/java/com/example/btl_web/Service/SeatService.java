package com.example.btl_web.Service;

import com.example.btl_web.Model.SeatStatus;
import com.example.btl_web.Repository.SeatStatusRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class SeatService {
    private final SeatStatusRepo seatStatusRepo;
    public boolean isSeatAvailable(Integer seatId) {
        SeatStatus seatStatus = seatStatusRepo.findBySeat_SeatId(seatId).orElse(null);
        if (seatStatus == null) {
            return false;
        }

        return seatStatus.getStatus().equals("available");
    }

    public void setSeatStatus(Integer seatId, String status) {
        SeatStatus seatStatus = seatStatusRepo.findBySeat_SeatId(seatId).orElse(null);
        if (seatStatus != null) {
            seatStatus.setStatus(status);
            seatStatusRepo.save(seatStatus);
        }
    }
}
