<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Reservation - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <div class="navbar-brand"><img src="images/logo.png" style="width:80px; height:auto; vertical-align:middle; margin-right:12px;">Ocean View <span>Resort</span></div>
        <ul class="navbar-menu">
            <li><a href="dashboard">Dashboard</a></li>
            <li><a href="reservation?action=add">New Reservation</a></li>
            <li><a href="reservation?action=list">All Reservations</a></li>
            <li><a href="reservation?action=search" class="active">Search</a></li>
            <li><a href="bill?action=list">Bills</a></li>
<c:if test="${sessionScope.role == 'admin'}">
    <li><a href="reports">Reports</a></li>
</c:if>            <li><a href="help.jsp">Help</a></li>
            <li class="navbar-user">Welcome, <strong>${sessionScope.fullName}</strong></li>
            <li><a href="logout" style="color: #e74c3c;">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">

    <div class="page-header">
        <h2>🔍 Search Reservation</h2>
        <p>Find a reservation by its reservation number</p>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <!-- Search Form -->
    <div class="card">
        <div class="card-header">Search by Reservation Number</div>

        <form action="reservation" method="POST">
            <input type="hidden" name="action" value="search">

            <div class="search-form">
                <input type="text" name="reservationNumber" 
                       placeholder="Enter reservation number (e.g., OVR-2025-0001)" 
                       required pattern="OVR-\d{4}-\d{4}"
                       title="Format: OVR-YYYY-NNNN (e.g., OVR-2025-0001)">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>

        <div style="margin-top: 20px;">
            <h3 style="color: #1a5276; font-size: 16px; margin-bottom: 10px;">Search Tips:</h3>
            <ul class="help-steps">
                <li><strong>Format:</strong> Reservation numbers follow the format OVR-YYYY-NNNN (e.g., OVR-2025-0001)</li>
                <li><strong>Exact Match:</strong> Enter the complete reservation number for accurate results</li>
                <li><strong>Alternative:</strong> You can also browse all reservations from the 
                    <a href="reservation?action=list">All Reservations</a> page</li>
            </ul>
        </div>
    </div>

</div>

</body>
</html>