package com.example.btl_web.Model;

import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "showtimes")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Showtime {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer showtimeId;

    @ManyToOne
    @JoinColumn(name = "movie_id")
    private Movie movie;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    private LocalDate showDate;
    private LocalTime startTime;
    private LocalTime endTime;
    private BigDecimal price;
    private String status;
}
