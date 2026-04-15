package com.example.btl_web.Util;

import com.example.btl_web.Repository.AdminRepo;
import com.example.btl_web.Model.Admin;
import com.example.btl_web.Model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Optional;

/**
 * Utility class để kiểm tra authorization dựa trên cinema
 * Đảm bảo cinema admin chỉ quản lý rạp của riêng họ
 */
@Component
@RequiredArgsConstructor
public class AuthorizationUtil {

    private final AdminRepo adminRepo;

    /**
     * Lấy cinema_id của user hiện tại từ session
     * @param request HttpServletRequest
     * @return cinema_id hoặc null nếu không phải admin
     */
    public Integer getCurrentUserCinemaId(HttpServletRequest request) {
        Integer userId = getCurrentUserId(request);
        if (userId == null) {
            return null;
        }

        Optional<Admin> admin = adminRepo.findByUserUserId(userId);
        return admin.map(a -> a.getCinema().getCinemaId()).orElse(null);
    }

    /**
     * Lấy user_id từ session
     * @param request HttpServletRequest
     * @return user_id hoặc null
     */
    public Integer getCurrentUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }

        // Thử lấy từ currentUser (User object)
        Object userObj = session.getAttribute("currentUser");
        if (userObj instanceof com.example.btl_web.Model.User user) {
            return user.getUserId();
        }

        // Fallback: thử lấy từ loggedInUserId (nếu có)
        Object userIdObj = session.getAttribute("loggedInUserId");
        if (userIdObj instanceof Integer id) {
            return id;
        }
        return null;
    }

    /**
     * Lấy user role từ session
     * @param request HttpServletRequest
     * @return role name (ADMIN, SUPER_ADMIN, USER, etc.) hoặc null
     */
    public String getCurrentUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }

        Object roleObj = session.getAttribute("userRole");
        return roleObj instanceof String ? (String) roleObj : null;
    }

    /**
     * Kiểm tra xem user hiện tại có quyền quản lý cinema này không
     * @param request HttpServletRequest
     * @param cinemaId ID của cinema
     * @return true nếu user là super admin hoặc là cinema admin của cinema này
     */
    public boolean hasAccessToCinema(HttpServletRequest request, Integer cinemaId) {
        if (isSuperAdmin(request)) {
            return true; // Super admin có quyền truy cập tất cả
        }

        Integer userCinemaId = getCurrentUserCinemaId(request);
        return userCinemaId != null && userCinemaId.equals(cinemaId);
    }

    /**
     * Kiểm tra xem user là cinema admin không
     * @param request HttpServletRequest
     * @return true nếu là cinema admin
     */
    public boolean isCinemaAdmin(HttpServletRequest request) {
        return getCurrentUserCinemaId(request) != null;
    }

    /**
     * Kiểm tra xem user là super admin không
     * @param request HttpServletRequest
     * @return true nếu là super admin
     */
    public boolean isSuperAdmin(HttpServletRequest request) {
        String role = getCurrentUserRole(request);
        return "SUPER_ADMIN".equals(role) || "Admin".equals(role);
    }

    /**
     * Kiểm tra xem user có đăng nhập không
     * @param request HttpServletRequest
     * @return true nếu user đã đăng nhập
     */
    public boolean isLoggedIn(HttpServletRequest request) {
        return getCurrentUserId(request) != null;
    }

    /**
     * Lấy cinema access info của user
     * @param request HttpServletRequest
     * @return CinemaAccessInfo object
     */
    public CinemaAccessInfo getCinemaAccessInfo(HttpServletRequest request) {
        return new CinemaAccessInfo(
            getCurrentUserId(request),
            getCurrentUserCinemaId(request),
            getCurrentUserRole(request),
            isSuperAdmin(request),
            isCinemaAdmin(request)
        );
    }

    /**
     * Helper class chứa cinema access information
     */
    public static class CinemaAccessInfo {
        public final Integer userId;
        public final Integer cinemaId;
        public final String role;
        public final boolean isSuperAdmin;
        public final boolean isCinemaAdmin;

        public CinemaAccessInfo(Integer userId, Integer cinemaId, String role, 
                                boolean isSuperAdmin, boolean isCinemaAdmin) {
            this.userId = userId;
            this.cinemaId = cinemaId;
            this.role = role;
            this.isSuperAdmin = isSuperAdmin;
            this.isCinemaAdmin = isCinemaAdmin;
        }

        public boolean hasAccess(Integer targetCinemaId) {
            if (isSuperAdmin) return true;
            return cinemaId != null && cinemaId.equals(targetCinemaId);
        }
    }
}
