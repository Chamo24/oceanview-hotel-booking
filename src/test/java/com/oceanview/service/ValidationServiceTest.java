package com.oceanview.service;

import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 * ValidationServiceTest - Unit tests for ValidationService
 * Tests all validation methods with positive and negative cases
 * Pure JUnit 4 - No database required
 */
public class ValidationServiceTest {

    private ValidationService validationService;

    @Before
    public void setUp() {
        validationService = new ValidationService();
    }

    // Guest Name Tests
    @Test
    public void testValidGuestName() {
        assertTrue(validationService.isValidGuestName("John Doe"));
        assertTrue(validationService.isValidGuestName("Kamal Silva"));
    }

    @Test
    public void testInvalidGuestName_Empty() {
        assertFalse(validationService.isValidGuestName(""));
        assertFalse(validationService.isValidGuestName(null));
    }

    @Test
    public void testInvalidGuestName_Numbers() {
        assertFalse(validationService.isValidGuestName("John123"));
        assertFalse(validationService.isValidGuestName("123"));
    }

    // Contact Number Tests
    @Test
    public void testValidContactNumber() {
        assertTrue(validationService.isValidContactNumber("0771234567"));
        assertTrue(validationService.isValidContactNumber("+94771234567"));
    }

    @Test
    public void testInvalidContactNumber() {
        assertFalse(validationService.isValidContactNumber("123"));
        assertFalse(validationService.isValidContactNumber("abc"));
        assertFalse(validationService.isValidContactNumber(""));
    }

    // Address Tests
    @Test
    public void testValidAddress() {
        assertTrue(validationService.isValidAddress("45 Galle Road, Colombo"));
        assertTrue(validationService.isValidAddress("Colombo 07"));
    }

    @Test
    public void testInvalidAddress_TooShort() {
        assertFalse(validationService.isValidAddress("123"));
        assertFalse(validationService.isValidAddress(""));
    }

    // Check-in Date Tests
    @Test
    public void testValidCheckInDate() {
        String today = java.time.LocalDate.now().toString();
        assertTrue(validationService.isValidCheckInDate(today));
    }

    @Test
    public void testInvalidCheckInDate_Past() {
        assertFalse(validationService.isValidCheckInDate("2020-01-01"));
    }

    // Reservation Number Test
    @Test
    public void testValidReservationNumber() {
        assertTrue(validationService.isValidReservationNumber("OVR-2025-0001"));
        assertTrue(validationService.isValidReservationNumber("OVR-2024-9999"));
    }
}
