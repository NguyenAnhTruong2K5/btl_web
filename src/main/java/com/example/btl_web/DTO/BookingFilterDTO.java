package com.example.btl_web.DTO;

import lombok.Getter;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;

@Getter
@Setter
public class BookingFilterDTO {
    private Integer cinemaId;
    private Integer movieId;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate showDate;

    private String bookingStatus;
}