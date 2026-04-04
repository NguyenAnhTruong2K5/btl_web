package com.example.btl_web.Repository;

import com.example.btl_web.Model.Showtime;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShowtimeRepo extends JpaRepository<Showtime, Integer> {
    List<Showtime> findByMovie_MovieId(Integer movieId);
}
