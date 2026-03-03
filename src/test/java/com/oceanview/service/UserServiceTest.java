package com.oceanview.service;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import org.junit.Before;
import org.junit.Test;
import org.mockito.Mockito;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

public class UserServiceTest {

    private UserDAO mockUserDAO;
    private UserService userService;

    @Before
    public void setUp() {
        mockUserDAO = Mockito.mock(UserDAO.class);

        userService = new UserService() {
            {
                this.userDAO = mockUserDAO;
                this.validationService = new ValidationService();
            }
        };
    }

    @Test
    public void testValidLogin_Success() {
        User mockUser = new User();
        mockUser.setUserId(1);
        mockUser.setUsername("admin");
        mockUser.setFullName("Admin User");
        mockUser.setRole("admin");

        when(mockUserDAO.authenticateUser(
            "admin", "admin123")).thenReturn(mockUser);

        User result = userService.login("admin", "admin123");

        assertNotNull(result);
        assertEquals("admin", result.getUsername());
        verify(mockUserDAO, times(1))
            .authenticateUser("admin", "admin123");
    }

    @Test
    public void testLogin_EmptyUsername() {
        User result = userService.login("", "admin123");

        assertNull(result);
        verify(mockUserDAO, never())
            .authenticateUser(anyString(), anyString());
    }

    @Test
    public void testLogin_ShortPassword() {
        User result = userService.login("admin", "123");

        assertNull(result);
        verify(mockUserDAO, never())
            .authenticateUser(anyString(), anyString());
    }

    @Test
    public void testRegister_Success() {
        when(mockUserDAO.usernameExists("newuser"))
            .thenReturn(false);
        when(mockUserDAO.registerUser(
            "newuser", "pass123", "New User", "receptionist"))
            .thenReturn(true);

        String result = userService.register(
            "newuser", "pass123", "New User", "receptionist");

        assertNull(result);
        verify(mockUserDAO, times(1))
            .registerUser(anyString(), anyString(),
                         anyString(), anyString());
    }

    @Test
    public void testRegister_DuplicateUsername() {
        when(mockUserDAO.usernameExists("admin"))
            .thenReturn(true);

        String result = userService.register(
            "admin", "pass123", "Admin User", "receptionist");

        assertNotNull(result);
        assertTrue(result.contains("already exists"));
        verify(mockUserDAO, never())
            .registerUser(anyString(), anyString(),
                         anyString(), anyString());
    }
}