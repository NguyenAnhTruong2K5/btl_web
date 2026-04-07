package com.example.btl_web.Repository;

import com.example.btl_web.Model.Movie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovieRepo extends JpaRepository<Movie, Integer> {
    @Query("SELECT DISTINCT m FROM Movie m WHERE m.status = :status")
    List<Movie> findByStatus(String status);
}
