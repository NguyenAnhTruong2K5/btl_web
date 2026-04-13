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
    private final SeatStatusRepo seatStatusRepo;
    public boolean isRoomFull(Integer roomId) {
        List<Seat> seatList = seatRepo.findByRoom_RoomId(roomId);
        int availableSeat = 0;
        for (Seat seat : seatList) {
            List<SeatStatus> list = seatStatusRepo.findBySeat_SeatId(seat.getSeatId());

            SeatStatus seatStatus = list.isEmpty() ? null : list.get(0);
            if (seatStatus != null && seatStatus.getStatus().equals("available")) {
                availableSeat += 1;
            }
        }

        return availableSeat == 0;
    }
}
