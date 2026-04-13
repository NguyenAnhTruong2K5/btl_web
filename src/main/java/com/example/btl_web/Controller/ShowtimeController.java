package com.example.btl_web.Controller;

import com.example.btl_web.Model.*;
import com.example.btl_web.Repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/showtimes")
@RequiredArgsConstructor
public class ShowtimeController {

    private final ShowtimeRepo showtimeRepo;
    private final MovieRepo movieRepo;
    private final RoomRepo roomRepo;
    private final SeatStatusRepo seatStatusRepo;
    private final SeatRepo seatRepo;

    // HIỂN THỊ DANH SÁCH
    @GetMapping
    public String showtimesPage(Model model) {
        List<Showtime> showtimes = showtimeRepo.findAll();
        model.addAttribute("showtimes", showtimes);
        return "showtimes";
    }

    // FORM THÊM
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("showtime", new Showtime());
        model.addAttribute("movies", movieRepo.findAll());
        model.addAttribute("rooms", roomRepo.findAll());
        return "add_showtime";
    }

    // THÊM SUẤT CHIẾU
    @PostMapping("/create")
    public String createShowtime(@ModelAttribute("showtime") Showtime showtime,
                                 RedirectAttributes redirectAttributes) {

        try {
            if (showtime.getMovie() == null || showtime.getMovie().getMovieId() == null) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng chọn phim!");
                return "redirect:/admin/showtimes/create";
            }

            if (showtime.getRoom() == null || showtime.getRoom().getRoomId() == null) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng chọn phòng!");
                return "redirect:/admin/showtimes/create";
            }

            if (showtime.getShowDate() == null || showtime.getStartTime() == null || showtime.getEndTime() == null) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng nhập đầy đủ ngày và giờ chiếu!");
                return "redirect:/admin/showtimes/create";
            }

            if (!showtime.getEndTime().isAfter(showtime.getStartTime())) {
                redirectAttributes.addFlashAttribute("error", "Giờ kết thúc phải lớn hơn giờ bắt đầu!");
                return "redirect:/admin/showtimes/create";
            }

            if (showtime.getPrice() == null || showtime.getPrice().signum() < 0) {
                redirectAttributes.addFlashAttribute("error", "Giá vé không hợp lệ!");
                return "redirect:/admin/showtimes/create";
            }

            Movie movie = movieRepo.findById(showtime.getMovie().getMovieId()).orElse(null);
            Room room = roomRepo.findById(showtime.getRoom().getRoomId()).orElse(null);

            if (movie == null) {
                redirectAttributes.addFlashAttribute("error", "Phim không tồn tại!");
                return "redirect:/admin/showtimes/create";
            }

            if (room == null) {
                redirectAttributes.addFlashAttribute("error", "Phòng không tồn tại!");
                return "redirect:/admin/showtimes/create";
            }

            List<Showtime> conflicts = showtimeRepo.findConflictingShowtimes(
                    room.getRoomId(),
                    showtime.getShowDate(),
                    showtime.getStartTime(),
                    showtime.getEndTime()
            );

            if (!conflicts.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Suất chiếu bị trùng thời gian trong cùng phòng!");
                return "redirect:/admin/showtimes/create";
            }

            showtime.setMovie(movie);
            showtime.setRoom(room);

            if (showtime.getStatus() == null || showtime.getStatus().trim().isEmpty()) {
                showtime.setStatus("ACTIVE");
            }

            showtimeRepo.save(showtime);

            // TẠO TRẠNG THÁI GHẾ CHO SUẤT CHIẾU
            List<Seat> seats = seatRepo.findByRoom_RoomIdOrderBySeatRowAscSeatNumberAsc(room.getRoomId());

            List<SeatStatus> seatStatuses = new ArrayList<>();
            for (Seat seat : seats) {
                SeatStatus ss = new SeatStatus();
                ss.setShowtime(showtime);
                ss.setSeat(seat);
                ss.setStatus("AVAILABLE");
                seatStatuses.add(ss);
            }
            seatStatusRepo.saveAll(seatStatuses);

            redirectAttributes.addFlashAttribute("message", "Thêm suất chiếu thành công!");
            return "redirect:/admin/showtimes";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi khi lưu suất chiếu: " + e.getMessage());
            return "redirect:/admin/showtimes/create";
        }
    }

    // FORM SỬA
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id,
                           Model model,
                           RedirectAttributes redirectAttributes) {

        Optional<Showtime> optionalShowtime = showtimeRepo.findById(id);

        if (optionalShowtime.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy suất chiếu!");
            return "redirect:/admin/showtimes";
        }

        model.addAttribute("showtime", optionalShowtime.get());
        model.addAttribute("movies", movieRepo.findAll());
        model.addAttribute("rooms", roomRepo.findAll());
        return "edit_showtime";
    }

    // CẬP NHẬT
    @PostMapping("/update")
    public String updateShowtime(Showtime showtime,
                                 RedirectAttributes redirectAttributes) {

        if (showtime.getShowtimeId() == null || !showtimeRepo.existsById(showtime.getShowtimeId())) {
            redirectAttributes.addFlashAttribute("error", "Suất chiếu không tồn tại!");
            return "redirect:/admin/showtimes";
        }

        if (showtime.getMovie() == null || showtime.getMovie().getMovieId() == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng chọn phim!");
            return "redirect:/admin/showtimes/edit/" + showtime.getShowtimeId();
        }

        if (showtime.getRoom() == null || showtime.getRoom().getRoomId() == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng chọn phòng!");
            return "redirect:/admin/showtimes/edit/" + showtime.getShowtimeId();
        }

        if (showtime.getShowDate() == null || showtime.getStartTime() == null || showtime.getEndTime() == null) {
            redirectAttributes.addFlashAttribute("error", "Vui lòng nhập đầy đủ ngày chiếu và giờ chiếu!");
            return "redirect:/admin/showtimes/edit/" + showtime.getShowtimeId();
        }

        if (!showtime.getEndTime().isAfter(showtime.getStartTime())) {
            redirectAttributes.addFlashAttribute("error", "Giờ kết thúc phải lớn hơn giờ bắt đầu!");
            return "redirect:/admin/showtimes/edit/" + showtime.getShowtimeId();
        }

        if (showtime.getPrice() == null || showtime.getPrice().signum() < 0) {
            redirectAttributes.addFlashAttribute("error", "Giá vé không hợp lệ!");
            return "redirect:/admin/showtimes/edit/" + showtime.getShowtimeId();
        }

        List<Showtime> conflicts = showtimeRepo.findConflictingShowtimes(
                showtime.getRoom().getRoomId(),
                showtime.getShowDate(),
                showtime.getStartTime(),
                showtime.getEndTime()
        );

        conflicts.removeIf(s -> s.getShowtimeId().equals(showtime.getShowtimeId()));

        if (!conflicts.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Suất chiếu bị trùng thời gian trong cùng phòng!");
            return "redirect:/admin/showtimes/edit/" + showtime.getShowtimeId();
        }

        showtimeRepo.save(showtime);
        redirectAttributes.addFlashAttribute("message", "Cập nhật suất chiếu thành công!");
        return "redirect:/admin/showtimes";
    }

    // XÓA
    @GetMapping("/delete/{id}")
    public String deleteShowtime(@PathVariable Integer id,
                                 RedirectAttributes redirectAttributes) {

        if (!showtimeRepo.existsById(id)) {
            redirectAttributes.addFlashAttribute("error", "Suất chiếu không tồn tại!");
            return "redirect:/admin/showtimes";
        }

        showtimeRepo.deleteById(id);
        redirectAttributes.addFlashAttribute("message", "Xóa suất chiếu thành công!");
        return "redirect:/admin/showtimes";
    }

    @GetMapping("/{showtimeId}/seats")
    public String showtimeSeatsPage(@PathVariable Integer showtimeId,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {

        Showtime showtime = showtimeRepo.findById(showtimeId).orElse(null);

        if (showtime == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy suất chiếu!");
            return "redirect:/admin/showtimes";
        }

        List<SeatStatus> seatStatuses = seatStatusRepo.findByShowtime_ShowtimeId(showtimeId);

        model.addAttribute("showtime", showtime);
        model.addAttribute("seatStatuses", seatStatuses);

        return "showtime_seats";
    }
}