package com.example.btl_web.Model;
import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
@Entity
@Table(name = "cinemas")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Cinema {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer cinemaId;

    private String cinemaName;
    private String address;
    private String city;
    private String phone;
    private String brand;
    private Double rating;

    @Column(name = "image_url", columnDefinition = "TEXT")
    private String imageUrl;
    @Column(updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();
}
