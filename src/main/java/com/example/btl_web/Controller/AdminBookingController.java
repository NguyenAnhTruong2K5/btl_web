package com.example.btl_web.Controller;

import com.example.btl_web.DTO.BookingFilterDTO;
import com.example.btl_web.Model.*;
import com.example.btl_web.Repository.*;
import com.example.btl_web.Service.AdminBookingService;
import com.example.btl_web.Service.EmailService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/bookings")
public class AdminBookingController {

    private final AdminBookingService adminBookingService;
    private final CinemaRepo cinemaRepo;
    private final MovieRepo movieRepo;
    private final AdminRepo adminRepo;
    private final EmailService emailService;
    private final PaymentRepo paymentRepo;
    private final BookingRepo bookingRepo;
    private final TicketRepo ticketRepo;
    @GetMapping
    public String showBookingList(@ModelAttribute("filter") BookingFilterDTO filterDTO,
                                  Model model,
                                  RedirectAttributes redirectAttributes,
                                  HttpSession session) {
        User currentUser = getCurrentUser(session);
        if (currentUser == null) {
            return "redirect:/login";
        }

        if (!isAdminCinema(currentUser)) {
            return "redirect:/login";
        }

        try {
            Integer managedCinemaId = getManagedCinemaId(currentUser);
            if (managedCinemaId == null) {
                redirectAttributes.addFlashAttribute("errorMsg", "Tài khoản admin chưa được gán rạp.");
                return "redirect:/login";
            }

            filterDTO.setCinemaId(managedCinemaId);

            List<Booking> bookings = adminBookingService.filterBookingsForCinemaAdmin(filterDTO, managedCinemaId);
            Cinema cinema = cinemaRepo.findById(managedCinemaId).orElse(null);
            List<Cinema> cinemas = cinema != null ? List.of(cinema) : Collections.emptyList();
            List<Movie> movies = movieRepo.findAll();

            model.addAttribute("bookings", bookings);
            model.addAttribute("cinemas", cinemas);
            model.addAttribute("movies", movies);
            model.addAttribute("filter", filterDTO);

            return "booking-list";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMsg", e.getMessage());
            return "redirect:/admin/bookings";
        }
    }

    @GetMapping("/{id}")
    public String showBookingDetail(@PathVariable("id") Integer id,
                                    Model model,
                                    RedirectAttributes redirectAttributes,
                                    HttpSession session) {
        User currentUser = getCurrentUser(session);
        if (currentUser == null) {
            return "redirect:/login";
        }

        if (!isAdminCinema(currentUser)) {
            return "redirect:/login";
        }

        Integer managedCinemaId = getManagedCinemaId(currentUser);
        if (managedCinemaId == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Tài khoản admin chưa được gán rạp.");
            return "redirect:/login";
        }

        Booking booking = adminBookingService.getBookingByIdForCinemaAdmin(id, managedCinemaId);
        if (booking == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Không tìm thấy booking hoặc bạn không có quyền truy cập.");
            return "redirect:/admin/bookings";
        }

        Payment payment = paymentRepo.findByBooking_BookingId(id).orElse(null);

        model.addAttribute("booking", booking);
        model.addAttribute("payment", payment);
        return "booking-detail";
    }

    @PostMapping("/{id}/confirm")
    public String confirmBooking(@PathVariable("id") Integer id,
                                 RedirectAttributes redirectAttributes,
                                 HttpSession session) {
        if (!canAccessBooking(id, session)) {
            return "redirect:/login";
        }

        Booking booking = adminBookingService.getBookingByIdForCinemaAdmin(
                id, getManagedCinemaId(getCurrentUser(session))
        );
        if (booking == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Không tìm thấy booking.");
            return "redirect:/admin/bookings";
        }

        adminBookingService.confirmBookingAndVerifyTicket(booking);

        redirectAttributes.addFlashAttribute("successMsg",
                "Xác nhận đơn vé thành công, ticket đã được verified.");
        return "redirect:/admin/bookings/" + id;
    }

    @PostMapping("/{id}/cancel")
    public String cancelBooking(@PathVariable("id") Integer id,
                                RedirectAttributes redirectAttributes,
                                HttpSession session) {
        if (!canAccessBooking(id, session)) {
            return "redirect:/login";
        }

        Booking booking = adminBookingService.getBookingByIdForCinemaAdmin(
                id, getManagedCinemaId(getCurrentUser(session))
        );

        if (booking == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Không tìm thấy booking.");
            return "redirect:/admin/bookings";
        }

        adminBookingService.cancelBookingAndUnverifyTicket(booking);

        redirectAttributes.addFlashAttribute("successMsg",
                "Hủy đơn vé thành công, ticket đã được bỏ verified.");
        return "redirect:/admin/bookings/" + id;
    }

    @PostMapping("/{id}/send-mail")
    public String sendMailOnly(@PathVariable("id") Integer id,
                               RedirectAttributes redirectAttributes,
                               HttpSession session) {
        if (!canAccessBooking(id, session)) {
            return "redirect:/login";
        }

        Booking booking = adminBookingService.getBookingByIdForCinemaAdmin(
                id, getManagedCinemaId(getCurrentUser(session))
        );
        if (booking == null) {
            redirectAttributes.addFlashAttribute("errorMsg", "Không tìm thấy booking.");
            return "redirect:/admin/bookings";
        }

        try {
            String status = booking.getBookingStatus();

            if ("CONFIRMED".equalsIgnoreCase(status)) {
                emailService.sendBookingConfirmation(booking);
            } else if ("CANCELED".equalsIgnoreCase(status)) {
                emailService.sendBookingCancelEmail(booking);
            } else {
                redirectAttributes.addFlashAttribute("errorMsg",
                        "Chỉ gửi mail khi booking ở trạng thái CONFIRMED hoặc CANCELED.");
                return "redirect:/admin/bookings/" + id;
            }

            redirectAttributes.addFlashAttribute("successMsg", "Gửi mail thành công.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMsg", "Gửi mail thất bại: " + e.getMessage());
        }

        return "redirect:/admin/bookings/" + id;
    }

    private boolean canAccessBooking(Integer bookingId, HttpSession session) {
        User currentUser = getCurrentUser(session);
        if (currentUser == null) {
            return false;
        }

        if (!isAdminCinema(currentUser)) {
            return false;
        }

        Integer managedCinemaId = getManagedCinemaId(currentUser);
        if (managedCinemaId == null) {
            return false;
        }

        return adminBookingService.bookingBelongsToCinema(bookingId, managedCinemaId);
    }

    private User getCurrentUser(HttpSession session) {
        Object obj = session.getAttribute("currentUser");
        if (obj instanceof User) {
            return (User) obj;
        }
        return null;
    }

    private boolean isAdminCinema(User user) {
        String roleName = getRoleName(user);
        return "ADMIN_CINEMA".equalsIgnoreCase(roleName)
                || "CINEMA_ADMIN".equalsIgnoreCase(roleName)
                || "ADMINCINEMA".equalsIgnoreCase(roleName);
    }

    private String getRoleName(User user) {
        if (user == null || user.getRole() == null || user.getRole().getRoleName() == null) {
            return "";
        }
        return user.getRole().getRoleName().trim();
    }

    private Integer getManagedCinemaId(User currentUser) {
        Optional<Admin> adminOpt = adminRepo.findByUserUserId(currentUser.getUserId());
        if (adminOpt.isEmpty()) {
            return null;
        }

        Admin admin = adminOpt.get();
        if (admin.getCinema() == null) {
            return null;
        }

        return admin.getCinema().getCinemaId();
    }

}