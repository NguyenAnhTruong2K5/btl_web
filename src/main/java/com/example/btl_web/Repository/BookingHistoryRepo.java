package com.example.btl_web.Repository;

import com.example.btl_web.Model.BookingHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookingHistoryRepo extends JpaRepository<BookingHistory, Integer> {
}
