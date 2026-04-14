package com.example.btl_web.Controller;

import com.example.btl_web.Model.Admin;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.AdminRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class AdminCinemaController {

    private final AdminRepo adminRepo;

    @GetMapping("/admin/cinema")
    public String adminCinemaDashboard(HttpSession session, Model model) {
        Object obj = session.getAttribute("currentUser");
        if (!(obj instanceof User)) {
            return "redirect:/login";
        }

        User currentUser = (User) obj;
        String roleName = currentUser.getRole() != null ? currentUser.getRole().getRoleName() : "";

        if (!"CINEMA_ADMIN".equals(roleName)) {
            return "redirect:/login";
        }

        Optional<Admin> adminOpt = adminRepo.findByUserUserId(currentUser.getUserId());
        if (adminOpt.isPresent() && adminOpt.get().getCinema() != null) {
            model.addAttribute("cinema", adminOpt.get().getCinema());
        }

        model.addAttribute("currentUser", currentUser);
        return "admin-cinema-dashboard";
    }
}