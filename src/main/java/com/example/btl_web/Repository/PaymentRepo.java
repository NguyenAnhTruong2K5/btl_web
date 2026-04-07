package com.example.btl_web.Repository;

import com.example.btl_web.Model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PaymentRepo extends JpaRepository<Payment, Integer> {
    Optional<Payment> findByBooking_BookingId(Integer bookingId);
}
