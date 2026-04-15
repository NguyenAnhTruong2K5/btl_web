package com.example.btl_web.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.btl_web.Model.Invoice;

public interface InvoiceRepo extends JpaRepository<Invoice, Integer> {

    Optional<Invoice> findByBooking_BookingId(Integer bookingId);

    void deleteByBooking_BookingId(Integer bookingId);

    @Query("SELECT SUM(i.amount) FROM Invoice i JOIN Payment p ON p.booking = i.booking")
    Double totalRevenue();

    // Lấy doanh thu theo ngày
    @Query(value = "SELECT DATE(i.invoice_date) as date, SUM(i.amount) as revenue "
            + "FROM invoices i INNER JOIN payments p ON p.booking_id = i.booking_id "
            + "GROUP BY DATE(i.invoice_date) "
            + "ORDER BY date DESC", nativeQuery = true)
    List<Object[]> getRevenueByDay();

    // Lấy doanh thu theo tháng
    @Query(value = "SELECT YEAR(i.invoice_date) as year, MONTH(i.invoice_date) as month, SUM(i.amount) as revenue "
            + "FROM invoices i INNER JOIN payments p ON p.booking_id = i.booking_id "
            + "GROUP BY YEAR(i.invoice_date), MONTH(i.invoice_date) "
            + "ORDER BY year DESC, month DESC", nativeQuery = true)
    List<Object[]> getRevenueByMonth();

    // Lấy doanh thu theo năm
    @Query(value = "SELECT YEAR(i.invoice_date) as year, SUM(i.amount) as revenue "
            + "FROM invoices i INNER JOIN payments p ON p.booking_id = i.booking_id "
            + "GROUP BY YEAR(i.invoice_date) "
            + "ORDER BY year DESC", nativeQuery = true)
    List<Object[]> getRevenueByYear();

    // Lấy doanh thu trong khoảng thời gian cụ thể
    @Query(value = "SELECT DATE(i.invoice_date) as date, SUM(i.amount) as revenue "
            + "FROM invoices i INNER JOIN payments p ON p.booking_id = i.booking_id "
            + "AND DATE(i.invoice_date) BETWEEN :startDate AND :endDate "
            + "GROUP BY DATE(i.invoice_date) "
            + "ORDER BY date DESC", nativeQuery = true)
    List<Object[]> getRevenueByDateRange(@Param("startDate") String startDate, @Param("endDate") String endDate);

}
