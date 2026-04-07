package com.example.btl_web.DTO;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Getter
@Setter
@RequiredArgsConstructor
public class TicketDTO {
    private LocalDateTime createAt;
    private boolean verified;
    private String movieName;
    private String cinemaName;
    private List<String> seatList;
    private String roomName;
    private LocalDate showDate;
    private LocalTime startTime;
    private LocalTime endTime;
}
