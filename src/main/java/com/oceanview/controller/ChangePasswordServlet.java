package com.oceanview.controller;

import com.oceanview.dao.DBConnection;
import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * ChangePasswordServlet - Allows staff to change their password
 * URL: /changepassword
 * Available to all logged-in users
 */
@WebServlet("/changepassword")
public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/changePassword.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        int userId = (int) session.getAttribute("userId");
        String username = (String) session.getAttribute("username");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate current password
        User user = userDAO.authenticateUser(username, currentPassword);
        if (user == null) {
            request.setAttribute("error",
                "Current password is incorrect.");
            request.getRequestDispatcher("/changePassword.jsp")
                   .forward(request, response);
            return;
        }

        // Validate new password length
        if (newPassword == null || newPassword.length() < 5) {
            request.setAttribute("error",
                "New password must be at least 5 characters.");
            request.getRequestDispatcher("/changePassword.jsp")
                   .forward(request, response);
            return;
        }

        // Confirm password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error",
                "Passwords do not match.");
            request.getRequestDispatcher("/changePassword.jsp")
                   .forward(request, response);
            return;
        }

        // Update password in database
        boolean success = updatePassword(userId, newPassword);

        if (success) {
            // Update first login flag
            updateFirstLoginFlag(userId);

            // Update session
            request.getSession().setAttribute("isFirstLogin", false);

            request.setAttribute("success",
                "Password changed successfully!");

        } else {
            request.setAttribute("error",
                "Failed to change password. Please try again.");
        }

        request.getRequestDispatcher("/changePassword.jsp")
               .forward(request, response);
    }

    private boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setInt(2, userId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error changing password: "
                + e.getMessage());
            return false;
        }
    }

    private boolean updateFirstLoginFlag(int userId) {
        String sql = "UPDATE users SET is_first_login = 0 WHERE user_id = ?";

        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating first login: "
                + e.getMessage());
            return false;
        }
    }
}