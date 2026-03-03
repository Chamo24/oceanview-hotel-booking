package com.oceanview.service;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import java.util.ArrayList;
import java.util.List;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

/**
 * RoomServiceTest - Unit tests for RoomService
 * Uses Mockito to mock RoomDAO
 * No database required
 */
public class RoomServiceTest {

    private RoomDAO mockRoomDAO;
    private RoomService roomService;

    @Before
    public void setUp() {
        mockRoomDAO = Mockito.mock(RoomDAO.class);

        roomService = new RoomService() {
            {
                this.roomDAO = mockRoomDAO;
                this.validationService = new ValidationService();
            }
        };
    }

    @Test
    public void testGetAvailableRoomsByType_Valid() {
        // Arrange
        List<Room> mockRooms = new ArrayList<>();
        Room room1 = new Room();
        room1.setRoomId(1);
        room1.setRoomNumber("101");
        room1.setRoomType("Single");
        room1.setStatus("Available");
        mockRooms.add(room1);

        when(mockRoomDAO.getAvailableRoomsByType("Single"))
            .thenReturn(mockRooms);

        // Act
        List<Room> result = roomService
            .getAvailableRoomsByType("Single");

        // Assert
        assertNotNull(result);
        assertEquals(1, result.size());
        assertEquals("101", result.get(0).getRoomNumber());
        verify(mockRoomDAO, times(1))
            .getAvailableRoomsByType("Single");
    }

    @Test
    public void testGetAvailableRoomsByType_Invalid() {
        // Act
        List<Room> result = roomService
            .getAvailableRoomsByType("InvalidType");

        // Assert
        assertNull(result);
        verify(mockRoomDAO, never())
            .getAvailableRoomsByType(anyString());
    }

    @Test
    public void testGetAvailableRoomCount_Valid() {
        // Arrange
        when(mockRoomDAO.getAvailableRoomCount("Single"))
            .thenReturn(3);

        // Act
        int result = roomService
            .getAvailableRoomCount("Single");

        // Assert
        assertEquals(3, result);
        verify(mockRoomDAO, times(1))
            .getAvailableRoomCount("Single");
    }
}