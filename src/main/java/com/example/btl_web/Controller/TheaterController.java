package com.cinemavn.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinemavn.Service.SuperAdminCinemaService;
import com.cinemavn.model.Cinema;

@Controller
@RequestMapping("/superAdmin/theaters")
public class TheaterController {

    @Autowired
    SuperAdminCinemaService cinemaService;

    @GetMapping
    public String list(Model model){

        model.addAttribute("cinemas",
                cinemaService.findAll());

        return "theaters_management";
    }

    @GetMapping("/create")
    public String create(Model model){

        model.addAttribute("cinema", new Cinema());

        return "theater_form";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Cinema cinema){

        // Nếu là update, merge các field cũ
        if(cinema.getCinemaId() != null && cinema.getCinemaId() > 0){
            Cinema oldCinema = cinemaService.findById(cinema.getCinemaId());
            
            // Giữ nguyên những field không được submit
            if(cinema.getPhone() == null || cinema.getPhone().isEmpty()){
                cinema.setPhone(oldCinema.getPhone());
            }
            if(cinema.getRating() == null){
                cinema.setRating(oldCinema.getRating());
            }
        }

        cinemaService.save(cinema);

        return "redirect:/superAdmin/theaters";
    }

    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, Model model){

        model.addAttribute("cinema",
                cinemaService.findById(id));

        return "theater_form";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id){

        cinemaService.delete(id);

        return "redirect:/superAdmin/theaters";
    }

}
