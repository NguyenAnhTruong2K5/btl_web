package com.example.btl_web.Repository;

import com.example.btl_web.Model.Invoice;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface InvoiceRepo extends JpaRepository<Invoice, Integer> {
    Optional<Invoice> findByBooking_BookingId(Integer bookingId);
}
