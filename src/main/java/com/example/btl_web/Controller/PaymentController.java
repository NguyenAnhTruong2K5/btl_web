package com.example.btl_web.Controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.btl_web.DTO.InvoiceDTO;
import com.example.btl_web.DTO.PaymentDTO;
import com.example.btl_web.Model.Booking;
import com.example.btl_web.Model.BookingDiscount;
import com.example.btl_web.Model.Discount;
import com.example.btl_web.Model.Invoice;
import com.example.btl_web.Model.Payment;
import com.example.btl_web.Model.Ticket;
import com.example.btl_web.Model.User;
import com.example.btl_web.Repository.BookingDiscountRepo;
import com.example.btl_web.Repository.BookingRepo;
import com.example.btl_web.Repository.DiscountRepo;
import com.example.btl_web.Repository.InvoiceRepo;
import com.example.btl_web.Repository.PaymentRepo;
import com.example.btl_web.Repository.TicketRepo;
import com.example.btl_web.Service.DiscountService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/payment")
public class PaymentController {

    private final BookingRepo bookingRepo;
    private final DiscountRepo discountRepo;
    private final InvoiceRepo invoiceRepo;
    private final PaymentRepo paymentRepo;
    private final TicketRepo ticketRepo;
    private final BookingDiscountRepo bookingDiscountRepo;

    private final DiscountService discountService;

    @GetMapping("/{booking_id}/invoice")
    public String openPaymentPage(HttpSession session, Model model, @PathVariable("booking_id") Integer bookingId) {
        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        if (booking == null) {
            return "redirect:/ticket";
        }

        booking.setBookingStatus("PENDING");
        bookingRepo.save(booking);

        InvoiceDTO invoiceDTO = new InvoiceDTO();
        invoiceDTO.setAmount(booking.getTotalPrice());
        invoiceDTO.setBookingId(bookingId);

        model.addAttribute("invoice_dto", invoiceDTO);
        model.addAttribute("booking_id", bookingId);

        Payment payment = paymentRepo.findByBooking_BookingId(bookingId).orElse(null);
        if (payment != null) {
            BookingDiscount bookingDiscount = bookingDiscountRepo.findByBooking_BookingId(bookingId).orElse(null);
            if (bookingDiscount != null) {
                invoiceDTO.setDiscountCode(bookingDiscount.getDiscount().getCode());
            }

            Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null);
            if (ticket != null) {
                model.addAttribute("is_verified", ticket.getVerified());
            }
            model.addAttribute("invoice_dto", invoiceDTO);
            return "invoice";
        }

        return "booking-invoice"; // Hiện thông tin thanh toán và nút thanh toán ngay hoặc thanh toán sau
    }

    @PostMapping("/{booking_id}/invoice")
    public String processPayment(HttpSession session, @ModelAttribute("invoice_dto") InvoiceDTO invoiceDTO, Model model, @PathVariable("booking_id") Integer bookingId, @RequestParam("action") String action) {
        String discountCode = invoiceDTO.getDiscountCode();
        Booking booking = bookingRepo.findById(bookingId).orElse(null);
        assert booking != null;

        if (action.equals("apply_discount")) {
            if (discountCode == null || !discountService.isDiscountAvailable(discountCode.trim())) {
                invoiceDTO.setAmount(booking.getTotalPrice());
                model.addAttribute("error_msg", "Mã giảm giá không hợp lệ hoặc đã hết hạn, vui lòng nhập lại");
                return "invoice";
            }

            if (discountService.isDiscountAvailable(discountCode.trim())) {
                Discount discount = discountRepo.findByCode(discountCode).orElse(null);
                assert discount != null;
                BookingDiscount bookingDiscount = new BookingDiscount();
                BigDecimal currPrice = booking.getTotalPrice();
                BigDecimal discountPercent = BigDecimal.valueOf(discount.getDiscountPercent());
                BigDecimal priceAfterDiscount = currPrice.multiply(
                        BigDecimal.ONE.subtract(discountPercent.divide(BigDecimal.valueOf(100)))
                );

                booking.setTotalPrice(priceAfterDiscount);
                bookingRepo.save(booking);

                bookingDiscount.setDiscount(discount);
                bookingDiscount.setBooking(booking);
                bookingDiscountRepo.save(bookingDiscount);

                invoiceDTO.setAmount(priceAfterDiscount);
                model.addAttribute("success_msg", "Áp dụng mã giảm giá thành công!");
                return "booking-invoice";
            }
        }

        if (action.equals("pay_now")) {
            if (discountCode != null) {
                if (discountService.isDiscountAvailable(discountCode.trim())) {
                    Discount discount = discountRepo.findByCode(discountCode).orElse(null);
                    assert discount != null;
                    BookingDiscount bookingDiscount = new BookingDiscount();
                    BigDecimal currPrice = booking.getTotalPrice();
                    BigDecimal discountPercent = BigDecimal.valueOf(discount.getDiscountPercent());
                    BigDecimal priceAfterDiscount = currPrice.multiply(
                            BigDecimal.ONE.subtract(discountPercent.divide(BigDecimal.valueOf(100)))
                    );

                    booking.setTotalPrice(priceAfterDiscount);
                    bookingRepo.save(booking);

                    bookingDiscount.setDiscount(discount);
                    bookingDiscount.setBooking(booking);
                    bookingDiscountRepo.save(bookingDiscount);
                }
            }

            Invoice invoice = new Invoice();
            invoice.setAmount(invoiceDTO.getAmount());
            invoice.setStatus("PAID");
            invoice.setBooking(booking);
            invoiceRepo.save(invoice);

            Payment payment = new Payment();
            payment.setPaymentStatus("PAID");
            payment.setBooking(booking);
            paymentRepo.save(payment);

            Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null);
            if (ticket != null) {
                ticketRepo.save(ticket);
            }
        }

        return "redirect:/payment/history";
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

            Invoice invoice = invoiceRepo.findByBooking_BookingId(bookingId).orElse(null);
            Ticket ticket = ticketRepo.findByBooking_BookingId(bookingId).orElse(null);

            if (invoice != null && ticket != null) {
                PaymentDTO paymentDTO = new PaymentDTO();
                paymentDTO.setInvoiceId(invoice.getInvoiceId());
                paymentDTO.setTicketId(ticket.getTicketId());
                paymentDTO.setPaymentId(payment.getPaymentId());
                paymentDTO.setBookingId(bookingId);
                paymentDTO.setPaymentTime(payment.getPaymentTime());

                paymentDTOList.add(paymentDTO);
            }
        }

        model.addAttribute("payment_list", paymentDTOList);
        return "payment-history";
    }
}
