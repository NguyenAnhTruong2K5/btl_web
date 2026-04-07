package com.example.btl_web.Controller;

import com.example.btl_web.Model.Cinema;
import com.example.btl_web.Model.Movie;
import com.example.btl_web.Model.Role;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.CinemaRepo;
import com.example.btl_web.Repository.MovieRepo;
import com.example.btl_web.Repository.RoleRepo;
import com.example.btl_web.Repository.UserRepo;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class LoginController {
    private final UserRepo userRepo;
    private final RoleRepo roleRepo;
    private final MovieRepo movieRepo;
    private final CinemaRepo cinemaRepo;

    @GetMapping("/")
    public String indexPage(Model model, HttpSession session) {
        List<Movie> nowShowing = movieRepo.findByStatus("Đang chiếu");
        List<Movie> uniqueNowShowing = new ArrayList<>(nowShowing.stream()
                .collect(Collectors.toMap(Movie::getTitle, m -> m, (existing, replacement) -> existing))
                .values());
        Collections.shuffle(uniqueNowShowing);
        List<Movie> upcoming = movieRepo.findByStatus("Sắp chiếu");
        List<Movie> uniqueUpcoming = new ArrayList<>(upcoming.stream()
                .collect(Collectors.toMap(Movie::getTitle, m -> m, (existing, replacement) -> existing))
                .values());
        model.addAttribute("nowShowingMovies", uniqueNowShowing);
        model.addAttribute("upcomingMovies", uniqueUpcoming);

        User currUser = (User) session.getAttribute("currentUser");
        if (currUser == null) {
            return "redirect:/login";
        }
        return "index";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String loginSubmit(@RequestParam String username,
            @RequestParam String password,
            HttpSession session,
            Model model) 
    {

        User user = userRepo.findByEmail(username).orElse(userRepo.findByPhone(username).orElse(null));
        if (user == null) {
            return "redirect:/login";
        }

        if (!user.getPassword().equals(password)) {
            return "redirect:/login";
        }

        session.setAttribute("currentUser", user);

        String roleName = user.getRole() != null ? user.getRole().getRoleName() : "USER";
        if ("SUPER_ADMIN".equals(roleName)) {
            return "redirect:/admin";
        }

        return "redirect:/";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String registerSubmit(@RequestParam String fullName,
            @RequestParam String email,
            @RequestParam String phone,
            @RequestParam String birthday,
            @RequestParam String gender,
            @RequestParam String password,
            @RequestParam String confirmPassword,
            HttpSession session,
            Model model) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("registerError", "Mật khẩu và xác nhận mật khẩu không khớp.");
            return "register";
        }

        if (userRepo.existsByUsername(email) || userRepo.existsByEmail(email) || userRepo.existsByPhone(phone)) {
            model.addAttribute("registerError", "Tài khoản đã tồn tại (email/số điện thoại). Vui lòng dùng thông tin khác.");
            return "register";
        }

        Optional<Role> userRoleOpt = roleRepo.findByRoleName("USER");
        Role userRole = roleRepo.findByRoleName("USER").orElse(null);

        User user = new User();
        user.setUsername(email);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRole(userRole);

        userRepo.save(user);

        session.setAttribute("currentUser", user);

        return "redirect:/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/profile")
    public String profilePage(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "profile";
    }

    @GetMapping("/profile/edit")
    public String editProfilePage(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "edit-profile";
    }

    @PostMapping("/profile/edit")
    public String editProfileSubmit(
            @RequestParam String fullName,
            @RequestParam String phone,
            @RequestParam(value = "avatar", required = false) MultipartFile avatar,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        currentUser.setFullName(fullName);
        currentUser.setPhone(phone);

        try {
            String uploadDir = Paths.get(System.getProperty("user.dir"), "uploads", "avatars").toString();
            java.io.File uploadPath = new java.io.File(uploadDir);
            if (!uploadPath.exists()) {
                uploadPath.mkdirs();
            }
            String fileName = currentUser.getUserId() + "_" + avatar.getOriginalFilename();
            java.io.File file = new java.io.File(uploadPath, fileName);
            avatar.transferTo(file);
            currentUser.setAvatar("uploads/avatars/" + fileName);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("profileError", "Lỗi khi tải lên ảnh đại diện: " + e.getMessage());
            return "redirect:/profile/edit";
        }

        userRepo.save(currentUser);
        session.setAttribute("currentUser", currentUser);
        redirectAttributes.addFlashAttribute("profileSuccess", "Cập nhật thông tin thành công.");
        return "redirect:/profile";
    }

    @GetMapping("/admin")
    public String adminPage() {
        return "admin";
    }

    @GetMapping("/now-showing")
    public String nowShowingPage(Model model) {
        List<Movie> nowShowing = movieRepo.findByStatus("Đang chiếu");
        List<Movie> uniqueNowShowing = new ArrayList<>(nowShowing.stream()
                .collect(Collectors.toMap(Movie::getTitle, m -> m, (existing, replacement) -> existing))
                .values());
        model.addAttribute("nowShowingMovies", uniqueNowShowing);
        return "now-showing";
    }

    @GetMapping("/upcoming")
    public String upcomingPage(Model model) {
        List<Movie> upcoming = movieRepo.findByStatus("Sắp chiếu");
        List<Movie> uniqueUpcoming = new ArrayList<>(upcoming.stream()
                .collect(Collectors.toMap(Movie::getTitle, m -> m, (existing, replacement) -> existing))
                .values());
        model.addAttribute("upcomingMovies", uniqueUpcoming);
        return "upcoming";
    }

    @GetMapping("/theater")
    public String theaterPage(
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String brand,
            Model model) {
        List<Cinema> cinemas = cinemaRepo.findAll();

        if (city != null && !city.isBlank()) {
            String normalizedCity = city.trim();
            cinemas = cinemas.stream()
                    .filter(cinema -> matchesCityFilter(cinema, normalizedCity))
                    .collect(Collectors.toList());
        }
        if (brand != null && !brand.isBlank()) {
            String normalizedBrand = brand.trim();
            cinemas = cinemas.stream()
                    .filter(cinema -> matchesBrandFilter(cinema, normalizedBrand))
                    .collect(Collectors.toList());
        }

        model.addAttribute("cinemas", cinemas);
        model.addAttribute("selectedCity", city != null ? city : "");
        model.addAttribute("selectedBrand", brand != null ? brand : "");
        return "theater";
    }

    private boolean matchesCityFilter(Cinema cinema, String selectedCity) {
        if (cinema.getCity() == null) {
            return false;
        }
        String cityValue = cinema.getCity().toLowerCase();
        String normalizedSelected = selectedCity.toLowerCase();

        if (normalizedSelected.contains("hà nội")) {
            return cityValue.contains("hà nội");
        }
        if (normalizedSelected.contains("hồ chí minh") || normalizedSelected.contains("tp. hồ chí minh") || normalizedSelected.contains("tp hồ chí minh")) {
            return cityValue.contains("hồ chí minh") || cityValue.contains("tp. hồ chí minh") || cityValue.contains("tp hồ chí minh") || cityValue.contains("hcm");
        }
        return cityValue.contains(normalizedSelected);
    }

    private boolean matchesBrandFilter(Cinema cinema, String selectedBrand) {
        if (cinema.getBrand() == null) {
            return false;
        }
        String brandValue = cinema.getBrand().toLowerCase();
        String normalizedSelected = selectedBrand.toLowerCase();

        if (normalizedSelected.contains("cgv")) {
            return brandValue.contains("cgv");
        }
        if (normalizedSelected.contains("beta")) {
            return brandValue.contains("beta");
        }
        if (normalizedSelected.contains("lotte")) {
            return brandValue.contains("lotte");
        }
        if (normalizedSelected.contains("galaxy")) {
            return brandValue.contains("galaxy");
        }
        return brandValue.contains(normalizedSelected);
    }

    @GetMapping("/promotion")
    public String promotionPage() {
        return "promotion";
    }

    @GetMapping("/change-password")
    public String changePasswordPage(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "change-password";
    }

    @PostMapping("/change-password")
    public String changePasswordSubmit(
            @RequestParam String currentPassword,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        if (!currentUser.getPassword().equals(currentPassword)) {
            redirectAttributes.addFlashAttribute("changePasswordError", "Mật khẩu hiện tại không đúng.");
            return "redirect:/change-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("changePasswordError", "Mật khẩu mới và xác nhận không khớp.");
            return "redirect:/change-password";
        }

        if (newPassword.equals(currentPassword)) {
            redirectAttributes.addFlashAttribute("changePasswordError", "Mật khẩu mới không được giống mật khẩu hiện tại.");
            return "redirect:/change-password";
        }

        if (newPassword.length() < 6) {
            redirectAttributes.addFlashAttribute("changePasswordError", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            return "redirect:/change-password";
        }

        currentUser.setPassword(newPassword);
        userRepo.save(currentUser);
        session.setAttribute("currentUser", currentUser);
        redirectAttributes.addFlashAttribute("changePasswordSuccess", "Đổi mật khẩu thành công.");
        return "redirect:/profile";
    }

    @GetMapping("/tickets")
    public String ticketsPage(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "redirect:/profile"; // Placeholder
    }

    @GetMapping("/favorites")
    public String favoritesPage(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "redirect:/profile"; // Placeholder
    }

    @GetMapping("/history")
    public String historyPage(HttpSession session) {
        if (session.getAttribute("currentUser") == null) {
            return "redirect:/login";
        }
        return "redirect:/profile"; // Placeholder
    }
}
