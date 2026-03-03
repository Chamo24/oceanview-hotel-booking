<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Reservations - Ocean View Resort</title>
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
            <li><a href="reservation?action=list" class="active">All Reservations</a></li>
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
        <h2>📋 All Reservations</h2>
        <p>View and manage all guest room reservations</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <!-- Action Buttons -->
    <div style="margin-bottom: 20px;">
        <a href="reservation?action=add" class="btn btn-success">➕ New Reservation</a>
        <a href="reservation?action=search" class="btn btn-info" style="margin-left: 10px;">🔍 Search Reservation</a>
    </div>

    <!-- Reservations Table -->
    <div class="card">
        <div class="card-header">Reservation Records</div>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Reservation No.</th>
                        <th>Guest Name</th>
                        <th>Contact</th>
                        <th>Room</th>
                        <th>Type</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Nights</th>
                        <th>Total (LKR)</th>
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
                                    <td>${res.contactNumber}</td>
                                    <td>${res.roomNumber}</td>
                                    <td>${res.roomType}</td>
                                    <td>${res.checkInDate}</td>
                                    <td>${res.checkOutDate}</td>
                                    <td>${res.numberOfNights}</td>
                                    <td>${res.totalCost}</td>
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
                                <td colspan="11" style="text-align: center; padding: 30px; color: #95a5a6;">
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

</body>
</html>