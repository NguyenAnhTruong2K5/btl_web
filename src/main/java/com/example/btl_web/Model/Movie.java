package com.example.btl_web.Model;
import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "movies")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer movieId;

    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    private Integer duration;

    @Column(name= "poster", columnDefinition = "TEXT")
    private String poster;

    private String trailer;

    @Column(name = "release_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")

    private LocalDate releaseDate;
    private String status;

    @Column(updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}