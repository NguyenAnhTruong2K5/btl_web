package com.example.btl_web.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.btl_web.Model.Admin;
import com.example.btl_web.Model.Cinema;
import com.example.btl_web.Model.User;

public interface AdminRepo extends JpaRepository<Admin, Integer> {

    /**
     * Find all admins by cinema
     */
    List<Admin> findByCinema(Cinema cinema);

    /**
     * Find admin by cinema ID
     */
    List<Admin> findByCinemaCinemaId(Integer cinemaId);

    /**
     * Find admin by user ID
     */
    Optional<Admin> findByUser(User user);

    /**
     * Find admin by user ID
     */
    Optional<Admin> findByUserUserId(Integer userId);

    /**
     * Check if user is admin of a specific cinema
     */
    boolean existsByUserAndCinema(User user, Cinema cinema);

    /**
     * Check if user is admin of a specific cinema ID
     */
    boolean existsByUserUserIdAndCinemaCinemaId(Integer userId, Integer cinemaId);

    /**
     * Find admin by user ID and cinema ID
     */
    Optional<Admin> findByUserUserIdAndCinemaCinemaId(Integer userId, Integer cinemaId);

    /**
     * Delete all admins by user ID
     */
    void deleteByUserUserId(Integer userId);

    /**
     * Delete all admins by cinema ID
     */
    void deleteByCinemaCinemaId(Integer cinemaId);
}
