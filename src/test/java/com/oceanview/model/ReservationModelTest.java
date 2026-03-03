package com.oceanview.model;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * ReservationModelTest - Unit tests for Reservation Model
 * Tests object creation and getters/setters
 * Pure JUnit 4 - No database required
 */
public class ReservationModelTest {

    @Test
    public void testReservationCreation() {
        // Arrange & Act
        Reservation reservation = new Reservation();
        reservation.setReservationNumber("OVR-2025-0001");
        reservation.setGuestName("Kamal Silva");
        reservation.setAddress("45 Galle Road, Colombo");
        reservation.setContactNumber("0771234567");
        reservation.setRoomType("Double");
        reservation.setCheckInDate("2025-07-15");
        reservation.setCheckOutDate("2025-07-18");

        // Assert
        assertEquals("OVR-2025-0001", 
            reservation.getReservationNumber());
        assertEquals("Kamal Silva", 
            reservation.getGuestName());
        assertEquals("0771234567", 
            reservation.getContactNumber());
        assertEquals("Double", 
            reservation.getRoomType());
    }

    @Test
    public void testReservationConstructor() {
        // Act
        Reservation reservation = new Reservation(
            "John Doe",
            "Colombo 07",
            "0771234567",
            1,
            "Single",
            "2025-07-20",
            "2025-07-25",
            1
        );

        // Assert
        assertEquals("John Doe", 
            reservation.getGuestName());
        assertEquals("Colombo 07", 
            reservation.getAddress());
        assertEquals("0771234567", 
            reservation.getContactNumber());
        assertEquals(1, reservation.getRoomId());
        assertEquals("Single", 
            reservation.getRoomType());
        assertEquals(1, reservation.getCreatedBy());
    }

    @Test
    public void testReservationSettersGetters() {
        // Arrange
        Reservation reservation = new Reservation();

        // Act
        reservation.setReservationId(10);
        reservation.setNumberOfNights(3);
        reservation.setTotalCost(15000.00);
        reservation.setStatus("Confirmed");
        reservation.setRoomNumber("101");
        reservation.setRatePerNight(5000.00);

        // Assert
        assertEquals(10, 
            reservation.getReservationId());
        assertEquals(3, 
            reservation.getNumberOfNights());
        assertEquals(15000.00, 
            reservation.getTotalCost(), 0.01);
        assertEquals("Confirmed", 
            reservation.getStatus());
        assertEquals("101", 
            reservation.getRoomNumber());
        assertEquals(5000.00, 
            reservation.getRatePerNight(), 0.01);
    }
}