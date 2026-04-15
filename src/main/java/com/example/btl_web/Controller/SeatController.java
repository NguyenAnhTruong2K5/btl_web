package com.example.btl_web.Controller;

import com.example.btl_web.Repository.SeatRepo;
import com.example.btl_web.Repository.RoomRepo;
import com.example.btl_web.Util.AuthorizationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.btl_web.Model.Seat;
import com.example.btl_web.Model.Room;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin/seats")
public class SeatController {

    @Autowired
    private SeatRepo seatRepository;

    @Autowired
    private RoomRepo roomRepository;

    @Autowired
    private AuthorizationUtil authorizationUtil;

    @GetMapping("/{roomId}")
    public String seatPage(@PathVariable int roomId, 
                          Model model,
                          HttpServletRequest request,
                          RedirectAttributes redirectAttributes) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        // Lấy phòng để kiểm tra cinema
        Room room = roomRepository.findById(roomId).orElse(null);
        if (room == null) {
            redirectAttributes.addFlashAttribute("error", "Phòng không tồn tại!");
            return "redirect:/admin/rooms";
        }

        // Kiểm tra xem phòng có thuộc cinema hiện tại không
        if (room.getCinema() == null || !room.getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xem ghế của phòng này!");
            return "redirect:/admin/rooms";
        }

        model.addAttribute("seats", seatRepository.findByRoom_RoomId(roomId));
        return "seat_management";
    }

    @PostMapping("/update")
    public String updateSeat(@RequestParam int seatId,
                            HttpServletRequest request,
                            RedirectAttributes redirectAttributes) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        Seat seat = seatRepository.findById(seatId).orElse(null);

        if (seat == null) {
            redirectAttributes.addFlashAttribute("error", "Ghế không tồn tại!");
            return "redirect:/admin/rooms";
        }

        // Kiểm tra xem ghế có thuộc cinema hiện tại không
        Room room = seat.getRoom();
        if (room == null || room.getCinema() == null || !room.getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền cập nhật ghế này!");
            return "redirect:/admin/rooms";
        }

        if ("VIP".equals(seat.getSeatType())) {
            seat.setSeatType("NORMAL");
        } else {
            seat.setSeatType("VIP");
        }
        seatRepository.save(seat);
        redirectAttributes.addFlashAttribute("message", "Cập nhật loại ghế thành công!");

        return "redirect:/admin/seats/" + seat.getRoom().getRoomId();
    }
}