package com.example.btl_web.Controller;

import com.example.btl_web.DTO.BookingDTO;
import com.example.btl_web.DTO.InvoiceDTO;
import com.example.btl_web.DTO.PaymentDTO;
import com.example.btl_web.Model.*;
import com.example.btl_web.Repository.*;
import com.example.btl_web.Service.DiscountService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {
    private final BookingRepo bookingRepo;
    private final DiscountRepo discountRepo;
    private final InvoiceRepo invoiceRepo;
    private final PaymentRepo paymentRepo;
    private final TicketRepo ticketRepo;

    private final DiscountService discountService;

    @GetMapping("/{booking_id}/invoice")
    public String openPaymentPage(HttpSession session, Model model, @PathVariable("booking_id") Integer bookingId) {
        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        if (booking == null) {
            return "redirect:/ticket";
        }

        InvoiceDTO invoiceDTO = new InvoiceDTO();
        invoiceDTO.setAmount(booking.getTotalPrice());

        model.addAttribute("invoice_dto", invoiceDTO);
        return "invoice"; // Hiện thông tin thanh toán và nút xác nhận thanh toán
    }

    @PostMapping("/{booking_id}/invoice")
    public String processPayment(HttpSession session, @ModelAttribute("invoice_dto") InvoiceDTO invoiceDTO, Model model, @PathVariable("booking_id") Integer bookingId) {
        String discountCode = invoiceDTO.getDiscountCode();
        if (discountCode == null) {
            model.addAttribute("error_msg", "Vui lòng nhập mã giảm giá!");
            return "invoice";
        }

        if (!discountService.isDiscountAvailable(discountCode)) {
            model.addAttribute("error_msg", "Mã giảm giá không hợp lệ hoặc đã hết hạn, vui lòng nhập lại");
            return "invoice";
        }

        Discount discount = discountRepo.findByCode(discountCode).orElse(null); assert discount != null;
        BookingDiscount bookingDiscount = new BookingDiscount();
        Booking booking = bookingRepo.findById(bookingId).orElse(null); assert booking != null;

        BigDecimal currPrice = booking.getTotalPrice();
        BigDecimal discountPercent = BigDecimal.valueOf(discount.getDiscountPercent());
        BigDecimal priceAfterDiscount = currPrice.multiply(
                BigDecimal.ONE.subtract(discountPercent.divide(BigDecimal.valueOf(100)))
        );

        booking.setTotalPrice(priceAfterDiscount);
        bookingDiscount.setDiscount(discount);
        bookingDiscount.setBooking(booking);

        Invoice invoice = new Invoice();
        invoice.setAmount(invoiceDTO.getAmount());
        invoice.setBooking(booking);
        invoiceRepo.save(invoice);

        Payment payment = new Payment();
        payment.setBooking(booking);
        paymentRepo.save(payment);
        invoice.setStatus("Đã thanh toán");

        Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null);
        assert ticket != null;
        ticket.setVerified(true);

        return "redirect:/payment/history";
    }

    @GetMapping("/cancel")
    public String cancelThePayment(HttpSession session) {
        BookingDTO currBooking = (BookingDTO) session.getAttribute("current_booking");
        if (currBooking == null) {
            return "redirect:/"; // Trang chủ người dùng
        }

        Booking booking = bookingRepo.findById(currBooking.getBookingId()).orElse(null);
        if (booking == null) {
            return "redirect:/";
        }

        bookingRepo.delete(booking);
        return "redirect:/";
    }

    @GetMapping("/history")
    public String viewPaymentHistory(HttpSession session, Model model) {
        User currUser = (User) session.getAttribute("currentUser");
        if (currUser == null) {
            return "redirect:/login";
        }

        List<Booking> bookingList = bookingRepo.findByUser_UserId(currUser.getUserId());
        List<PaymentDTO> paymentDTOList = new ArrayList<>();

        for (Booking booking : bookingList) {
            Integer bookingId = booking.getBookingId();
            Payment payment = paymentRepo.findByBooking_BookingId(bookingId).orElse(null);

            if (payment == null) {
                continue;
            }

            Invoice invoice = invoiceRepo.findByBooking_BookingId(bookingId).orElse(null); assert invoice != null;
            Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null); assert ticket != null;

            PaymentDTO paymentDTO = new PaymentDTO();
            paymentDTO.setInvoiceId(invoice.getInvoiceId());
            paymentDTO.setTicketId(ticket.getTicketId());
            paymentDTO.setPaymentId(payment.getPaymentId());

            paymentDTOList.add(paymentDTO);
        }

        model.addAttribute("payment_list", paymentDTOList);
        return "payment-history";
    }
}
