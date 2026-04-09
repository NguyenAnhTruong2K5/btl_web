package com.cinemavn.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinemavn.model.User;
import com.cinemavn.repository.UserRepository;

@Service
public class SuperAdminUserService {

    @Autowired
    UserRepository userRepository;

    public List<User> getAllUsers(){
        return userRepository.findAll();
    }

    public User findById(Long id){
        if (id == null) {
            return null;
        }
        return userRepository.findById(id).orElse(null);
    }

    /**
     * Check if username already exists (excluding a specific user ID for updates)
     */
    public boolean isUsernameExists(String username, Long excludeUserId) {
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
    public boolean isEmailExists(String email, Long excludeUserId) {
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
    public boolean isPhoneExists(String phone, Long excludeUserId) {
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
        Long userId = user.getUserId();
        
        if (isUsernameExists(user.getUsername(), userId)) {
            return "Tên đăng nhập đã tồn tại.";
        }

        if (isEmailExists(user.getEmail(), userId)) {
            return "Email đã được đăng ký.";
        }

        if (isPhoneExists(user.getPhone(), userId)) {
            return "Số điện thoại đã được đăng ký.";
        }

        return null; // No validation error
    }

    public void save(User user){
        if (user != null) {
            userRepository.save(user);
        }
    }

    public void delete(Long id){
        if (id != null) {
            userRepository.deleteById(id);
        }
    }

}
