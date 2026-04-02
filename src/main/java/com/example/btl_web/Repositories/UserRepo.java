package com.example.btl_web.Repositories;

import com.example.btl_web.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Integer> {
}
