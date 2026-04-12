package com.example.btl_web.Service;

import com.example.btl_web.Model.Admin;
import com.example.btl_web.Model.Cinema;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.AdminRepo;
import com.example.btl_web.Repository.CinemaRepo;
import com.example.btl_web.Repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class AdminService {
    @Autowired
    private AdminRepo adminRepository;

    @Autowired
    private UserRepo userRepository;

    @Autowired
    private CinemaRepo cinemaRepository;

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
    public Admin findByUser(@NonNull Integer userId) {
        return adminRepository.findByUserUserId(userId).orElse(null);
    }

    /**
     * Get admin by user ID and cinema ID
     */
    public Admin findByUserAndCinema(@NonNull Integer userId, @NonNull Integer cinemaId) {
        return adminRepository.findByUserUserIdAndCinemaCinemaId(userId, cinemaId).orElse(null);
    }

    /**
     * Check if user is admin of a specific cinema
     */
    public boolean isAdminOfCinema(@NonNull Integer userId, @NonNull Integer cinemaId) {
        return adminRepository.existsByUserUserIdAndCinemaCinemaId(userId, cinemaId);
    }

    /**
     * Save or update admin
     */
    public Admin save(@NonNull Admin admin) {
        // Validate user exists
        if (admin.getUser() != null && admin.getUser().getUserId() != null) {
            Integer userId = admin.getUser().getUserId();
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
    public Admin saveAdminForUserAndCinema(@NonNull Integer userId, @NonNull Integer cinemaId) {
        // Check if admin already exists
        if (isAdminOfCinema(Integer.valueOf(userId), cinemaId)) {
            throw new IllegalArgumentException("User is already an admin of this cinema");
        }

        User user = userRepository.findById(userId).orElse(null);
        Cinema cinema = cinemaRepository.findById(cinemaId).orElse(null);

        if (user == null) {
            throw new IllegalArgumentException("User not found");
        }
        if (cinema == null) {
            throw new IllegalArgumentException("Cinema not found");
        }

        Admin admin = new Admin();
        admin.setUser(user);
        admin.setCinema(cinema);

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
    public void deleteAdminFromCinema(@NonNull Integer userId, @NonNull Integer cinemaId) {
        Optional<Admin> admin = adminRepository.findByUserUserIdAndCinemaCinemaId(userId, cinemaId);
        admin.ifPresent(adminRepository::delete);
    }

    /**
     * Get count of admins for a cinema
     */
    public Integer countAdminsForCinema(@NonNull Integer cinemaId) {
        return adminRepository.findByCinemaCinemaId(cinemaId).size();
    }

    /**
     * Delete all admin associations for a user
     * Used when downgrading a user from CINEMA_ADMIN to USER role
     */
    @org.springframework.transaction.annotation.Transactional
    public void deleteAllAdminsForUser(@NonNull Integer userId) {
        adminRepository.deleteByUserUserId(userId);
    }

    /**
     * Delete all admin associations for a cinema
     * Used when deleting a cinema to remove all admin records first
     */
    @org.springframework.transaction.annotation.Transactional
    public void deleteAllAdminsForCinema(@NonNull Integer cinemaId) {
        adminRepository.deleteByCinemaCinemaId(cinemaId);
    }
}
