package com.example.btl_web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.btl_web.Repository.InvoiceRepo;
import com.example.btl_web.Repository.PaymentRepo;

@Service
public class ReportService {

    @Autowired
    InvoiceRepo invoiceRepository;

    @Autowired
    PaymentRepo paymentRepo;

    public Double getTotalRevenue() {
        Double revenue = invoiceRepository.totalRevenue();
        return revenue != null ? revenue : 0.0;
    }

    public Long getTotalTicketsSold() {
        return paymentRepo.count();
    }

    // Lấy doanh thu theo ngày
    public List<Map<String, Object>> getRevenueByDay() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = invoiceRepository.getRevenueByDay();

        for (Object[] row : data) {
            Map<String, Object> map = new HashMap<>();
            map.put("date", row[0]);
            map.put("revenue", row[1] != null ? row[1] : 0.0);
            result.add(map);
        }
        return result;
    }

    // Lấy doanh thu theo tháng
    public List<Map<String, Object>> getRevenueByMonth() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = invoiceRepository.getRevenueByMonth();

        for (Object[] row : data) {
            Map<String, Object> map = new HashMap<>();
            map.put("year", row[0]);
            map.put("month", row[1]);
            map.put("revenue", row[2] != null ? row[2] : 0.0);
            result.add(map);
        }
        return result;
    }

    // Lấy doanh thu theo năm
    public List<Map<String, Object>> getRevenueByYear() {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = invoiceRepository.getRevenueByYear();

        for (Object[] row : data) {
            Map<String, Object> map = new HashMap<>();
            map.put("year", row[0]);
            map.put("revenue", row[1] != null ? row[1] : 0.0);
            result.add(map);
        }
        return result;
    }

    // Lấy doanh thu trong khoảng thời gian
    public List<Map<String, Object>> getRevenueByDateRange(String startDate, String endDate) {
        List<Map<String, Object>> result = new ArrayList<>();
        List<Object[]> data = invoiceRepository.getRevenueByDateRange(startDate, endDate);

        for (Object[] row : data) {
            Map<String, Object> map = new HashMap<>();
            map.put("date", row[0]);
            map.put("revenue", row[1] != null ? row[1] : 0.0);
            result.add(map);
        }
        return result;
    }

}
