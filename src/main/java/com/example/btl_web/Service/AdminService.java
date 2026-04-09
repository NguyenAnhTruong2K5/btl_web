package com.cinemavn.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cinemavn.model.Admin;
import com.cinemavn.model.Cinema;
import com.cinemavn.model.User;
import com.cinemavn.repository.AdminRepository;
import com.cinemavn.repository.CinemaRepository;
import com.cinemavn.repository.UserRepository;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CinemaRepository cinemaRepository;

    /**
     * Get all admins
     */
    public List<Admin> findAll() {
        return adminRepository.findAll();
    }

    /**
     * Get admin by ID
     */
    public Admin findById(@NonNull Integer id) {
        return adminRepository.findById(id).orElse(null);
    }

    /**
     * Get all admins by cinema
     */
    public List<Admin> findByCinema(@NonNull Integer cinemaId) {
        Cinema cinema = cinemaRepository.findById(cinemaId).orElse(null);
        if (cinema != null) {
            return adminRepository.findByCinema(cinema);
        }
        return List.of();
    }

    /**
     * Get admin by user
     */
    public Admin findByUser(@NonNull Long userId) {
        return adminRepository.findByUserUserId(userId).orElse(null);
    }

    /**
     * Get admin by user ID and cinema ID
     */
    public Admin findByUserAndCinema(@NonNull Long userId, @NonNull Integer cinemaId) {
        return adminRepository.findByUserUserIdAndCinemaCinemaId(userId, cinemaId).orElse(null);
    }

    /**
     * Check if user is admin of a specific cinema
     */
    public boolean isAdminOfCinema(@NonNull Long userId, @NonNull Integer cinemaId) {
        return adminRepository.existsByUserUserIdAndCinemaCinemaId(userId, cinemaId);
    }

    /**
     * Save or update admin
     */
    public Admin save(@NonNull Admin admin) {
        // Validate user exists
        if (admin.getUser() != null && admin.getUser().getUserId() != null) {
            Long userId = admin.getUser().getUserId();
            Optional<User> user = userRepository.findById(userId);
            if (user.isEmpty()) {
                throw new IllegalArgumentException("User not found");
            }
            admin.setUser(user.get());
        }

        // Validate cinema exists
        if (admin.getCinema() != null && admin.getCinema().getCinemaId() != null) {
            Integer cinemaId = admin.getCinema().getCinemaId();
            Optional<Cinema> cinema = cinemaRepository.findById(cinemaId);
            if (cinema.isEmpty()) {
                throw new IllegalArgumentException("Cinema not found");
            }
            admin.setCinema(cinema.get());
        }

        return adminRepository.save(admin);
    }

    /**
     * Save admin for a user and cinema
     */
    public Admin saveAdminForUserAndCinema(@NonNull Long userId, @NonNull Integer cinemaId) {
        // Check if admin already exists
        if (isAdminOfCinema(userId, cinemaId)) {
            throw new IllegalArgumentException("User is already an admin of this cinema");
        }

        Optional<User> user = userRepository.findById(userId);
        Optional<Cinema> cinema = cinemaRepository.findById(cinemaId);

        if (user.isEmpty()) {
            throw new IllegalArgumentException("User not found");
        }
        if (cinema.isEmpty()) {
            throw new IllegalArgumentException("Cinema not found");
        }

        Admin admin = new Admin(user.get(), cinema.get());
        return adminRepository.save(admin);
    }

    /**
     * Delete admin by ID
     */
    @Transactional
    public void delete(@NonNull Integer id) {
        adminRepository.deleteById(id);
    }

    /**
     * Delete admin by user and cinema
     */
    @Transactional
    public void deleteAdminFromCinema(@NonNull Long userId, @NonNull Integer cinemaId) {
        Optional<Admin> admin = adminRepository.findByUserUserIdAndCinemaCinemaId(userId, cinemaId);
        admin.ifPresent(adminRepository::delete);
    }

    /**
     * Get count of admins for a cinema
     */
    public long countAdminsForCinema(@NonNull Integer cinemaId) {
        return adminRepository.findByCinemaCinemaId(cinemaId).size();
    }

    /**
     * Delete all admin associations for a user
     * Used when downgrading a user from CINEMA_ADMIN to USER role
     */
    @Transactional
    public void deleteAllAdminsForUser(@NonNull Long userId) {
        adminRepository.deleteByUserUserId(userId);
    }

    /**
     * Delete all admin associations for a cinema
     * Used when deleting a cinema to remove all admin records first
     */
    @Transactional
    public void deleteAllAdminsForCinema(@NonNull Integer cinemaId) {
        adminRepository.deleteByCinemaCinemaId(cinemaId);
    }
}
