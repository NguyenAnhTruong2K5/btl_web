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

    @GetMapping("/book")
    public String openBookingPage(HttpSession session, @RequestParam("movie_id") Integer movieId) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }

        if (session.getAttribute("current_booking") != null) {
            session.removeAttribute("current_booking");
        }

        if (session.getAttribute("pre_selected_seat") != null) {
            session.removeAttribute("pre_selected_seat");
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

        model.addAttribute("showtime_list", availableRoomList);
        CinemaShowtimeDTO cinemaShowtimeDTO = new CinemaShowtimeDTO();
        model.addAttribute("cinema_showtime", cinemaShowtimeDTO);

        if (availableRoomList.isEmpty()) {
            model.addAttribute("msg", "Không còn phòng trống!");
            return "booking-cinema-showtime-room";
        }

        return "booking-cinema-showtime-room"; // Mở trang chọn rạp và giờ chiếu
    }

    @PostMapping("/cinema_showtime_room")
    public String processSelectingCinemaAndShowtime(HttpSession session, @ModelAttribute("cinema_showtime") CinemaShowtimeDTO request, RedirectAttributes model) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking"); // Lấy lại booking từ session
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        Integer cinemaId = request.getCinemaId();
        Integer showtimeId = request.getShowtimeId();

        Showtime showtime = showtimeRepo.findById(showtimeId).orElse(null);
        Cinema cinema = cinemaRepo.findById(cinemaId).orElse(null);

        if (showtime == null || cinema == null) {
            model.addFlashAttribute("msg", "Vui lòng chọn rạp và lịch chiếu");
            return "redirect:/booking/cinema_showtime_room";
        }

        currBooking.setCinemaId(cinemaId);
        currBooking.setShowTimeId(showtimeId);
        currBooking.setRoomId(showtime.getRoom().getRoomId());
        return "redirect:/booking/seat" ;
    }

    @GetMapping("/seat")
    public String openRoomSeatPage(HttpSession session, Model model) {
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

        if (currBooking.getSeatIdList() != null && !currBooking.getSeatIdList().isEmpty()) {
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
        return "booking-seat"; //Chọn ghế
    }

    @PostMapping("/seat")
    public String processSelectingSeats(HttpSession session, @RequestParam("seat_id_list") List<Integer> currSeatIdList, Model model) {
        // currentSeatIdList: danh sách ghế mình chọn
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking");
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        if (currSeatIdList == null || currSeatIdList.isEmpty()) {
            model.addAttribute("error_msg", "Vui lòng chọn ghế!");
            return "booking-seat";
        }

        for (Integer seatId : currSeatIdList) {
            seatService.setSeatStatus(seatId, "BOOKED");
        }

        @SuppressWarnings("unchecked")
        List<Integer> preSelectedSeatIdList = (List<Integer>) session.getAttribute("pre_selected_seat");

        if (preSelectedSeatIdList != null) {
            for (Integer seatId : preSelectedSeatIdList) {
                if (!currSeatIdList.contains(seatId)) {
                    seatService.setSeatStatus(seatId, "available");
                }
            } // Trả lại trạng thái cho ghế đã chọn trước đó mà giờ không chọn nữa
        }


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

        List<Integer> seatIdList = currBooking.getSeatIdList();
        if (seatIdList != null) {
            for (Integer seatId : seatIdList) {
                seatService.setSeatStatus(seatId, "available");
            }
        }

        booking.setBookingStatus("CANCELED");
        bookingRepo.save(booking);

        session.removeAttribute("current_booking");
        session.removeAttribute("pre_selected_seat");
        return "redirect:/";
    }
}
