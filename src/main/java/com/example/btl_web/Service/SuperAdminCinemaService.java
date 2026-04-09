package com.cinemavn.Service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

import com.cinemavn.model.Cinema;
import com.cinemavn.repository.CinemaRepository;

@Service
public class SuperAdminCinemaService {

    @Autowired
    CinemaRepository cinemaRepository;

    @Autowired
    AdminService adminService;

    public List<Cinema> findAll(){
        return cinemaRepository.findAll();
    }

    public Cinema findById(@NonNull Integer id){
        return cinemaRepository.findById(id).orElse(null);
    }

    public void save(@NonNull Cinema cinema){
        cinemaRepository.save(cinema);
    }

    public void delete(@NonNull Integer id){
        // Xóa tất cả admin associations trước khi xóa cinema
        // Để tránh foreign key constraint violation
        adminService.deleteAllAdminsForCinema(id);
        cinemaRepository.deleteById(id);
    }

}