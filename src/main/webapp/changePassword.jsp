<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <div class="navbar-content">
        <div class="navbar-brand">
            <img src="images/logo.png" style="width:80px; height:auto; 
            vertical-align:middle; margin-right:12px;">
            Ocean View <span>Resort</span>
        </div>
        <ul class="navbar-menu">
            <li><a href="dashboard">Dashboard</a></li>
            <li><a href="reservation?action=add">New Reservation</a></li>
            <li><a href="reservation?action=list">All Reservations</a></li>
            <li><a href="reservation?action=search">Search</a></li>
            <li><a href="bill?action=list">Bills</a></li>
            <c:if test="${sessionScope.role == 'admin'}">
                <li><a href="reports">Reports</a></li>
                <li>
                    <a href="#">Staff <span class="dropdown-arrow">▼</span></a>
                    <ul class="dropdown-menu">
                        <li><a href="register">Register Staff</a></li>
                        <li><a href="changepassword">Change Password</a></li>
                    </ul>
                </li>
            </c:if>
            <c:if test="${sessionScope.role == 'receptionist'}">
                <li><a href="changepassword" class="active">
                    Change Password</a></li>
            </c:if>
            <li><a href="help.jsp">Help</a></li>
            <li class="navbar-user">
                Welcome, <strong>${sessionScope.fullName}</strong>
            </li>
            <li><a href="logout" style="color: #e74c3c;">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="main-content">

    <div class="page-header">
        <h2>🔒 Change Password</h2>
        <p>Update your login password</p>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="card" style="max-width: 500px; margin: 0 auto;">
        <div class="card-header">Change Your Password</div>

        <form action="changepassword" method="POST">

            <div class="form-group">
                <label for="currentPassword">Current Password *</label>
                <input type="password" id="currentPassword"
                       name="currentPassword"
                       placeholder="Enter your current password"
                       required>
            </div>

            <div class="form-group">
                <label for="newPassword">New Password *</label>
                <input type="password" id="newPassword"
                       name="newPassword"
                       placeholder="Enter new password (min 5 chars)"
                       required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm New Password *</label>
                <input type="password" id="confirmPassword"
                       name="confirmPassword"
                       placeholder="Re-enter new password"
                       required>
            </div>

            <div class="alert alert-info">
                <strong>Tip:</strong> Choose a strong password 
                with at least 5 characters.
            </div>

            <button type="submit" class="btn btn-success"
                    style="width: 200px;">
                Change Password
            </button>
            <a href="dashboard" class="btn btn-info"
               style="margin-left: 10px;">Cancel</a>

        </form>
    </div>

</div>
</body>
</html>