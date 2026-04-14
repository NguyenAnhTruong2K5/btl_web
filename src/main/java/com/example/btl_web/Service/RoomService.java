package com.example.btl_web.Service;

import com.example.btl_web.Model.Seat;
import com.example.btl_web.Model.SeatStatus;
import com.example.btl_web.Repository.SeatRepo;
import com.example.btl_web.Repository.SeatStatusRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class RoomService {
    private final SeatRepo seatRepo;
    private final SeatService seatService;

    public boolean isRoomFull(Integer roomId) {
        List<Seat> seatList = seatRepo.findByRoom_RoomId(roomId);
        int availableSeat = 0;
        for (Seat seat : seatList) {
            if (seatService.isSeatAvailable(seat.getSeatId())) {
                availableSeat += 1;
            }
        }

        return availableSeat == 0;
    }
}
