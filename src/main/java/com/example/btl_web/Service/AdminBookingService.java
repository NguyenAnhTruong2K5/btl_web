package com.example.btl_web.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.example.btl_web.DTO.BookingFilterDTO;
import com.example.btl_web.Model.Booking;
import com.example.btl_web.Model.Ticket;
import com.example.btl_web.Repository.BookingDiscountRepo;
import com.example.btl_web.Repository.BookingHistoryRepo;
import com.example.btl_web.Repository.BookingRepo;
import com.example.btl_web.Repository.BookingSeatRepo;
import com.example.btl_web.Repository.EmailLogRepo;
import com.example.btl_web.Repository.InvoiceRepo;
import com.example.btl_web.Repository.PaymentRepo;
import com.example.btl_web.Repository.TicketRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminBookingService {

    private final TicketRepo ticketRepo;
    private final BookingRepo bookingRepo;
    private final BookingSeatRepo bookingSeatRepo;
    private final BookingHistoryRepo bookingHistoryRepo;
    private final BookingDiscountRepo bookingDiscountRepo;
    private final InvoiceRepo invoiceRepo;
    private final PaymentRepo paymentRepo;
    private final EmailLogRepo emailLogRepo;
    private final SeatService seatService;

    public List<Booking> filterBookingsForCinemaAdmin(BookingFilterDTO filterDTO, Integer cinemaId) {
        List<Booking> bookings = bookingRepo.findAll();
        return bookings.stream()
                .filter(b -> Objects.equals(getCinemaId(b), cinemaId))
                .filter(b -> {
                    if (filterDTO.getMovieId() == null) {
                        return true;
                    }
                    return Objects.equals(getMovieId(b), filterDTO.getMovieId());
                })
                .filter(b -> {
                    if (filterDTO.getShowDate() == null) {
                        return true;
                    }
                    return Objects.equals(getShowDate(b), filterDTO.getShowDate());
                })
                .filter(b -> {
                    if (filterDTO.getBookingStatus() == null || filterDTO.getBookingStatus().trim().isEmpty()) {
                        return true;
                    }
                    String actualStatus = getBookingStatus(b);
                    return actualStatus != null
                            && actualStatus.trim().equalsIgnoreCase(filterDTO.getBookingStatus().trim());
                })
                .collect(Collectors.toList());
    }

    public Booking getBookingByIdForCinemaAdmin(Integer bookingId, Integer cinemaId) {
        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        if (booking == null) {
            return null;
        }
        if (!Objects.equals(getCinemaId(booking), cinemaId)) {
            return null;
        }
        return booking;
    }

    public boolean bookingBelongsToCinema(Integer bookingId, Integer cinemaId) {
        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        if (booking == null) {
            return false;
        }
        return Objects.equals(getCinemaId(booking), cinemaId);
    }

    private Integer getCinemaId(Booking b) {
        try {
            if (b == null || b.getShowtime() == null || b.getShowtime().getRoom() == null || b.getShowtime().getRoom().getCinema() == null) {
                return null;
            }
            return b.getShowtime().getRoom().getCinema().getCinemaId();
        } catch (Exception e) {
            return null;
        }
    }

    private Integer getMovieId(Booking b) {
        try {
            if (b == null || b.getShowtime() == null || b.getShowtime().getMovie() == null) {
                return null;
            }
            return b.getShowtime().getMovie().getMovieId();
        } catch (Exception e) {
            return null;
        }
    }

    private LocalDate getShowDate(Booking b) {
        try {
            if (b == null || b.getShowtime() == null) {
                return null;
            }
            return b.getShowtime().getShowDate();
        } catch (Exception e) {
            return null;
        }
    }

    private String getBookingStatus(Booking b) {
        try {
            if (b == null || b.getBookingStatus() == null) {
                return null;
            }
            return b.getBookingStatus().trim();
        } catch (Exception e) {
            return null;
        }
    }

    public Booking save(Booking booking) {
        return bookingRepo.save(booking);
    }

    public void confirmBookingAndVerifyTicket(Booking booking) {
        booking.setBookingStatus("CONFIRMED");
        bookingRepo.save(booking);

        Ticket ticket = ticketRepo.findByBooking_BookingId(booking.getBookingId()).orElse(null);
        if (ticket != null) {
            ticket.setVerified(true);
            ticketRepo.save(ticket);
        }
    }

    public void cancelBookingAndUnverifyTicket(Booking booking) {
        Integer showtimeId = booking.getShowtime() != null ? booking.getShowtime().getShowtimeId() : null;
        if (showtimeId != null) {
            bookingSeatRepo.findByBooking_BookingId(booking.getBookingId())
                    .forEach(bookingSeat -> {
                        if (bookingSeat.getSeat() != null) {
                            seatService.setSeatStatus(bookingSeat.getSeat().getSeatId(), showtimeId, "AVAILABLE");
                        }
                    });
        }

        booking.setBookingStatus("CANCELED");
        bookingRepo.save(booking);

        Ticket ticket = ticketRepo.findByBooking_BookingId(booking.getBookingId()).orElse(null);
        if (ticket != null) {
            ticket.setVerified(false);
            ticketRepo.save(ticket);
        }
    }

    public void deleteCanceledBooking(Booking booking) {
        if (booking == null || booking.getBookingId() == null) {
            throw new IllegalArgumentException("Booking không hợp lệ.");
        }

        String status = booking.getBookingStatus();
        if (status == null || !"CANCELED".equalsIgnoreCase(status.trim())) {
            throw new IllegalStateException("Chỉ được xóa booking ở trạng thái CANCELED.");
        }

        Integer bookingId = booking.getBookingId();

        emailLogRepo.deleteAll(emailLogRepo.findByBooking_BookingIdOrderBySentTimeDesc(bookingId));
        bookingHistoryRepo.deleteAll(bookingHistoryRepo.findByBooking_BookingId(bookingId));
        bookingSeatRepo.deleteAll(bookingSeatRepo.findByBooking_BookingId(bookingId));
        bookingDiscountRepo.deleteByBooking_BookingId(bookingId);
        ticketRepo.deleteByBooking_BookingId(bookingId);
        paymentRepo.deleteByBooking_BookingId(bookingId);
        invoiceRepo.deleteByBooking_BookingId(bookingId);

        bookingRepo.deleteById(bookingId);
    }
}
