package com.example.btl_web.Repository;

import com.example.btl_web.Model.Ticket;
import lombok.RequiredArgsConstructor;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TicketRepo extends JpaRepository<Ticket, Integer> {
    Optional<Ticket> findByBooking_BookingId(Integer bookingId);

}
