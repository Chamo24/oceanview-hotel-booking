<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar">
    <div class="navbar-content">
        <div class="navbar-brand"><img src="images/logo.png" style="width:80px; height:auto; vertical-align:middle; margin-right:12px;">Ocean View <span>Resort</span></div>
        <ul class="navbar-menu">
            <li><a href="dashboard">Home</a></li>

            <!-- Reservations Dropdown -->
            <li>
                <a href="#">Reservations <span class="dropdown-arrow">▼</span></a>
                <ul class="dropdown-menu">
                    <li><a href="reservation?action=add">+ New Reservation</a></li>
                    <li><a href="reservation?action=list">All Reservations</a></li>
                    <li><a href="reservation?action=search">Search</a></li>
                </ul>
            </li>

            <li><a href="bill?action=list">Bills</a></li>

<c:if test="${sessionScope.role == 'admin'}">
            <li><a href="reports">Reports</a></li>
            <li>
                <a href="#">Staff <span class="dropdown-arrow">▼</span></a>
                <ul class="dropdown-menu">
                    <li><a href="register">Register Staff</a></li>
                </ul>
            </li>
</c:if>

            <li><a href="help.jsp">Help</a></li>

            <!-- My Profile Dropdown -->
            <li>
                <a href="#" style="color: #f39c12;">
                    👤 My Profile <span class="dropdown-arrow">▼</span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="#">👤 ${sessionScope.fullName}</a></li>
                    <li><a href="#">📋 Role: ${sessionScope.role}</a></li>
                    <li><a href="changepassword">🔒 Change Password</a></li>
                    <li><a href="logout" style="color: #e74c3c;">🚪 Logout</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">

<!-- First Login Warning Banner -->
<c:if test="${sessionScope.isFirstLogin == true}">
    <div style="background: #e74c3c; color: white; 
                padding: 15px 20px; text-align: center;
                font-size: 15px; font-weight: 600;">
        ⚠️ You are using a temporary password! 
        Please 
        <a href="changepassword" 
           style="color: #f39c12; text-decoration: underline;">
            Change Your Password
        </a> 
        immediately for security.
    </div>
</c:if>

        <!-- Page Banner with Background Image -->
    <div class="page-banner">
        <h2>Welcome to Ocean View Resort</h2>
        <p>Room Reservation Management System - Galle, Sri Lanka</p>
    </div>

        <!-- Room Availability Cards with Images -->
    <div class="room-cards">
        <div class="room-card">
            <img src="images/single-room.jpg" alt="Single Room.jpg" class="room-card-img">
            <div class="room-card-body">
                <h3>Single Room</h3>
                <div class="room-rate">LKR 5,000 - 5,500/night</div>
                <div class="room-available">${singleCount}</div>
                <div class="room-label">Available</div>
            </div>
        </div>
        <div class="room-card">
            <img src="images/double-room.jpg" alt="Double Room" class="room-card-img">
            <div class="room-card-body">
                <h3>Double Room</h3>
                <div class="room-rate">LKR 8,000 - 8,500/night</div>
                <div class="room-available">${doubleCount}</div>
                <div class="room-label">Available</div>
            </div>
        </div>
        <div class="room-card">
            <img src="images/deluxe-room.jpg" alt="Deluxe Room" class="room-card-img">
            <div class="room-card-body">
                <h3>Deluxe Room</h3>
                <div class="room-rate">LKR 12,000/night</div>
                <div class="room-available">${deluxeCount}</div>
                <div class="room-label">Available</div>
            </div>
        </div>
        <div class="room-card">
            <img src="images/suite-room.jpg" alt="Suite Room" class="room-card-img">
            <div class="room-card-body">
                <h3>Suite Room</h3>
                <div class="room-rate">LKR 20,000 - 25,000/night</div>
                <div class="room-available">${suiteCount}</div>
                <div class="room-label">Available</div>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions">
        <a href="reservation?action=add" class="quick-action-btn">
            <span class="action-icon">+</span> New Reservation
        </a>
        <a href="reservation?action=search" class="quick-action-btn">
            <span class="action-icon">&#128269;</span> Search Reservation
        </a>
        <a href="bill?action=list" class="quick-action-btn">
            <span class="action-icon">&#128203;</span> View Bills
        </a>
        <a href="help.jsp" class="quick-action-btn">
            <span class="action-icon">?</span> Help Guide
        </a>

    </div>

    <!-- Recent Reservations Table -->
    <div class="card">
        <div class="card-header">Recent Reservations</div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Reservation No.</th>
                        <th>Guest Name</th>
                        <th>Room Type</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty reservations}">
                            <c:forEach var="res" items="${reservations}">
                                <tr>
                                    <td><strong>${res.reservationNumber}</strong></td>
                                    <td>${res.guestName}</td>
                                    <td>${res.roomType}</td>
                                    <td>${res.checkInDate}</td>
                                    <td>${res.checkOutDate}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${res.status == 'Confirmed'}">
                                                <span class="badge badge-confirmed">${res.status}</span>
                                            </c:when>
                                            <c:when test="${res.status == 'Checked-Out'}">
                                                <span class="badge badge-checked-out">${res.status}</span>
                                            </c:when>
                                            <c:when test="${res.status == 'Cancelled'}">
                                                <span class="badge badge-cancelled">${res.status}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge">${res.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="reservation?action=view&id=${res.reservationId}" 
                                           class="btn btn-info btn-sm">View</a>
                                        <a href="bill?action=generate&reservationId=${res.reservationId}" 
                                           class="btn btn-warning btn-sm">Bill</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" style="text-align: center; padding: 30px; color: #95a5a6;">
                                    No reservations found. Click "New Reservation" to create one.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

<!-- Auto-refresh Dashboard Stats using AJAX -->
<script>
// Auto-refresh room availability every 30 seconds
function refreshDashboardStats() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'api/dashboard?action=rooms', true);

    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var data = JSON.parse(xhr.responseText);

            // Update room counts
            var singleEl = document.querySelector('.room-card:nth-child(1) .room-available');
            var doubleEl = document.querySelector('.room-card:nth-child(2) .room-available');
            var deluxeEl = document.querySelector('.room-card:nth-child(3) .room-available');
            var suiteEl = document.querySelector('.room-card:nth-child(4) .room-available');

            if (singleEl) singleEl.textContent = data.single;
            if (doubleEl) doubleEl.textContent = data.double;
            if (deluxeEl) deluxeEl.textContent = data.deluxe;
            if (suiteEl) suiteEl.textContent = data.suite;

            console.log('[AUTO-REFRESH] Dashboard stats updated');
        }
    };

    xhr.send();
}

// Refresh every 30 seconds
setInterval(refreshDashboardStats, 30000);

// Show last refresh time
console.log('[DASHBOARD] Auto-refresh enabled (30s interval)');
</script>

</body>
</html>