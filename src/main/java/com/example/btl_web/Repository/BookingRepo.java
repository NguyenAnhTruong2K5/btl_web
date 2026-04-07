package com.example.btl_web.Repository;

import com.example.btl_web.Model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BookingRepo extends JpaRepository<Booking, Integer> {
    List<Booking> findByUser_UserId(Integer userId);
}
