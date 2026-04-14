package com.example.btl_web.DTO;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@RequiredArgsConstructor
public class PaymentDTO {
    private LocalDateTime paymentTime;
    private Integer paymentId;
    private Integer invoiceId;
    private Integer ticketId;
    private Integer bookingId;
}
