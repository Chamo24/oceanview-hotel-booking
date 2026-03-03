<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Reservation - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <div class="navbar-brand"><img src="images/logo.png" style="width:80px; height:auto; vertical-align:middle; margin-right:12px;">Ocean View <span>Resort</span></div>
        <ul class="navbar-menu">
            <li><a href="dashboard">Dashboard</a></li>
            <li><a href="reservation?action=add" class="active">New Reservation</a></li>
            <li><a href="reservation?action=list">All Reservations</a></li>
            <li><a href="reservation?action=search">Search</a></li>
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
        <h2>➕ Add New Reservation</h2>
        <p>Register a new guest and create a room reservation</p>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <!-- Reservation Form -->
    <div class="card">
        <div class="card-header">Guest &amp; Booking Details</div>

        <form action="reservation" method="POST" id="reservationForm">
            <input type="hidden" name="action" value="add">

            <!-- Guest Information -->
            <div class="form-row">
                            <div class="form-group">
                <label for="guestEmail">Guest Email *</label>
                <input type="email" id="guestEmail" name="guestEmail"
                       placeholder="Enter guest email address"
                       value="${guestEmail}" required>
            </div>

                <div class="form-group">
                    <label for="guestName">Guest Full Name *</label>
                    <input type="text" id="guestName" name="guestName"
                           placeholder="Enter guest full name"
                           value="${guestName}" required>
                    <small id="guestNameError" style="color: #e74c3c; display: none;"></small>
                </div>
                <div class="form-group">
                    <label for="contactNumber">Contact Number *</label>
                    <input type="text" id="contactNumber" name="contactNumber"
                           placeholder="e.g., 0771234567"
                           value="${contactNumber}" required>
                    <small id="contactError" style="color: #e74c3c; display: none;"></small>
                </div>
            </div>

            <div class="form-group">
                <label for="address">Address *</label>
                <input type="text" id="address" name="address"
                       placeholder="Enter guest address"
                       value="${address}" required>
                <small id="addressError" style="color: #e74c3c; display: none;"></small>
            </div>

            <!-- Room Selection -->
            <div class="form-row">
                <div class="form-group">
                    <label for="roomType">Room Type *</label>
                    <select id="roomType" name="roomType" required onchange="loadAvailableRooms()">
                        <option value="">-- Select Room Type --</option>
                        <option value="Single" ${roomType == 'Single' ? 'selected' : ''}>Single (LKR 5,000 - 5,500/night)</option>
                        <option value="Double" ${roomType == 'Double' ? 'selected' : ''}>Double (LKR 8,000 - 8,500/night)</option>
                        <option value="Deluxe" ${roomType == 'Deluxe' ? 'selected' : ''}>Deluxe (LKR 12,000/night)</option>
                        <option value="Suite" ${roomType == 'Suite' ? 'selected' : ''}>Suite (LKR 20,000 - 25,000/night)</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="roomId">Available Room *</label>
                    <select id="roomId" name="roomId" required>
                        <option value="">-- Select Room Type First --</option>
                    </select>
                </div>
            </div>

            <!-- Dates -->
            <div class="form-row">
                <div class="form-group">
                    <label for="checkInDate">Check-In Date *</label>
                    <input type="date" id="checkInDate" name="checkInDate"
                           value="${checkInDate}" required>
                    <small id="checkInError" style="color: #e74c3c; display: none;"></small>
                </div>
                <div class="form-group">
                    <label for="checkOutDate">Check-Out Date *</label>
                    <input type="date" id="checkOutDate" name="checkOutDate"
                           value="${checkOutDate}" required>
                    <small id="checkOutError" style="color: #e74c3c; display: none;"></small>
                </div>
            </div>

            <!-- Estimated Cost Display -->
            <div id="costEstimate" style="display: none; padding: 15px; background: #eafaf1; border-radius: 8px; margin-bottom: 20px;">
                <strong>Estimated Stay:</strong> <span id="nightsDisplay">0</span> night(s) |
                <strong>Estimated Cost:</strong> LKR <span id="costDisplay">0.00</span>
            </div>

            <button type="submit" class="btn btn-success" style="width: 200px;">
                Create Reservation
            </button>
            <a href="reservation?action=list" class="btn btn-danger" style="margin-left: 10px;">Cancel</a>
        </form>
    </div>

</div>

<script src="js/validation.js"></script>
<script src="js/reservation.js"></script>

</body>
</html>