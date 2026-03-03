package com.oceanview.controller;

import com.oceanview.dao.BillDAO;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import com.oceanview.service.ReportService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private RoomDAO roomDAO;
    private BillDAO billDAO;
    private ReservationDAO reservationDAO;
    private ReportService reportService;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAO();
        billDAO = new BillDAO();
        reservationDAO = new ReservationDAO();
        reportService = new ReportService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        showReports(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if (startDate == null || startDate.trim().isEmpty() ||
            endDate == null || endDate.trim().isEmpty()) {
            request.setAttribute("dateError",
                "Please select a valid date range.");
            showReports(request, response);
            return;
        }

        if (endDate.compareTo(startDate) < 0) {
            request.setAttribute("dateError",
                "End date must be after start date.");
            showReports(request, response);
            return;
        }

        List<Reservation> dateRangeReservations =
            reportService.getReservationsByDateRange(
                startDate, endDate);
        double dateRangeRevenue =
            reportService.getRevenueByDateRange(
                startDate, endDate);

        request.setAttribute("dateRangeReservations",
            dateRangeReservations);
        request.setAttribute("dateRangeRevenue",
            dateRangeRevenue);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("dateRangeCount",
            dateRangeReservations.size());

        showReports(request, response);
    }

    private void showReports(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        List<Room> occupancyReport =
            roomDAO.getRoomOccupancyReport();
        int totalRooms = roomDAO.getTotalRoomCount();
        int occupiedRooms = roomDAO.getOccupiedRoomCount();
        int availableRooms = totalRooms - occupiedRooms;
        double occupancyRate = totalRooms > 0 ?
            ((double) occupiedRooms / totalRooms) * 100 : 0;

        request.setAttribute("occupancyReport",
            occupancyReport);
        request.setAttribute("totalRooms", totalRooms);
        request.setAttribute("occupiedRooms", occupiedRooms);
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("occupancyRate",
            String.format("%.1f", occupancyRate));

        double totalRevenue = billDAO.getTotalRevenue();
        List<Bill> revenueByType =
            billDAO.getRevenueByRoomType();
        int totalBills = billDAO.getTotalBillCount();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("revenueByType", revenueByType);
        request.setAttribute("totalBills", totalBills);

        int totalReservations =
            reservationDAO.getTotalReservationCount();
        int activeReservations =
            reservationDAO.getActiveReservationCount();

        request.setAttribute("totalReservations",
            totalReservations);
        request.setAttribute("activeReservations",
            activeReservations);

        request.setAttribute("singleAvail",
            roomDAO.getAvailableRoomCount("Single"));
        request.setAttribute("doubleAvail",
            roomDAO.getAvailableRoomCount("Double"));
        request.setAttribute("deluxeAvail",
            roomDAO.getAvailableRoomCount("Deluxe"));
        request.setAttribute("suiteAvail",
            roomDAO.getAvailableRoomCount("Suite"));

        request.getRequestDispatcher("/reports.jsp")
               .forward(request, response);
    }
}