package com.example.btl_web.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.BookingDiscount;

public interface BookingDiscountRepo extends JpaRepository<BookingDiscount, Integer> {

    Optional<BookingDiscount> findByBooking_BookingId(Integer bookingId);

    void deleteByBooking_BookingId(Integer bookingId);
}
