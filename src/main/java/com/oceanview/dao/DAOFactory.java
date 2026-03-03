package com.oceanview.dao;

/**
 * DAOFactory - Factory Design Pattern
 * Centralizes the creation of all DAO objects.
 * This ensures that object creation logic is in 
 * one place, making the code easier to maintain 
 * and modify.
 */
public class DAOFactory {

    public static UserDAO createUserDAO() {
        return new UserDAO();
    }

    public static RoomDAO createRoomDAO() {
        return new RoomDAO();
    }

    public static ReservationDAO createReservationDAO() {
        return new ReservationDAO();
    }

    public static BillDAO createBillDAO() {
        return new BillDAO();
    }
}