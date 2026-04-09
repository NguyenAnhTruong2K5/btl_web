package com.cinemavn.controller;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cinemavn.Service.ReportService;

@Controller
@RequestMapping("/superAdmin/reports")
public class ReportController {

    @Autowired
    ReportService reportService;

    @GetMapping
    public String report(Model model){

        model.addAttribute("totalRevenue",
                reportService.getTotalRevenue());
        model.addAttribute("revenueByDay", reportService.getRevenueByDay());
        model.addAttribute("revenueByMonth", reportService.getRevenueByMonth());
        model.addAttribute("revenueByYear", reportService.getRevenueByYear());

        return "report";
    }

    @GetMapping("/export")
    public void export(HttpServletResponse response) throws Exception{

        try (Workbook workbook = new XSSFWorkbook()) {

            Sheet sheet = workbook.createSheet("Revenue");

            Row row = sheet.createRow(0);

            row.createCell(0).setCellValue("Total Revenue");

            row.createCell(1).setCellValue(reportService.getTotalRevenue());

            response.setContentType("application/octet-stream");

            response.setHeader("Content-Disposition",
                    "attachment; filename=report.xlsx");

            workbook.write(response.getOutputStream());
        }
    }
}