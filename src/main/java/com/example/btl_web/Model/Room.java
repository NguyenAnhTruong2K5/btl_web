package com.example.btl_web.Model;

import javax.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "rooms")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
public class Room {
    @Id
    private Integer roomId;

    @ManyToOne
    @JoinColumn(name = "cinema_id")
    private Cinema cinema;

    private String roomName;
    private Integer totalSeats;
}
