package com.example.btl_web.Model;

import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "seat_status")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class SeatStatus {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer seatStatusId;

    @ManyToOne
    @JoinColumn(name = "showtime_id")
    private Showtime showtime;

    @ManyToOne
    @JoinColumn(name = "seat_id")
    private Seat seat;

    private String status; // available, booked, maintenance
}
