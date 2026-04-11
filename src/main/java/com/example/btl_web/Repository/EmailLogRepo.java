package com.example.btl_web.Repository;

import com.example.btl_web.Model.EmailLog;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EmailLogRepo extends JpaRepository<EmailLog, Integer> {

    List<EmailLog> findByBooking_BookingIdOrderBySentTimeDesc(Integer bookingId);
}