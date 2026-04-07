package com.example.btl_web.Repository;

import com.example.btl_web.Model.Discount;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface DiscountRepo extends JpaRepository<Discount, Integer> {
    Optional<Discount> findByCode(String code);
}
