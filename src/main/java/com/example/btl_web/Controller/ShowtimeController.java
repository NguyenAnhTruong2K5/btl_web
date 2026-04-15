package com.example.btl_web.Controller;

import com.example.btl_web.Model.*;
import com.example.btl_web.Repository.*;
import com.example.btl_web.Util.AuthorizationUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
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
    private final BookingRepo bookingRepo;
    private final AuthorizationUtil authorizationUtil;

    // HIỂN THỊ DANH SÁCH
    @GetMapping
    public String showtimesPage(Model model, HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        // Lấy suất chiếu của cinema này
        List<Showtime> showtimes = showtimeRepo.findByCinema_CinemaId(cinemaId);
        model.addAttribute("showtimes", showtimes);
        return "showtimes";
    }

    // FORM THÊM
    @GetMapping("/create")
    public String createForm(Model model, HttpServletRequest request, RedirectAttributes redirectAttributes) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        model.addAttribute("showtime", new Showtime());
        model.addAttribute("movies", movieRepo.findAll()); // Có thể giới hạn theo cinema nếu cần
        // Chỉ lấy phòng của cinema này
        model.addAttribute("rooms", roomRepo.findByCinema_CinemaId(cinemaId));
        return "add_showtime";
    }

    // THÊM SUẤT CHIẾU
    @PostMapping("/create")
    public String createShowtime(@ModelAttribute("showtime") Showtime showtime,
                                 RedirectAttributes redirectAttributes,
                                 HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

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

            // Kiểm tra xem phòng có thuộc cinema hiện tại không
            if (room.getCinema() == null || !room.getCinema().getCinemaId().equals(cinemaId)) {
                redirectAttributes.addFlashAttribute("error", "Bạn không có quyền tạo suất chiếu cho phòng này!");
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
                           RedirectAttributes redirectAttributes,
                           HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        Optional<Showtime> optionalShowtime = showtimeRepo.findById(id);

        if (optionalShowtime.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy suất chiếu!");
            return "redirect:/admin/showtimes";
        }

        Showtime showtime = optionalShowtime.get();

        // Kiểm tra xem suất chiếu có thuộc cinema hiện tại không
        if (showtime.getRoom() == null || showtime.getRoom().getCinema() == null ||
                !showtime.getRoom().getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền sửa suất chiếu này!");
            return "redirect:/admin/showtimes";
        }

        model.addAttribute("showtime", showtime);
        model.addAttribute("movies", movieRepo.findAll());
        // Chỉ lấy phòng của cinema này
        model.addAttribute("rooms", roomRepo.findByCinema_CinemaId(cinemaId));
        return "edit_showtime";
    }

    // CẬP NHẬT
    @PostMapping("/update")
    public String updateShowtime(Showtime showtime,
                                 RedirectAttributes redirectAttributes,
                                 HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        if (showtime.getShowtimeId() == null || !showtimeRepo.existsById(showtime.getShowtimeId())) {
            redirectAttributes.addFlashAttribute("error", "Suất chiếu không tồn tại!");
            return "redirect:/admin/showtimes";
        }

        // Lấy suất chiếu cũ để kiểm tra cinema
        Showtime existingShowtime = showtimeRepo.findById(showtime.getShowtimeId()).orElse(null);
        if (existingShowtime == null || existingShowtime.getRoom() == null || 
                existingShowtime.getRoom().getCinema() == null ||
                !existingShowtime.getRoom().getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền cập nhật suất chiếu này!");
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

        // Kiểm tra xem phòng mới có thuộc cinema hiện tại không
        Room newRoom = roomRepo.findById(showtime.getRoom().getRoomId()).orElse(null);
        if (newRoom == null || newRoom.getCinema() == null || !newRoom.getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không thể gán suất chiếu cho phòng này!");
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
                                 RedirectAttributes redirectAttributes,
                                 HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        if (!showtimeRepo.existsById(id)) {
            redirectAttributes.addFlashAttribute("error", "Suất chiếu không tồn tại!");
            return "redirect:/admin/showtimes";
        }

        // Kiểm tra xem suất chiếu có thuộc cinema hiện tại không
        Showtime showtime = showtimeRepo.findById(id).orElse(null);
        if (showtime == null || showtime.getRoom() == null || showtime.getRoom().getCinema() == null ||
                !showtime.getRoom().getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xóa suất chiếu này!");
            return "redirect:/admin/showtimes";
        }

        try {
            // Check if there are any bookings for this showtime
            List<Booking> bookings = bookingRepo.findByShowtime_ShowtimeId(id);
            if (!bookings.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Không thể xóa suất chiếu có " + bookings.size() + " vé đã đặt!");
                return "redirect:/admin/showtimes";
            }

            // Delete related seat status records
            List<SeatStatus> seatStatuses = seatStatusRepo.findByShowtime_ShowtimeId(id);
            if (!seatStatuses.isEmpty()) {
                seatStatusRepo.deleteAll(seatStatuses);
            }

            // Delete the showtime
            showtimeRepo.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Xóa suất chiếu thành công!");
            return "redirect:/admin/showtimes";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa suất chiếu: " + e.getMessage());
            return "redirect:/admin/showtimes";
        }
    }

    @GetMapping("/{showtimeId}/seats")
    public String showtimeSeatsPage(@PathVariable Integer showtimeId,
                                    Model model,
                                    RedirectAttributes redirectAttributes,
                                    HttpServletRequest request) {
        // Kiểm tra authorization
        Integer cinemaId = authorizationUtil.getCurrentUserCinemaId(request);
        if (cinemaId == null) {
            return "redirect:/login";
        }

        Showtime showtime = showtimeRepo.findById(showtimeId).orElse(null);

        if (showtime == null) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy suất chiếu!");
            return "redirect:/admin/showtimes";
        }

        // Kiểm tra xem suất chiếu có thuộc cinema hiện tại không
        if (showtime.getRoom() == null || showtime.getRoom().getCinema() == null ||
                !showtime.getRoom().getCinema().getCinemaId().equals(cinemaId)) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền xem ghế của suất chiếu này!");
            return "redirect:/admin/showtimes";
        }

        List<SeatStatus> seatStatuses = seatStatusRepo.findByShowtime_ShowtimeId(showtimeId);

        model.addAttribute("showtime", showtime);
        model.addAttribute("seatStatuses", seatStatuses);

        return "showtime_seats";
    }
}