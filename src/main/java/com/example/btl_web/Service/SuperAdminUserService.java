package com.example.btl_web.Service;

import com.example.btl_web.Model.Cinema;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.CinemaRepo;
import com.example.btl_web.Repository.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class SuperAdminUserService {
    @Autowired
    UserRepo userRepository;

    @Autowired
    AdminService adminService;

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    public User findById(Integer id){
        if (id == null) {
            return null;
        }
        return userRepository.findById(id).orElse(null);
    }

    /**
     * Check if username already exists (excluding a specific user ID for updates)
     */
    public boolean isUsernameExists(String username, Integer excludeUserId) {
        if (username == null || username.isEmpty()) {
            return false;
        }
        Optional<User> existingUser = userRepository.findByUsername(username);
        if (existingUser.isEmpty()) {
            return false;
        }
        // Nếu là update, check xem có user khác dùng username này không
        if (excludeUserId != null && existingUser.isPresent()) {
            return !existingUser.get().getUserId().equals(excludeUserId);
        }
        return existingUser.isPresent();
    }

    /**
     * Check if email already exists (excluding a specific user ID for updates)
     */
    public boolean isEmailExists(String email, Integer excludeUserId) {
        if (email == null || email.isEmpty()) {
            return false;
        }
        Optional<User> existingUser = userRepository.findByEmail(email);
        if (existingUser.isEmpty()) {
            return false;
        }
        // Nếu là update, check xem có user khác dùng email này không
        if (excludeUserId != null && existingUser.isPresent()) {
            return !existingUser.get().getUserId().equals(excludeUserId);
        }
        return existingUser.isPresent();
    }

    /**
     * Check if phone already exists (excluding a specific user ID for updates)
     */
    public boolean isPhoneExists(String phone, Integer excludeUserId) {
        if (phone == null || phone.isEmpty()) {
            return false;
        }
        Optional<User> existingUser = userRepository.findByPhone(phone);
        if (existingUser.isEmpty()) {
            return false;
        }
        // Nếu là update, check xem có user khác dùng phone này không
        if (excludeUserId != null && existingUser.isPresent()) {
            return !existingUser.get().getUserId().equals(excludeUserId);
        }
        return existingUser.isPresent();
    }

    /**
     * Validate user data before saving
     * @return error message if validation fails, null if success
     */
    public String validateUser(User user) {
        if (user == null) {
            return "Dữ liệu người dùng không hợp lệ.";
        }

        // Check if username is empty
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) {
            return "Tên đăng nhập không được để trống.";
        }

        // Check if email is empty
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return "Email không được để trống.";
        }

        // Check if phone is empty
        if (user.getPhone() == null || user.getPhone().trim().isEmpty()) {
            return "Số điện thoại không được để trống.";
        }

        // For new user (no ID)
        Integer userId = user.getUserId();

        if (isUsernameExists(user.getUsername(), (userId))) {
            return "Tên đăng nhập đã tồn tại.";
        }

        if (isEmailExists(user.getEmail(), (userId))) {
            return "Email đã được đăng ký.";
        }

        if (isPhoneExists(user.getPhone(), (userId))) {
            return "Số điện thoại đã được đăng ký.";
        }

        return null; // No validation error
    }

    public void save(User user){
        if (user != null) {
            userRepository.save(user);
        }
    }

    @Transactional
    public void delete(Integer id){
        if (id != null) {
            // Xóa tất cả admin associations trước khi xóa user
            // Để tránh foreign key constraint violation
            adminService.deleteAllAdminsForUser(id);
            userRepository.deleteById(id);
        }
    }
}
