package com.example.btl_web.Model;

import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "discounts")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Discount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer discountId;

    private String code;
    private Integer discountPercent;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;
}
