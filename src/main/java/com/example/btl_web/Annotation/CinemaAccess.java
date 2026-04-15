package com.example.btl_web.Annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Annotation để kiểm tra quyền truy cập cinema
 * Sử dụng trong method param của controller để tự động kiểm tra authorization
 * 
 * Ví dụ:
 * @GetMapping("/rooms/{cinemaId}")
 * public String getRooms(@CinemaAccess @PathVariable Integer cinemaId) { ... }
 */
@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface CinemaAccess {
    /**
     * Tên param chứa cinema_id (default là tên parameter)
     */
    String paramName() default "";
}
