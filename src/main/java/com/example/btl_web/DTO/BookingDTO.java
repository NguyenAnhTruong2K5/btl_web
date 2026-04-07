package com.example.btl_web.DTO;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@RequiredArgsConstructor

public class BookingDTO {
    private Integer bookingId;
    private Integer movieId;
    private Integer roomId;
    private Integer userId;
    private Integer cinemaId;
    private Integer showTimeId;
    private List<Integer> seatIdList;
}
