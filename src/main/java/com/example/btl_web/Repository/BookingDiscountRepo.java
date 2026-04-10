package com.example.btl_web.Repository;

import com.example.btl_web.Model.BookingDiscount;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BookingDiscountRepo extends JpaRepository<BookingDiscount, Integer> {
    Optional<BookingDiscount> findByBooking_BookingId(Integer bookingId);
}
