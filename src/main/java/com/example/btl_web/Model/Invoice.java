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
@Table(name = "invoices")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Invoice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer invoiceId;

    @ManyToOne
    @JoinColumn(name = "booking_id")
    private Booking booking;

    private BigDecimal amount;
    private LocalDateTime createdAt = LocalDateTime.now();
    private String status;
}

