package com.example.btl_web.DTO;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
@RequiredArgsConstructor
public class InvoiceDTO {
    private BigDecimal amount;
    private String discountCode;
}
