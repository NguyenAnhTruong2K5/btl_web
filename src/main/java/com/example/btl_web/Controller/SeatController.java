package com.example.btl_web.Controller;

import com.example.btl_web.Repository.SeatRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.btl_web.Model.Seat;

@Controller
@RequestMapping("/admin/seats")
public class SeatController {

    @Autowired
    private SeatRepo seatRepository;

    @GetMapping("/{roomId}")
    public String seatPage(@PathVariable int roomId, Model model) {
        model.addAttribute("seats", seatRepository.findByRoom_RoomId(roomId));
        return "seat_management";
    }

    @PostMapping("/update")
    public String updateSeat(@RequestParam int seatId) {
        Seat seat = seatRepository.findById(seatId).orElse(null);

        if (seat != null) {
            if ("VIP".equals(seat.getSeatType())) {
                seat.setSeatType("NORMAL");
            } else {
                seat.setSeatType("VIP");
            }
            seatRepository.save(seat);
        }

        return "redirect:/admin/seats/" + seat.getRoom().getRoomId();
    }
}