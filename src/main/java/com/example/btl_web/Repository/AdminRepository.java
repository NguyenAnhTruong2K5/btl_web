package com.cinemavn.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cinemavn.model.Admin;
import com.cinemavn.model.Cinema;
import com.cinemavn.model.User;

public interface AdminRepository extends JpaRepository<Admin, Integer> {

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
    Optional<Admin> findByUserUserId(Long userId);

    /**
     * Check if user is admin of a specific cinema
     */
    boolean existsByUserAndCinema(User user, Cinema cinema);

    /**
     * Check if user is admin of a specific cinema ID
     */
    boolean existsByUserUserIdAndCinemaCinemaId(Long userId, Integer cinemaId);

    /**
     * Find admin by user ID and cinema ID
     */
    Optional<Admin> findByUserUserIdAndCinemaCinemaId(Long userId, Integer cinemaId);
}
