package com.oceanview.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.oceanview.model.Bill;
import com.oceanview.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/bills")
public class BillApiServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationService reservationService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
        gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        String reservationIdStr = request.getParameter("reservationId");

        try {
            if ("revenue".equals(action)) {
                List<Bill> bills = reservationService.getAllBills();
                double totalRevenue = bills.stream()
                    .mapToDouble(Bill::getTotalAmount).sum();

                Map<String, Object> revenue = new HashMap<>();
                revenue.put("totalBills", bills.size());
                revenue.put("totalRevenue", totalRevenue);
                out.print(gson.toJson(revenue));

            } else if (reservationIdStr != null) {
                int reservationId = Integer.parseInt(reservationIdStr);
                Bill bill = reservationService.getBillByReservationId(reservationId);
                if (bill != null) {
                    out.print(gson.toJson(bill));
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    Map<String, String> error = new HashMap<>();
                    error.put("error", "Bill not found");
                    out.print(gson.toJson(error));
                }

            } else {
                List<Bill> bills = reservationService.getAllBills();
                out.print(gson.toJson(bills));
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            out.print(gson.toJson(error));
        }

        out.flush();
    }
}