<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <h1 style="color: #e74c3c;">&#9888; Error Occurred</h1>
        <p class="subtitle">Ocean View Resort - Reservation System</p>

        <div class="alert alert-error">
            An unexpected error has occurred. 
            Please try again or contact the administrator.
        </div>

        <% if (exception != null) { %>
            <p style="font-size: 12px; color: #95a5a6; margin-top: 10px;">
                Error: <%= exception.getMessage() %>
            </p>
        <% } %>

        <div style="margin-top: 20px; text-align: center;">
            <a href="dashboard" class="btn btn-primary">
                Go to Dashboard
            </a>
            <br><br>
            <a href="login" class="btn btn-info">
                Back to Login
            </a>
        </div>

        <p style="text-align:center; margin-top:20px; 
                  font-size:12px; color:#95a5a6;">
            &copy; 2025 Ocean View Resort. All Rights Reserved.
        </p>
    </div>
</div>
</body>
</html>