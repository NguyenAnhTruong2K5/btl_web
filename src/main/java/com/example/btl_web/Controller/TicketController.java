package com.example.btl_web.Controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.btl_web.DTO.TicketDTO;
import com.example.btl_web.Model.Booking;
import com.example.btl_web.Model.BookingSeat;
import com.example.btl_web.Model.Cinema;
import com.example.btl_web.Model.Movie;
import com.example.btl_web.Model.Room;
import com.example.btl_web.Model.Seat;
import com.example.btl_web.Model.Showtime;
import com.example.btl_web.Model.Ticket;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.BookingRepo;
import com.example.btl_web.Repository.BookingSeatRepo;
import com.example.btl_web.Repository.PaymentRepo;
import com.example.btl_web.Repository.TicketRepo;
import com.example.btl_web.Service.SeatService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/ticket")
public class TicketController {

    private final TicketRepo ticketRepo;
    private final BookingRepo bookingRepo;
    private final BookingSeatRepo bookingSeatRepo;
    private final PaymentRepo paymentRepo;
    private final SeatService seatService;

    @GetMapping("")
    public String viewTicketList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }

        List<Booking> bookingList = bookingRepo.findByUser_UserId(user.getUserId());
        List<Ticket> ticketList = new ArrayList<>();

        for (Booking booking : bookingList) {
            if (booking.getBookingStatus() != null && !booking.getBookingStatus().equals("CANCELED")) {
                ticketRepo.findByBooking_BookingId(booking.getBookingId()).ifPresent(ticketList::add);
            }
        }

        List<TicketDTO> ticketDTOList = new ArrayList<>();
        for (Ticket ticket : ticketList) {
            TicketDTO ticketDTO = new TicketDTO();
            Booking booking = ticket.getBooking();
            String movieTitle = booking.getShowtime().getMovie().getTitle();

            if (paymentRepo.findByBooking_BookingId(booking.getBookingId()).isPresent()) {
                ticketDTO.setPaid(true);
            }

            ticketDTO.setBookingId(ticket.getBooking().getBookingId());
            ticketDTO.setMovieName(movieTitle);
            ticketDTO.setCreateAt(ticket.getCreatedAt());
            ticketDTO.setVerified(ticket.getVerified());
            ticketDTOList.add(ticketDTO);
        }

        model.addAttribute("ticket_list", ticketDTOList);
        return "ticket-list";
    }

    @GetMapping("/{booking_id}/detail")
    public String viewTicket(HttpSession session, @PathVariable("booking_id") Integer bookingId, Model model) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }

        if (bookingId == null) {
            return "redirect:/ticket";
        }

        Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null);
        if (ticket == null) {
            Ticket newTicket = new Ticket();
            newTicket.setBooking(bookingRepo.findById(bookingId).orElse(null));
            ticketRepo.save(newTicket);
        }

        assert ticket != null;

        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        assert booking != null;

        Showtime showtime = booking.getShowtime();
        Movie movie = showtime.getMovie();
        Room room = showtime.getRoom();
        Cinema cinema = room.getCinema();

        List<BookingSeat> bookingSeatList = bookingSeatRepo.findByBooking(booking);
        List<String> seatNameList = new ArrayList<>();

        if (bookingSeatList != null) {
            Integer showtimeId = showtime.getShowtimeId();
            for (BookingSeat bookingSeat : bookingSeatList) {
                Seat seat = bookingSeat.getSeat();
                String seatRow = seat.getSeatRow();
                Integer seatNumber = seat.getSeatNumber();
                String seatName = seatRow + seatNumber;
                seatService.setSeatStatus(bookingSeat.getSeat().getSeatId(), showtimeId, "BOOKED");
                seatNameList.add(seatName);
            }
        }

        TicketDTO ticketDTO = new TicketDTO();
        ticketDTO.setShowDate(showtime.getShowDate());
        ticketDTO.setStartTime(showtime.getStartTime());
        ticketDTO.setEndTime(showtime.getEndTime());
        ticketDTO.setMovieName(movie.getTitle());
        ticketDTO.setRoomName(room.getRoomName());
        ticketDTO.setCinemaName(cinema.getCinemaName());
        ticketDTO.setSeatList(seatNameList);

        model.addAttribute("ticket_detail", ticketDTO);
        model.addAttribute("booking_id", bookingId);

        String bookingStatus = booking.getBookingStatus();

        if (bookingStatus != null && !bookingStatus.equals("CANCELED")) {
            return "ticket"; // Nếu vé đã xác nhận thì sẽ chuyển sang trang ticket để xem thông tin vé (Không có nút huỷ vé ở trang này)
        }

        return "booking-ticket"; // Hiện thị thông tin vé và nút xác nhận đặt vé
    }

    @GetMapping("/{booking_id}/cancel")
    public String cancelTicket(HttpSession session, @PathVariable("booking_id") Integer bookingId) {
        if (bookingId == null) {
            return "redirect:/ticket";
        }

        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        if (booking == null) {
            return "redirect:/";
        }

        List<BookingSeat> bookingSeatList = bookingSeatRepo.findByBooking(booking);
        if (bookingSeatList != null) {
            Integer showtimeId = booking.getShowtime() != null ? booking.getShowtime().getShowtimeId() : null;
            for (BookingSeat bookingSeat : bookingSeatList) {
                seatService.setSeatStatus(bookingSeat.getSeat().getSeatId(), showtimeId, "AVAILABLE");
            }
        }

        booking.setBookingStatus("CANCELED");
        bookingRepo.save(booking);

        session.removeAttribute("current_booking");
        session.removeAttribute("pre_selected_seat");
        return "redirect:/ticket";
    }
}
