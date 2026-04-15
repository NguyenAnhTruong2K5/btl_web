package com.example.btl_web.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.Ticket;

public interface TicketRepo extends JpaRepository<Ticket, Integer> {

    Optional<Ticket> findByBooking_BookingId(Integer bookingId);

    void deleteByBooking_BookingId(Integer bookingId);

}
