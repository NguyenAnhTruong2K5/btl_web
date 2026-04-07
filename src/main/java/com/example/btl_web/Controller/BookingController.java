package com.example.btl_web.Controller;

import com.example.btl_web.DTO.BookingDTO;
import com.example.btl_web.DTO.CinemaShowtimeDTO;
import com.example.btl_web.Model.*;
import com.example.btl_web.Repository.*;
import com.example.btl_web.Service.RoomService;
import com.example.btl_web.Service.SeatService;
import javax.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/booking")
public class BookingController {
    private final CinemaRepo cinemaRepo;
    private final ShowtimeRepo showtimeRepo;
    private final SeatRepo seatRepo;
    private final UserRepo userRepo;
    private final BookingRepo bookingRepo;
    private final BookingSeatRepo bookingSeatRepo;
    private final BookingHistoryRepo bookingHistoryRepo;

    private final SeatService seatService;
    private final RoomService roomService;

    @GetMapping("/")
    public String openBookingPage(HttpSession session, @RequestParam("movie_id") Integer movieId) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }

        BookingDTO bookingDTO = new BookingDTO();
        bookingDTO.setUserId(user.getUserId());
        bookingDTO.setMovieId(movieId);

        session.setAttribute("current_booking", bookingDTO); // Lưu booking vào session
        return "redirect:/booking/cinema_showtime_room";
    }

    @GetMapping("/cinema_showtime_room")
    public String openCinemaShowtimePage(HttpSession session, Model model) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking"); // Lấy lại booking từ session
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        List<Cinema> cinemaList = cinemaRepo.findAll();
        model.addAttribute("cinema_list", cinemaList);

        List<Showtime> showtimeList = showtimeRepo.findByMovie_MovieId(currBooking.getMovieId()); //Danh sách các giờ chiếu kèm phòng
        List<Showtime> availableRoomList = new ArrayList<>();

        for (Showtime showtime : showtimeList) {
            Room room = showtime.getRoom();
            if (!roomService.isRoomFull(room.getRoomId())) {
                availableRoomList.add(showtime);
            }
        }


        if (availableRoomList.isEmpty()) {
            model.addAttribute("msg", "Không còn phòng trống!");
            return "booking-cinema-showtime-room"; // Mở trang chọn rạp và giờ chiếu
        }

        model.addAttribute("showtime_list", availableRoomList);
        CinemaShowtimeDTO cinemaShowtimeDTO = new CinemaShowtimeDTO();
        model.addAttribute("cinema_showtime", cinemaShowtimeDTO);

        return "booking-cinema-showtime-room"; // Mở trang chọn rạp và giờ chiếu
    }

    @PostMapping("/cinema_showtime_room")
    public String processSelectingCinemaAndShowtime(HttpSession session, @ModelAttribute("cinema_showtime") CinemaShowtimeDTO request, RedirectAttributes redirectAttributes) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking"); // Lấy lại booking từ session
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        Integer cinemaId = request.getCinemaId();
        Integer showtimeId = request.getShowtimeId();

        Showtime showtime = showtimeRepo.findById(showtimeId).orElse(null);
        if (showtime == null) {
            redirectAttributes.addFlashAttribute("error_msg", "Vui lòng chọn giờ chiếu khác!");
            return "redirect:/booking/cinema_showtime_room";
        }

        currBooking.setCinemaId(cinemaId);
        currBooking.setShowTimeId(showtimeId);
        currBooking.setRoomId(showtime.getRoom().getRoomId());
        return "redirect:/booking/seat/?seat_selected=false" ;
    }

    @GetMapping("/seat")
    public String openRoomSeatPage(HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking");
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }


        List<Seat> seatList = seatRepo.findByRoom_RoomId(currBooking.getRoomId());
        List<Seat> availableSeats = new ArrayList<>();

        for (Seat seat : seatList) {
            if (seatService.isSeatAvailable(seat.getSeatId())) {
                availableSeats.add(seat);
            }
        }

        if (!currBooking.getSeatIdList().isEmpty()) {
            List<Integer> selectedSeatIdList = currBooking.getSeatIdList();
            List<Seat> selectedSeatList = new ArrayList<>();
            for (Integer seatId : selectedSeatIdList) {
                selectedSeatList.add(seatRepo.findById(seatId).orElse(null));
            }

            model.addAttribute("seat_list", seatList);
            model.addAttribute("available_seat_list", availableSeats);
            model.addAttribute("selected_seat_list", selectedSeatList);
            return "booking-seat";
        }

        model.addAttribute("seat_list", seatList);
        model.addAttribute("available_seat_list", availableSeats);
        return "booking-seat";
    }

    @PostMapping("/seat")
    public String processSelectingSeats(HttpSession session, @RequestParam("seat_id_list") List<Integer> currSeatIdList, Model model) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking");
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        if (currSeatIdList.isEmpty()) {
            model.addAttribute("error_msg", "Vui lòng chọn ghế!");
            return "booking-seat";
        }

        for (Integer seatId : currSeatIdList) {
            seatService.setSeatStatus(seatId, "booked");
        }

        @SuppressWarnings("unchecked")
        List<Integer> preSelectedSeatId = (List<Integer>) session.getAttribute("pre_selected_seat");

        for (Integer seatId : preSelectedSeatId) {
            if (!currSeatIdList.contains(seatId)) {
                seatService.setSeatStatus(seatId, "available");
            }
        } // Trả lại trạng thái cho ghế đã chọn trước đó mà giờ không chọn nữa

        session.setAttribute("pre_selected_seat", currSeatIdList);
        currBooking.setSeatIdList(currSeatIdList);

        Integer userId = currBooking.getUserId();
        User user = userRepo.findById(userId).orElse(null); assert user != null;

        Integer movieId = currBooking.getMovieId();
        Integer roomId = currBooking.getRoomId();

        Integer showtimeId = currBooking.getShowTimeId();
        Showtime showtime = showtimeRepo.findById(showtimeId).orElse(null); assert showtime != null;

        Integer cinemaId = currBooking.getCinemaId();
        List<Integer> seatIdList = currBooking.getSeatIdList();

        Booking booking = new Booking();
        booking.setUser(user);
        booking.setShowtime(showtime);
        booking.setTotalPrice(showtime.getPrice());
        bookingRepo.save(booking);

        for (Integer seatId : seatIdList) {
            BookingSeat bookingSeat = new BookingSeat();
            bookingSeat.setBooking(booking);
            bookingSeat.setSeat(seatRepo.findById(seatId).orElse(null));
            bookingSeatRepo.save(bookingSeat);
        }

        BookingHistory bookingHistory = new BookingHistory();
        bookingHistory.setBooking(booking);
        bookingHistoryRepo.save(bookingHistory);
        currBooking.setBookingId(booking.getBookingId());

        return "redirect:/ticket/" + currBooking.getBookingId() + "/detail";
    }

    @GetMapping("/cancel")
    public String cancelTheBooking(HttpSession session, RedirectAttributes redirectAttributes) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking");
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        Booking booking = bookingRepo.findById(currBooking.getBookingId()).orElse(null);
        if (booking == null) {
            return "redirect:/";
        }

        bookingRepo.delete(booking);
        return "redirect:/";
    }
}
