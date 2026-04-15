package com.example.btl_web.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.btl_web.Model.Showtime;

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

    // 🔐 CINEMA-BASED FILTERING (cho authorization)
    /**
     * Lấy tất cả suất chiếu của một rạp (cinema)
     * Hữu ích cho cinema admin để xem toàn bộ suất chiếu của rạp họ quản lý
     */
    @Query("SELECT s FROM Showtime s " +
            "WHERE s.room.cinema.cinemaId = :cinemaId " +
            "ORDER BY s.showDate DESC, s.startTime DESC")
    List<Showtime> findByCinema_CinemaId(@Param("cinemaId") Integer cinemaId);

    /**
     * Lấy suất chiếu của rạp trong ngày hôm nay
     */
    @Query("SELECT s FROM Showtime s " +
            "WHERE s.room.cinema.cinemaId = :cinemaId " +
            "AND s.showDate = CURRENT_DATE " +
            "ORDER BY s.startTime ASC")
    List<Showtime> findTodayShowtimesByCinema(@Param("cinemaId") Integer cinemaId);

    /**
     * Lấy suất chiếu sắp diễn ra của rạp
     */
    @Query("SELECT s FROM Showtime s " +
            "WHERE s.room.cinema.cinemaId = :cinemaId " +
            "AND s.showDate >= CURRENT_DATE " +
            "ORDER BY s.showDate ASC, s.startTime ASC")
    List<Showtime> findUpcomingShowtimesByCinema(@Param("cinemaId") Integer cinemaId);
}
