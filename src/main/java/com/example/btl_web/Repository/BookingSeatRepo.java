package com.example.btl_web.Repository;

import com.example.btl_web.Model.Booking;
import com.example.btl_web.Model.BookingSeat;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookingSeatRepo extends JpaRepository<BookingSeat, Integer> {
    List<BookingSeat> findByBooking(Booking booking);
}
