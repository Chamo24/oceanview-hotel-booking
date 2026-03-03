<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<div class="login-container">
    <div class="login-box">
        <img src="images/logo.png" alt="Ocean View Resort" 
             class="hotel-logo">
        <h1>Ocean View Resort</h1>
        <p class="subtitle">
            Galle, Sri Lanka - Room Reservation System
        </p>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="login" method="POST">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username"
                       placeholder="Enter your username" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn btn-primary">
                Login to System
            </button>
        </form>

        <p style="text-align: center; margin-top: 20px; 
                  font-size: 12px; color: #95a5a6;">
            &copy; 2025 Ocean View Resort. All Rights Reserved.
        </p>
    </div>
</div>

</body>
</html>