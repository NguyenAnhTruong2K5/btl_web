package com.example.btl_web.Controller;

import com.example.btl_web.DTO.TicketDTO;
import com.example.btl_web.Model.*;
import com.example.btl_web.Repository.BookingRepo;
import com.example.btl_web.Repository.BookingSeatRepo;
import com.example.btl_web.Repository.MovieRepo;
import com.example.btl_web.Repository.TicketRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/ticket")
public class TicketController {
    private final MovieRepo movieRepo;
    private final TicketRepo ticketRepo;
    private final BookingRepo bookingRepo;
    private final BookingSeatRepo bookingSeatRepo;

    @GetMapping("/")
    public String viewTicketList(HttpSession session, Model model) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null ) {
            return "redirect:/login";
        }

        List<Booking> bookingList = bookingRepo.findByUser_UserId(user.getUserId());
        List<Ticket> ticketList = new ArrayList<>();

        for (Booking booking : bookingList) {
            ticketRepo.findByBooking_BookingId(booking.getBookingId()).ifPresent(ticketList::add);
        }

        List<TicketDTO> ticketDTOList = new ArrayList<>();
        for (Ticket ticket : ticketList) {
            TicketDTO ticketDTO = new TicketDTO();
            Booking booking = ticket.getBooking();
            String movieTitle = booking.getShowtime().getMovie().getTitle();

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
        if (user == null ) {
            return "redirect:/login";
        }

        if (bookingId == null) {
            return "redirect:/ticket";
        }

        Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null);
        if (ticket == null) {
            Ticket newTicket = new Ticket();
            newTicket.setBooking(bookingRepo.findById(bookingId).orElse(null));
        }

        Booking booking = bookingRepo.findById(bookingId).orElse(null); assert booking != null;
        Showtime showtime = booking.getShowtime();
        Movie movie = showtime.getMovie();
        Room room = showtime.getRoom();
        Cinema cinema = room.getCinema();
        List<BookingSeat> bookingSeatList = bookingSeatRepo.findByBooking(booking);
        List<String> seatNameList = new ArrayList<>();
        for (BookingSeat bookingSeat : bookingSeatList) {
            Seat seat = bookingSeat.getSeat();
            String seatRow = seat.getSeatRow();
            Integer seatNumber = seat.getSeatNumber();
            String seatName = seatRow + seatNumber;
            seatNameList.add(seatName);
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
        return "ticket-detail"; // Trang này gồm nút xem hoá đơn
    }

    @GetMapping("/{booking_id}/cancel")
    public String cancelTicket(HttpSession session, @PathVariable("booking_id") Integer bookingId) {
        if (bookingId == null) {
            return "redirect:/ticket";
        }

        bookingRepo.deleteById(bookingId);
        return "redirect:/ticket";
    }
}
