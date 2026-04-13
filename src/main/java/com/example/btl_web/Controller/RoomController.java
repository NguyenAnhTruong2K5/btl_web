package com.example.btl_web.Controller;

import com.example.btl_web.Repository.RoomRepo;
import com.example.btl_web.Repository.SeatRepo;
import com.example.btl_web.Repository.ShowtimeRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.btl_web.Model.Room;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/rooms")
@RequiredArgsConstructor
public class RoomController {

    private final RoomRepo roomRepo;

    private final SeatRepo seatRepo;
    private final ShowtimeRepo showtimeRepo;
    // HIỂN THỊ + SEARCH
    @GetMapping
    public String roomsPage(@RequestParam(required = false) String keyword, Model model) {

        List<Room> rooms;

        if (keyword != null && !keyword.isEmpty()) {
            rooms = roomRepo.findByRoomNameContainingIgnoreCase(keyword);
        } else {
            rooms = roomRepo.findAll();
        }

        model.addAttribute("rooms", rooms);
        model.addAttribute("keyword", keyword);

        return "rooms_management";
    }

    // FORM ADD
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("room", new Room());
        return "room_form";
    }

    // SAVE (ADD + EDIT)
    @PostMapping("/save")
    public String saveRoom(Room room) {
        roomRepo.save(room);
        return "redirect:/admin/rooms";
    }

    // EDIT
    @GetMapping("/edit/{id}")
    public String editRoom(@PathVariable int id, Model model) {
        Room room = roomRepo.findById(id).orElse(null);
        model.addAttribute("room", room);
        return "room_form";
    }

    // DELETE
    @GetMapping("/delete/{id}")
    public String deleteRoom(@PathVariable int id,
                             RedirectAttributes redirectAttributes) {

        // TODO: check ghế hoặc suất chiếu
        long seatCount = seatRepo.countByRoom_RoomId(id);
        long showtimeCount = showtimeRepo.countByRoom_RoomId(id);

        if (seatCount > 0 || showtimeCount > 0) {
            redirectAttributes.addFlashAttribute("error",
                    "Phòng này đang có ghế hoặc suất chiếu, không thể xóa!");
            return "redirect:/admin/rooms";
        }

        roomRepo.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa phòng thành công!");

        return "redirect:/admin/rooms";
    }
}