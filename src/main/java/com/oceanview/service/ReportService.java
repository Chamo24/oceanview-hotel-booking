package com.oceanview.service;

import com.oceanview.dao.BillDAO;
import com.oceanview.dao.DAOFactory;
import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.model.Room;
import java.util.ArrayList;
import java.util.List;

/**
 * ReportService - Business logic for generating reports
 * Provides data for management decision-making
 * Part of the 3-Tier Architecture (Business Logic Layer)
 */
public class ReportService {

    private RoomDAO roomDAO;
    private BillDAO billDAO;
    private ReservationDAO reservationDAO;

    public ReportService() {
        this.roomDAO = DAOFactory.createRoomDAO();
        this.billDAO = DAOFactory.createBillDAO();
        this.reservationDAO = DAOFactory.createReservationDAO();
    }

    public List<Room> getRoomOccupancyReport() {
        return roomDAO.getRoomOccupancyReport();
    }

    public int getTotalRoomCount() {
        return roomDAO.getTotalRoomCount();
    }

    public int getOccupiedRoomCount() {
        return roomDAO.getOccupiedRoomCount();
    }

    public double getTotalRevenue() {
        return billDAO.getTotalRevenue();
    }

    public List<Bill> getRevenueByRoomType() {
        return billDAO.getRevenueByRoomType();
    }

    public int getTotalBillCount() {
        return billDAO.getTotalBillCount();
    }

    public int getTotalReservationCount() {
        return reservationDAO.getTotalReservationCount();
    }

    public int getActiveReservationCount() {
        return reservationDAO.getActiveReservationCount();
    }

    public int getAvailableRoomCount(String roomType) {
        return roomDAO.getAvailableRoomCount(roomType);
    }

    public List<Reservation> getReservationsByDateRange(
            String startDate, String endDate) {
        if (startDate == null || startDate.trim().isEmpty()) {
            return new ArrayList<>();
        }
        if (endDate == null || endDate.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return reservationDAO.getReservationsByDateRange(
            startDate, endDate);
    }

    public double getRevenueByDateRange(
            String startDate, String endDate) {
        if (startDate == null || startDate.trim().isEmpty()) {
            return 0;
        }
        if (endDate == null || endDate.trim().isEmpty()) {
            return 0;
        }
        return reservationDAO.getRevenueByDateRange(
            startDate, endDate);
    }
}