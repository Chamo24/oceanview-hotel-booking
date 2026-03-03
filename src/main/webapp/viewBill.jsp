<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar no-print">
    <div class="navbar-content">
        <div class="navbar-brand"><img src="images/logo.png" style="width:80px; height:auto; vertical-align:middle; margin-right:12px;">Ocean View <span>Resort</span></div>
        <ul class="navbar-menu">
            <li><a href="dashboard">Dashboard</a></li>
            <li><a href="reservation?action=add">New Reservation</a></li>
            <li><a href="reservation?action=list">All Reservations</a></li>
            <li><a href="reservation?action=search">Search</a></li>
            <li><a href="bill?action=list" class="active">Bills</a></li>
            <li><a href="help.jsp">Help</a></li>
            <li class="navbar-user">Welcome, <strong>${sessionScope.fullName}</strong></li>
            <li><a href="logout" style="color: #e74c3c;">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">

    <div class="page-header no-print">
        <h2>🧾 Guest Bill</h2>
        <p>Generated bill for reservation</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success no-print">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error no-print">${error}</div>
    </c:if>

    <c:if test="${not empty bill}">
        <!-- Bill Card -->
        <div class="bill-container">
            <!-- Bill Header -->
                        <div class="bill-header bill-header-styled">
                <img src="images/logo.png" alt="Ocean View Resort" class="hotel-logo" style="border-color: #ffffff;">
                <h2>Ocean View Resort</h2>
                <p>No. 42, Lighthouse Street, Galle Fort, Galle, Sri Lanka</p>
                <p>Tel: +94 91 223 4567 | Email: info@oceanviewgalle.lk</p>
                <hr style="margin: 15px 0; border-color: rgba(255,255,255,0.3);">
                <h3 style="font-size: 18px;">GUEST BILL / INVOICE</h3>
            </div>

            <!-- Bill Body -->
            <div class="bill-body">
                <div class="bill-row">
                    <span class="bill-label">Bill Number</span>
                    <span class="bill-value">#BILL-${bill.billId}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Reservation Number</span>
                    <span class="bill-value">${bill.reservationNumber}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Bill Date</span>
                    <span class="bill-value">${bill.billDate}</span>
                </div>

                <hr style="margin: 15px 0; border: 1px dashed #bdc3c7;">

                <div class="bill-row">
                    <span class="bill-label">Guest Name</span>
                    <span class="bill-value">${bill.guestName}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Room Type</span>
                    <span class="bill-value">${bill.roomType}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Room Number</span>
                    <span class="bill-value">${bill.roomNumber}</span>
                </div>

                <hr style="margin: 15px 0; border: 1px dashed #bdc3c7;">

                <div class="bill-row">
                    <span class="bill-label">Check-In Date</span>
                    <span class="bill-value">${bill.checkInDate}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Check-Out Date</span>
                    <span class="bill-value">${bill.checkOutDate}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Number of Nights</span>
                    <span class="bill-value">${bill.numberOfNights}</span>
                </div>
                <div class="bill-row">
                    <span class="bill-label">Rate Per Night</span>
                    <span class="bill-value">LKR ${bill.ratePerNight}</span>
                </div>

                <!-- Total -->
                <div class="bill-total">
                    <span class="total-label">TOTAL AMOUNT</span>
                    <span class="total-value">LKR ${bill.totalAmount}</span>
                </div>
            </div>

            <!-- Bill Footer -->
            <div class="bill-footer">
                <p><strong>Thank you for choosing Ocean View Resort!</strong></p>
                <p>We hope you enjoyed your stay in beautiful Galle, Sri Lanka.</p>
                <p style="margin-top: 10px;">This is a computer-generated bill. No signature required.</p>
            </div>
        </div>

        <!-- Action Buttons -->
        <div style="text-align: center; margin-top: 25px;" class="no-print">
            <button onclick="window.print()" class="btn btn-primary">🖨️ Print Bill</button>
            <a href="bill?action=list" class="btn btn-info" style="margin-left: 10px;">All Bills</a>
            <a href="dashboard" class="btn btn-success" style="margin-left: 10px;">Dashboard</a>
        </div>
    </c:if>

    <c:if test="${empty bill}">
        <div class="alert alert-error">Bill not found or not yet generated.</div>
        <a href="reservation?action=list" class="btn btn-info">Back to Reservations</a>
    </c:if>

</div>

</body>
</html>