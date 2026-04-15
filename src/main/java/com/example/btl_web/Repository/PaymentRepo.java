package com.example.btl_web.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.Payment;

public interface PaymentRepo extends JpaRepository<Payment, Integer> {

    Optional<Payment> findByBooking_BookingId(Integer bookingId);

    void deleteByBooking_BookingId(Integer bookingId);
}
