<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Details - Ocean View Resort</title>
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
        <h2>📄 Reservation Details</h2>
        <p>Complete booking information for reservation ${reservation.reservationNumber}</p>
    </div>

    <c:if test="${not empty reservation}">
        <div class="card">
            <div class="card-header">
                Reservation: ${reservation.reservationNumber}
                <c:choose>
                    <c:when test="${reservation.status == 'Confirmed'}">
                        <span class="badge badge-confirmed" style="float: right;">${reservation.status}</span>
                    </c:when>
                    <c:when test="${reservation.status == 'Checked-Out'}">
                        <span class="badge badge-checked-out" style="float: right;">${reservation.status}</span>
                    </c:when>
                    <c:when test="${reservation.status == 'Cancelled'}">
                        <span class="badge badge-cancelled" style="float: right;">${reservation.status}</span>
                    </c:when>
                </c:choose>
            </div>

            <!-- Guest Information -->
            <h3 style="color: #1a5276; margin-bottom: 15px; font-size: 16px;">Guest Information</h3>
            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-label">Guest Name</div>
                    <div class="detail-value">${reservation.guestName}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Contact Number</div>
                    <div class="detail-value">${reservation.contactNumber}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Address</div>
                    <div class="detail-value">${reservation.address}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Reservation Number</div>
                    <div class="detail-value">${reservation.reservationNumber}</div>
                </div>
            </div>

            <hr style="margin: 20px 0; border: 1px solid #ecf0f1;">

            <!-- Room & Stay Information -->
<h3 style="color: #1a5276; margin-bottom: 15px; font-size: 16px;">Room &amp; Stay Information</h3>            <div class="detail-grid">
                <div class="detail-item">
                    <div class="detail-label">Room Type</div>
                    <div class="detail-value">${reservation.roomType}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Room Number</div>
                    <div class="detail-value">${reservation.roomNumber}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Check-In Date</div>
                    <div class="detail-value">${reservation.checkInDate}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Check-Out Date</div>
                    <div class="detail-value">${reservation.checkOutDate}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Number of Nights</div>
                    <div class="detail-value">${reservation.numberOfNights}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Rate Per Night</div>
                    <div class="detail-value">LKR ${reservation.ratePerNight}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Total Cost</div>
                    <div class="detail-value" style="color: #27ae60; font-size: 20px;">LKR ${reservation.totalCost}</div>
                </div>
                <div class="detail-item">
                    <div class="detail-label">Booking Date</div>
                    <div class="detail-value">${reservation.createdAt}</div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div style="margin-top: 25px; padding-top: 20px; border-top: 2px solid #ecf0f1; display: flex; flex-wrap: wrap; gap: 10px;">
                <a href="bill?action=generate&reservationId=${reservation.reservationId}" 
                   class="btn btn-warning">Generate Bill</a>

                <c:if test="${reservation.status == 'Confirmed'}">
                    <a href="reservation?action=checkout&id=${reservation.reservationId}" 
                       class="btn btn-success"
                       onclick="return confirm('Are you sure you want to check-out this guest?');">
                       Check-Out Guest</a>
                    <a href="reservation?action=cancel&id=${reservation.reservationId}" 
                       class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to cancel this reservation?');">
                       Cancel Reservation</a>
                </c:if>

                <a href="reservation?action=list" class="btn btn-info">Back to List</a>
                <a href="dashboard" class="btn btn-primary">Dashboard</a>
            </div>
        </div>
    </c:if>

    <c:if test="${empty reservation}">
        <div class="alert alert-error">Reservation not found.</div>
        <a href="reservation?action=list" class="btn btn-info">Back to All Reservations</a>
    </c:if>

</div>

</body>
</html>