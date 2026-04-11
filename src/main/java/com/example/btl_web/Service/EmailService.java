package com.example.btl_web.Service;

import com.example.btl_web.Model.Booking;
import com.example.btl_web.Model.EmailLog;
import com.example.btl_web.Model.Showtime;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.EmailLogRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender mailSender;
    private final EmailLogRepo emailLogRepository;

    @Value("${spring.mail.username}")
    private String fromEmail;

    public void sendBookingConfirmation(Booking booking) {
        if (booking == null) {
            throw new RuntimeException("Booking đang null.");
        }

        User user = booking.getUser();
        if (user == null) {
            throw new RuntimeException("Booking chưa có user.");
        }

        String to = user.getEmail();
        String subject = "Xác nhận đơn đặt vé #" + booking.getBookingId();
        String content = buildConfirmationContent(booking);

        sendRealEmailAndSaveLog(user, booking, to, subject, content);
    }

    public void sendBookingCancelEmail(Booking booking) {
        if (booking == null) {
            throw new RuntimeException("Booking đang null.");
        }

        User user = booking.getUser();
        if (user == null) {
            throw new RuntimeException("Booking chưa có user.");
        }

        String to = user.getEmail();
        String subject = "Thông báo hủy đơn đặt vé #" + booking.getBookingId();
        String content = buildCancelContent(booking);

        sendRealEmailAndSaveLog(user, booking, to, subject, content);
    }
    private String formatShowtime(Booking booking) {
        if (booking == null || booking.getShowtime() == null) {
            return "N/A";
        }

        Showtime showtime = booking.getShowtime();

        String showDate = showtime.getShowDate() != null ? showtime.getShowDate().toString() : "N/A";
        String startTime = showtime.getStartTime() != null ? showtime.getStartTime().toString() : "N/A";
        String endTime = showtime.getEndTime() != null ? showtime.getEndTime().toString() : "N/A";

        return showDate + " " + startTime + " - " + endTime;
    }
    private void sendRealEmailAndSaveLog(User user, Booking booking, String to, String subject, String content) {
        EmailLog emailLog = new EmailLog();
        emailLog.setUser(user);
        emailLog.setBooking(booking);
        emailLog.setEmail(to);
        emailLog.setSubject(subject);
        emailLog.setContent(content);

        try {
            if (to == null || to.trim().isEmpty()) {
                throw new RuntimeException("Email người nhận đang trống.");
            }

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(content);

            mailSender.send(message);

            emailLog.setStatus("SENT");
            emailLogRepository.save(emailLog);

        } catch (Exception e) {
            emailLog.setStatus("FAILED");
            emailLogRepository.save(emailLog);

            throw new RuntimeException("Gửi mail thất bại: " + e.getMessage(), e);
        }
    }

    private String buildConfirmationContent(Booking booking) {
        String movieName = "N/A";
        String showtimeText = formatShowtime(booking);

        if (booking.getShowtime() != null && booking.getShowtime().getMovie() != null) {
            movieName = booking.getShowtime().getMovie().getTitle();
        }

        return "Xin chào,\n\n"
                + "Đơn đặt vé của bạn đã được xác nhận thành công.\n\n"
                + "Mã booking: " + booking.getBookingId() + "\n"
                + "Phim: " + movieName + "\n"
                + "Suất chiếu: " + showtimeText + "\n"
                + "Trạng thái: " + booking.getBookingStatus() + "\n\n"
                + "Cảm ơn bạn đã sử dụng dịch vụ.";
    }

    private String buildCancelContent(Booking booking) {
        String movieName = "N/A";
        String showtimeText = formatShowtime(booking);

        if (booking.getShowtime() != null && booking.getShowtime().getMovie() != null) {
            movieName = booking.getShowtime().getMovie().getTitle();
        }

        return "Xin chào,\n\n"
                + "Đơn đặt vé của bạn đã bị hủy.\n\n"
                + "Mã booking: " + booking.getBookingId() + "\n"
                + "Phim: " + movieName + "\n"
                + "Suất chiếu: " + showtimeText + "\n"
                + "Trạng thái: " + booking.getBookingStatus() + "\n\n"
                + "Nếu cần hỗ trợ thêm, vui lòng liên hệ hệ hotline: 19002005.";
    }
}