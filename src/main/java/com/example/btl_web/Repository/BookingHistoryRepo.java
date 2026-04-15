package com.example.btl_web.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.BookingHistory;

public interface BookingHistoryRepo extends JpaRepository<BookingHistory, Integer> {

    List<BookingHistory> findByBooking_BookingId(Integer bookingId);
}
