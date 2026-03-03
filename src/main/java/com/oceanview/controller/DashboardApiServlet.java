package com.oceanview.controller;

import com.google.gson.Gson;
import com.oceanview.service.ReportService;
import com.oceanview.service.RoomService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

/**
 * DashboardApiServlet - REST API for Dashboard Statistics
 * URL: /api/dashboard
 * Returns live hotel statistics as JSON
 * Used for real-time dashboard updates via AJAX
 * Part of Distributed Application requirement
 */
@WebServlet("/api/dashboard")
public class DashboardApiServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReportService reportService;
    private RoomService roomService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        reportService = new ReportService();
        roomService = new RoomService();
        gson = new Gson();
    }

    /**
     * GET - Returns dashboard statistics as JSON
     * /api/dashboard - Get all stats
     * /api/dashboard?action=rooms - Room availability only
     * /api/dashboard?action=revenue - Revenue only
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        try {
            if ("rooms".equals(action)) {
                // Room availability counts only
                Map<String, Integer> rooms = new HashMap<>();
                rooms.put("single",
                    roomService.getAvailableRoomCount("Single"));
                rooms.put("double",
                    roomService.getAvailableRoomCount("Double"));
                rooms.put("deluxe",
                    roomService.getAvailableRoomCount("Deluxe"));
                rooms.put("suite",
                    roomService.getAvailableRoomCount("Suite"));
                rooms.put("totalAvailable",
                    roomService.getAvailableRoomCount("Single") +
                    roomService.getAvailableRoomCount("Double") +
                    roomService.getAvailableRoomCount("Deluxe") +
                    roomService.getAvailableRoomCount("Suite"));

                out.print(gson.toJson(rooms));

            } else if ("revenue".equals(action)) {
                // Revenue stats only
                Map<String, Object> revenue = new HashMap<>();
                revenue.put("totalRevenue",
                    reportService.getTotalRevenue());
                revenue.put("totalBills",
                    reportService.getTotalBillCount());

                out.print(gson.toJson(revenue));

            } else {
                // Full dashboard stats
                Map<String, Object> stats = new HashMap<>();

                // Room stats
                int totalRooms = reportService.getTotalRoomCount();
                int occupiedRooms =
                    reportService.getOccupiedRoomCount();
                int availableRooms = totalRooms - occupiedRooms;
                double occupancyRate = totalRooms > 0 ?
                    ((double) occupiedRooms / totalRooms) * 100 : 0;

                stats.put("totalRooms", totalRooms);
                stats.put("occupiedRooms", occupiedRooms);
                stats.put("availableRooms", availableRooms);
                stats.put("occupancyRate",
                    Math.round(occupancyRate * 10.0) / 10.0);

                // Room availability by type
                stats.put("singleAvail",
                    roomService.getAvailableRoomCount("Single"));
                stats.put("doubleAvail",
                    roomService.getAvailableRoomCount("Double"));
                stats.put("deluxeAvail",
                    roomService.getAvailableRoomCount("Deluxe"));
                stats.put("suiteAvail",
                    roomService.getAvailableRoomCount("Suite"));

                // Reservation stats
                stats.put("totalReservations",
                    reportService.getTotalReservationCount());
                stats.put("activeReservations",
                    reportService.getActiveReservationCount());

                // Revenue stats
                stats.put("totalRevenue",
                    reportService.getTotalRevenue());
                stats.put("totalBills",
                    reportService.getTotalBillCount());

                out.print(gson.toJson(stats));
            }

            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            response.setStatus(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            Map<String, String> error = new HashMap<>();
            error.put("error", "Internal server error: "
                + e.getMessage());
            out.print(gson.toJson(error));
        }

        out.flush();
    }
}