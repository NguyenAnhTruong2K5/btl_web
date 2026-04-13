package com.example.btl_web.Repository;

import com.example.btl_web.Model.Showtime;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public interface ShowtimeRepo extends JpaRepository<Showtime, Integer> {

    List<Showtime> findByMovie_MovieId(Integer movieId);

    long countByRoom_RoomId(int roomId);

    // 🔥 CHECK TRÙNG SUẤT CHIẾU
    @Query("SELECT s FROM Showtime s " +
            "WHERE s.room.roomId = :roomId " +
            "AND s.showDate = :showDate " +
            "AND s.startTime < :endTime " +
            "AND s.endTime > :startTime")
    List<Showtime> findConflictingShowtimes(
            @Param("roomId") Integer roomId,
            @Param("showDate") LocalDate showDate,
            @Param("startTime") LocalTime startTime,
            @Param("endTime") LocalTime endTime
    );
}