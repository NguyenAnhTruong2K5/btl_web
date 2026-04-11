package com.example.btl_web.Controller;

import com.example.btl_web.Service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.btl_web.Service.SuperAdminUserService;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.CinemaRepo;
import com.example.btl_web.Repository.RoleRepo;

@Controller
@RequestMapping("/superAdmin/users")
public class AdminUserController {

    @Autowired
    SuperAdminUserService userService;

    @Autowired
    AdminService adminService;

    @Autowired
    RoleRepo roleRepository;

    @Autowired
    CinemaRepo cinemaRepository;

    @GetMapping
    public String list(Model model){

        model.addAttribute("users",
                userService.getAllUsers());

        return "user_management";
    }

    @GetMapping("/create")
    public String create(Model model){

        model.addAttribute("user", new User());
        model.addAttribute("roles", roleRepository.findAll());
        model.addAttribute("cinemas", cinemaRepository.findAll());

        return "user_form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute User user, @RequestParam("roleName") String roleName, Model model){

        // Validate user data
        String validationError = userService.validateUser(user);
        if (validationError != null) {
            model.addAttribute("user", user);
            model.addAttribute("roles", roleRepository.findAll());
            model.addAttribute("cinemas", cinemaRepository.findAll());
            model.addAttribute("error", validationError);
            return "user_form";
        }

        // Nếu là update, merge các field cũ
        if(user.getUserId() != null && user.getUserId() > 0){
            User oldUser = userService.findById(user.getUserId());
            // Giữ nguyên avatar và createdAt
            if(user.getAvatar() == null || user.getAvatar().isEmpty()){
                user.setAvatar(oldUser.getAvatar());
            }
            user.setCreatedAt(oldUser.getCreatedAt());
            // Kiểm tra nếu quyền được thay đổi từ CINEMA_ADMIN sang USER hoặc quyền khác
            if (oldUser.getRole() != null && oldUser.getRole().getRoleName().equals("CINEMA_ADMIN")
                    && !roleName.equals("CINEMA_ADMIN")) {
                // Xóa tất cả các liên kết admin (rạp) của người dùng này
                Integer userId = user.getUserId();
                if (userId != null) {
                    adminService.deleteAllAdminsForUser(userId);
                }
            }
        }
        user.setRole(roleRepository.findByRoleName(roleName).orElse(null));
        userService.save(user);

        return "redirect:/superAdmin/users";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model){

        model.addAttribute("user",
                userService.findById(id));

        model.addAttribute("roles",
                roleRepository.findAll());

        model.addAttribute("cinemas",
                cinemaRepository.findAll());

        return "user_form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){

        userService.delete(id);

        return "redirect:/superAdmin/users";
    }

}
