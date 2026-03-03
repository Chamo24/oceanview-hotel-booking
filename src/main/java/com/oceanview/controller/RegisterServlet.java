package com.oceanview.controller;

import com.oceanview.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RegisterServlet - Handles new staff registration by Admin
 * URL: /register
 * Admin only - AuthenticationFilter restricts access
 * MVC Pattern: Controller component
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");

        String role = request.getParameter("role");
        if (role == null ||
            (!role.equals("receptionist") && !role.equals("admin"))) {
            role = "receptionist";
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
            return;
        }

        String error = userService.register(username, password,
                                            fullName, role);

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("success",
                "Staff account created! Username: " + username +
                " | Share credentials with the staff member.");
            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
        }
    }
}