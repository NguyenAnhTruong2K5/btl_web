package com.example.btl_web.Controller;

import com.example.btl_web.Model.Admin;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.AdminRepo;
import com.example.btl_web.Repository.RoomRepo;
import com.example.btl_web.Repository.SeatRepo;
import com.example.btl_web.Repository.ShowtimeRepo;
import com.example.btl_web.Util.AuthorizationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.btl_web.Model.Room;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.example.btl_web.Model.Seat;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/admin/rooms")
@RequiredArgsConstructor
public class RoomController {

    private final RoomRepo roomRepo;
    private final SeatRepo seatRepo;
    private final ShowtimeRepo showtimeRepo;
    private final AdminRepo adminRepo;
    private final AuthorizationUtil authorizationUtil;
    // HIỂN THỊ + SEARCH
    @GetMapping
    public String roomsPage(@RequestParam(required = false) String keyword, 
                           Model model, 
                           HttpServletRequest request) {
        // Lấy cinema_id của admin hiện tại
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        
        // Nếu không phải cinema admin, redirect về login
        if (cinemaId == null) {
            return "redirect:/login";
        }

        List<Room> rooms;

        if (keyword != null && !keyword.isEmpty()) {
            // Tìm kiếm theo tên phòng và cinema
            rooms = roomRepo.findByRoomNameContainingIgnoreCase(keyword)
                    .stream()
                    .filter(r -> r.getCinema() != null && r.getCinema().getCinemaId().equals(cinemaId))
                    .toList();
        } else {
            // Lấy tất cả phòng của cinema này
            rooms = roomRepo.findByCinema_CinemaId(cinemaId);
        }

        model.addAttribute("rooms", rooms);
        model.addAttribute("keyword", keyword);

        return "rooms_management";
    }

    // FORM ADD
    @GetMapping("/create")
    public String createForm(Model model, HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        model.addAttribute("room", new Room());
        return "room_form";
    }

    // SAVE (ADD + EDIT)
    @PostMapping("/create")
    public String createRoom(Room room, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        if (room.getRoomId() == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng nhập ID phòng!");
            return "redirect:/admin/rooms";
        }

        if (roomRepo.existsById(room.getRoomId())) {
            redirectAttributes.addFlashAttribute("error", "ID phòng đã tồn tại, vui lòng nhập ID khác!");
            return "redirect:/admin/rooms";
        }

        if (room.getTotalSeats() == null || room.getTotalSeats() <= 0) {
            redirectAttributes.addFlashAttribute("error", "Số ghế phải lớn hơn 0!");
            return "redirect:/admin/rooms";
        }

        Admin admin = adminRepo.findByUser((User) request.getSession(false).getAttribute("currentUser")).orElse(null);
        if (admin == null) {
            return "redirect:/login";
        }

        room.setCinema(admin.getCinema());
        Room savedRoom = roomRepo.save(room);

        List<Seat> seats = generateSeats(savedRoom, savedRoom.getTotalSeats());
        seatRepo.saveAll(seats);

        redirectAttributes.addFlashAttribute("message",
                "Thêm phòng thành công và đã tạo " + savedRoom.getTotalSeats() + " ghế!");
        return "redirect:/admin/rooms";
    }

    @PostMapping("/update")
    public String updateRoom(Room room, RedirectAttributes redirectAttributes, HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        if (room.getRoomId() == null || !roomRepo.existsById(room.getRoomId())) {
            redirectAttributes.addFlashAttribute("error", "Phòng không tồn tại để cập nhật!");
            return "redirect:/admin/rooms";
        }

        Room existingRoom = roomRepo.findById(room.getRoomId()).orElse(null);
        if (existingRoom == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy phòng để cập nhật!");
            return "redirect:/admin/rooms";
        }

        // Kiểm tra xem phòng có thuộc cinema hiện tại không
        if (existingRoom.getCinema() == null || !existingRoom.getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền cập nhật phòng này!");
            return "redirect:/admin/rooms";
        }

        if (room.getTotalSeats() == null || room.getTotalSeats() < 0) {
            redirectAttributes.addFlashAttribute("error", "Số ghế không được nhỏ hơn 0!");
            return "redirect:/admin/rooms";
        }

        int oldTotalSeats = existingRoom.getTotalSeats();
        int newTotalSeats = room.getTotalSeats();

        // Cập nhật thông tin phòng trước
        existingRoom.setRoomName(room.getRoomName());
        existingRoom.setTotalSeats(newTotalSeats);

        roomRepo.save(existingRoom);

        // Nếu tăng ghế -> tạo thêm
        if (newTotalSeats > oldTotalSeats) {
            List<Seat> newSeats = generateAdditionalSeats(existingRoom, oldTotalSeats, newTotalSeats);
            seatRepo.saveAll(newSeats);

            redirectAttributes.addFlashAttribute(
                    "message",
                    "Cập nhật phòng thành công! Đã thêm " + (newTotalSeats - oldTotalSeats) + " ghế."
            );
        }
        // Nếu giảm ghế -> xóa bớt
        else if (newTotalSeats < oldTotalSeats) {
            List<Seat> allSeats = seatRepo.findByRoom_RoomIdOrderBySeatRowAscSeatNumberAsc(existingRoom.getRoomId());

            int seatsToDelete = oldTotalSeats - newTotalSeats;

            // Xóa từ cuối danh sách để giữ A1 -> ... liên tục
            for (int i = allSeats.size() - 1; i >= allSeats.size() - seatsToDelete; i--) {
                seatRepo.deleteById(allSeats.get(i).getSeatId());
            }

            redirectAttributes.addFlashAttribute(
                    "message",
                    "Cập nhật phòng thành công! Đã xóa " + seatsToDelete + " ghế."
            );
        } else {
            redirectAttributes.addFlashAttribute("message", "Cập nhật phòng thành công!");
        }

        return "redirect:/admin/rooms";
    }

    // DELETE
    @GetMapping("/delete/{id}")
    public String deleteRoom(@PathVariable int id,
                             RedirectAttributes redirectAttributes,
                             HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        // Lấy phòng để kiểm tra xem nó có thuộc cinema của admin này không
        Room room = roomRepo.findById(id).orElse(null);
        if (room == null) {
            redirectAttributes.addFlashAttribute("error", "Phòng không tồn tại!");
            return "redirect:/admin/rooms";
        }

        // Kiểm tra xem phòng có thuộc cinema hiện tại không
        if (room.getCinema() == null || !room.getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xóa phòng này!");
            return "redirect:/admin/rooms";
        }

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

    private List<Seat> generateSeats(Room room, int totalSeats) {
        List<Seat> seats = new ArrayList<>();

        int seatsPerRow = 10; // mỗi hàng 10 ghế
        for (int i = 0; i < totalSeats; i++) {
            Seat seat = new Seat();

            int rowIndex = i / seatsPerRow;           // 0,1,2...
            int seatNumber = (i % seatsPerRow) + 1;   // 1 -> 10
            char rowChar = (char) ('A' + rowIndex);   // A, B, C...

            seat.setRoom(room);
            seat.setSeatRow(String.valueOf(rowChar));
            seat.setSeatNumber(seatNumber);
            seat.setSeatType("NORMAL"); // hoặc "VIP" nếu muốn

            seats.add(seat);
        }

        return seats;
    }

    private List<Seat> generateAdditionalSeats(Room room, int oldTotalSeats, int newTotalSeats) {
        List<Seat> seats = new java.util.ArrayList<>();

        int seatsPerRow = 10;

        for (int i = oldTotalSeats; i < newTotalSeats; i++) {
            Seat seat = new Seat();

            int rowIndex = i / seatsPerRow;
            int seatNumber = (i % seatsPerRow) + 1;
            char rowChar = (char) ('A' + rowIndex);

            seat.setRoom(room);
            seat.setSeatRow(String.valueOf(rowChar));
            seat.setSeatNumber(seatNumber);
            seat.setSeatType("NORMAL");

            seats.add(seat);
        }

        return seats;
    }
}