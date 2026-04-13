package com.example.btl_web.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.btl_web.Service.AdminService;
import com.example.btl_web.Model.Admin;
import com.example.btl_web.Model.Cinema;
import com.example.btl_web.Repository.CinemaRepo;
import com.example.btl_web.Repository.UserRepo;

@Controller
@RequestMapping("/superAdmin/admins")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private UserRepo userRepository;

    @Autowired
    private CinemaRepo cinemaRepository;

    /**
     * Display list of all admins
     */
    @GetMapping
    public String listAdmins(Model Model) {
        List<Admin> admins = adminService.findAll();
        Model.addAttribute("admins", admins);
        return "admin_management";
    }

    /**
     * Show form to create new admin
     */
    @GetMapping("/create")
    public String showCreateAdminForm(Model Model) {
        Model.addAttribute("admin", new Admin());
        Model.addAttribute("users", userRepository.findByRoleRoleName("CINEMA_ADMIN"));
        Model.addAttribute("cinemas", cinemaRepository.findAll());
        return "admin_form";
    }

    /**
     * Save new admin
     */
    @PostMapping("/save")
    public String saveAdmin(@ModelAttribute Admin admin) {
        try {
            if (admin != null) {
                adminService.save(admin);
            }
            return "redirect:/superAdmin/admins";
        } catch (IllegalArgumentException e) {
            return "redirect:/superAdmin/admins/create?error=" + e.getMessage();
        }
    }

    /**
     * Show form to edit admin
     */
    @GetMapping("/edit/{id}")
    public String showEditAdminForm(@PathVariable Integer id, Model Model) {
        if (id != null) {
            Admin admin = adminService.findById(id);
            if (admin == null) {
                return "redirect:/superAdmin/admins?error=Admin not found";
            }
            Model.addAttribute("admin", admin);
            Model.addAttribute("users", userRepository.findByRoleRoleName("CINEMA_ADMIN"));
            Model.addAttribute("cinemas", cinemaRepository.findAll());
            return "admin_form";
        }
        return "redirect:/superAdmin/admins?error=Invalid admin ID";
    }

    /**
     * Update admin
     */
    @PostMapping("/update/{id}")
    public String updateAdmin(@PathVariable Integer id, @ModelAttribute Admin admin) {
        if (id != null) {
            admin.setAdminId(id);
            try {
                adminService.save(admin);
                return "redirect:/superAdmin/admins";
            } catch (IllegalArgumentException e) {
                return "redirect:/superAdmin/admins/edit/" + id + "?error=" + e.getMessage();
            }
        }
        return "redirect:/superAdmin/admins?error=Invalid admin ID";
    }

    /**
     * Delete admin
     */
    @GetMapping("/delete/{id}")
    public String deleteAdmin(@PathVariable Integer id) {
        if (id != null) {
            adminService.delete(id);
        }
        return "redirect:/superAdmin/admins";
    }

    /**
     * Get admins by cinema
     */
    @GetMapping("/cinema/{cinemaId}")
    public String getAdminsByCinema(@PathVariable Integer cinemaId, Model Model) {
        if (cinemaId != null) {
            Cinema cinema = cinemaRepository.findById(cinemaId).orElse(null);
            if (cinema == null) {
                return "redirect:/superAdmin/admins?error=Cinema not found";
            }
            List<Admin> admins = adminService.findByCinema(cinemaId);
            Model.addAttribute("cinema", cinema);
            Model.addAttribute("admins", admins);
            return "cinema_admins";
        }
        return "redirect:/superAdmin/admins?error=Invalid cinema ID";
    }

    /**
     * Assign user as admin to cinema
     */
    @PostMapping("/assign")
    public String assignAdminToCinema(
            @RequestParam Integer userId,
            @RequestParam Integer cinemaId) {
        try {
            if (userId != null && cinemaId != null) {
                adminService.saveAdminForUserAndCinema(userId, cinemaId);
                return "redirect:/superAdmin/admins?success=Admin assigned successfully";
            }
            return "redirect:/superAdmin/admins?error=Invalid user or cinema ID";
        } catch (IllegalArgumentException e) {
            return "redirect:/superAdmin/admins?error=" + e.getMessage();
        }
    }

    /**
     * Remove admin from cinema
     */
    @GetMapping("/remove")
    public String removeAdminFromCinema(
            @RequestParam Integer userId,
            @RequestParam Integer cinemaId) {
        if (userId != null && cinemaId != null) {
            adminService.deleteAdminFromCinema(userId, cinemaId);
            return "redirect:/superAdmin/admins?success=Admin removed successfully";
        }
        return "redirect:/superAdmin/admins?error=Invalid user or cinema ID";
    }

    /**
     * Check if user is admin of cinema
     */
    @GetMapping("/check")
    @ResponseBody
    public boolean isAdminOfCinema(
            @RequestParam Integer userId,
            @RequestParam Integer cinemaId) {
        if (userId != null && cinemaId != null) {
            return adminService.isAdminOfCinema(userId, cinemaId);
        }
        return false;
    }
}
