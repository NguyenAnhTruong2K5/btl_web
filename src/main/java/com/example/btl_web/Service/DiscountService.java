package com.example.btl_web.Service;

import com.example.btl_web.Model.Discount;
import com.example.btl_web.Repository.DiscountRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class DiscountService {
    private final DiscountRepo discountRepo;
    public boolean isDiscountAvailable(String code) {
        Discount discount = discountRepo.findByCode(code).orElse(null);
        if (discount == null) {
            return false;
        }

        return !discount.getEndDate().isBefore(LocalDate.now());
    }
}
