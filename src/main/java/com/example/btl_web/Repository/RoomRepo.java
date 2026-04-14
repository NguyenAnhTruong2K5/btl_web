package com.example.btl_web.Repository;

import com.example.btl_web.Model.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RoomRepo extends JpaRepository<Room, Integer> {
    List<Room> findByRoomNameContainingIgnoreCase(String keyword);
}
