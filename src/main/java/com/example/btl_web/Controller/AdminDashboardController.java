package com.cinemavn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinemavn.Service.ReportService;
import com.cinemavn.Service.SuperAdminCinemaService;
import com.cinemavn.Service.SuperAdminUserService;

@Controller
@RequestMapping("/superAdmin")
public class AdminDashboardController {

    @Autowired
    SuperAdminCinemaService cinemaService;

    @Autowired
    SuperAdminUserService userService;

    @Autowired
    ReportService reportService;

    @GetMapping
    public String dashboard(Model model){

        model.addAttribute("cinemas", cinemaService.findAll());

        model.addAttribute("totalCinemas",
                cinemaService.findAll().size());

        model.addAttribute("totalUsers",
                userService.getAllUsers().size());

        model.addAttribute("totalRevenue",
                reportService.getTotalRevenue());

        return "admin";

    }

}