package com.cinemavn.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cinemavn.model.Cinema;

@Repository
public interface CinemaRepository extends JpaRepository<Cinema, Integer> {
}
