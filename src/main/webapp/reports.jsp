<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Reports - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .report-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }
        .stat-card {
            background: #ffffff;
            border-radius: 10px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
            border-left: 5px solid;
        }
        .stat-card.blue { border-left-color: #2980b9; }
        .stat-card.green { border-left-color: #27ae60; }
        .stat-card.orange { border-left-color: #e67e22; }
        .stat-card.purple { border-left-color: #9b59b6; }
        .stat-card h3 {
            font-size: 13px;
            color: #7f8c8d;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 8px;
        }
        .stat-card .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #2c3e50;
        }
        .stat-card .stat-label {
            font-size: 12px;
            color: #95a5a6;
            margin-top: 5px;
        }
        .progress-bar-container {
            background: #ecf0f1;
            border-radius: 10px;
            height: 25px;
            margin-top: 10px;
            overflow: hidden;
        }
        .progress-bar {
            height: 100%;
            border-radius: 10px;
            text-align: center;
            color: white;
            font-size: 12px;
            font-weight: 600;
            line-height: 25px;
            transition: width 0.5s ease;
        }
        .progress-bar.green { background: #27ae60; }
        .progress-bar.orange { background: #e67e22; }
        .progress-bar.red { background: #e74c3c; }
        .two-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }
        @media (max-width: 768px) {
            .report-stats { grid-template-columns: repeat(2, 1fr); }
            .two-col { grid-template-columns: 1fr; }
        }
    </style>
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
            <li><a href="reports" class="active">Reports</a></li>
            <li><a href="help.jsp">Help</a></li>
            <li class="navbar-user">Welcome, <strong>${sessionScope.fullName}</strong></li>
            <li><a href="logout" style="color: #e74c3c;">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">

    <!-- Page Banner -->
    <div class="page-banner">
        <h2>Management Reports</h2>
        <p>Real-time hotel performance data to facilitate informed decision-making</p>
    </div>

    <!-- Key Statistics -->
    <div class="report-stats">
        <div class="stat-card blue">
            <h3>Total Rooms</h3>
            <div class="stat-value">${totalRooms}</div>
            <div class="stat-label">Hotel Capacity</div>
        </div>
        <div class="stat-card green">
            <h3>Total Reservations</h3>
            <div class="stat-value">${totalReservations}</div>
            <div class="stat-label">All Time</div>
        </div>
        <div class="stat-card orange">
            <h3>Active Bookings</h3>
            <div class="stat-value">${activeReservations}</div>
            <div class="stat-label">Currently Confirmed</div>
        </div>
        <div class="stat-card purple">
            <h3>Total Revenue</h3>
            <div class="stat-value">LKR ${totalRevenue}</div>
            <div class="stat-label">From ${totalBills} Bills</div>
        </div>
    </div>

    <div class="two-col">

        <!-- Occupancy Report -->
        <div class="card">
            <div class="card-header">Room Occupancy Report</div>

            <!-- Occupancy Rate Bar -->
            <div style="margin-bottom: 20px;">
                <p style="font-weight: 600; margin-bottom: 5px;">
                    Overall Occupancy Rate: ${occupancyRate}%
                </p>
                <div class="progress-bar-container">
                    <c:choose>
                        <c:when test="${occupiedRooms * 100 / (totalRooms > 0 ? totalRooms : 1) > 80}">
                            <div class="progress-bar red" style="width: ${occupancyRate}%">${occupancyRate}%</div>
                        </c:when>
                        <c:when test="${occupiedRooms * 100 / (totalRooms > 0 ? totalRooms : 1) > 50}">
                            <div class="progress-bar orange" style="width: ${occupancyRate}%">${occupancyRate}%</div>
                        </c:when>
                        <c:otherwise>
                            <div class="progress-bar green" style="width: ${occupancyRate}%">${occupancyRate}%</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <p style="font-size: 13px; color: #7f8c8d; margin-top: 8px;">
                    ${occupiedRooms} Occupied / ${availableRooms} Available / ${totalRooms} Total
                </p>
            </div>

            <!-- Room Availability by Type -->
            <h3 style="font-size: 15px; color: #1a5276; margin-bottom: 10px;">Availability by Room Type</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Room Type</th>
                            <th>Available</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Single</strong></td>
                            <td>${singleAvail}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${singleAvail > 0}">
                                        <span class="badge badge-available">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-occupied">Full</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Double</strong></td>
                            <td>${doubleAvail}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${doubleAvail > 0}">
                                        <span class="badge badge-available">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-occupied">Full</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Deluxe</strong></td>
                            <td>${deluxeAvail}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${deluxeAvail > 0}">
                                        <span class="badge badge-available">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-occupied">Full</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>Suite</strong></td>
                            <td>${suiteAvail}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${suiteAvail > 0}">
                                        <span class="badge badge-available">Available</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-occupied">Full</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Revenue Report -->
        <div class="card">
            <div class="card-header">Revenue Report</div>

            <!-- Total Revenue Summary -->
            <div style="text-align: center; padding: 20px; background: #eafaf1; border-radius: 10px; margin-bottom: 20px;">
                <p style="font-size: 13px; color: #7f8c8d; text-transform: uppercase;">Total Revenue Generated</p>
                <p style="font-size: 36px; font-weight: 700; color: #27ae60;">LKR ${totalRevenue}</p>
                <p style="font-size: 13px; color: #7f8c8d;">From ${totalBills} bill(s) generated</p>
            </div>

            <!-- Revenue by Room Type -->
            <h3 style="font-size: 15px; color: #1a5276; margin-bottom: 10px;">Revenue by Room Type</h3>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Room Type</th>
                            <th>Bills</th>
                            <th>Total Nights</th>
                            <th>Revenue (LKR)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty revenueByType}">
                                <c:forEach var="rev" items="${revenueByType}">
                                    <tr>
                                        <td><strong>${rev.roomType}</strong></td>
                                        <td>${rev.generatedBy}</td>
                                        <td>${rev.numberOfNights}</td>
                                        <td><strong style="color: #27ae60;">${rev.totalAmount}</strong></td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" style="text-align: center; padding: 20px; color: #95a5a6;">
                                        No revenue data yet. Generate bills to see revenue report.
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="card">
    <div class="card-header">📅 Date Range Report</div>

    <c:if test="${not empty dateError}">
        <div class="alert alert-error">${dateError}</div>
    </c:if>

    <form action="reports" method="POST">
        <div class="form-row">
            <div class="form-group">
                <label for="startDate">Start Date *</label>
                <input type="date" id="startDate"
                       name="startDate"
                       value="${startDate}" required>
            </div>
            <div class="form-group">
                <label for="endDate">End Date *</label>
                <input type="date" id="endDate"
                       name="endDate"
                       value="${endDate}" required>
            </div>
        </div>
        <button type="submit" class="btn btn-primary"
                style="width: 200px;">
            Generate Report
        </button>
    </form>

    <c:if test="${not empty dateRangeReservations}">
        <div style="margin-top: 25px;">
            <h3 style="color:#1a5276; font-size:15px;">
                Results: ${startDate} to ${endDate}
            </h3>
            <p style="color:#27ae60; font-weight:600;">
                Total Reservations: ${dateRangeCount} |
                Total Revenue: LKR ${dateRangeRevenue}
            </p>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Reservation No.</th>
                            <th>Guest Name</th>
                            <th>Room Type</th>
                            <th>Check-In</th>
                            <th>Check-Out</th>
                            <th>Nights</th>
                            <th>Total (LKR)</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="res"
                            items="${dateRangeReservations}">
                            <tr>
                                <td><strong>${res.reservationNumber}</strong></td>
                                <td>${res.guestName}</td>
                                <td>${res.roomType}</td>
                                <td>${res.checkInDate}</td>
                                <td>${res.checkOutDate}</td>
                                <td>${res.numberOfNights}</td>
                                <td><strong style="color:#27ae60;">
                                    ${res.totalCost}
                                </strong></td>
                                <td>${res.status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:if>
</div>

    </div>

    <!-- Decision Making Insights -->
    <div class="card">
        <div class="card-header">Decision-Making Insights</div>
        <div class="help-section">
            <ul class="help-steps">
                <li><strong>Occupancy Rate:</strong> If occupancy rate exceeds 80%, consider increasing room rates for premium room types during peak seasons.</li>
                <li><strong>Room Availability:</strong> If any room type shows "Full", prioritize check-out processing to free up rooms for new guests.</li>
                <li><strong>Revenue Analysis:</strong> Room types generating the highest revenue should be prioritized for maintenance and upgrades.</li>
                <li><strong>Booking Trends:</strong> Compare active reservations with total reservations to understand booking patterns and plan staffing accordingly.</li>
                <li><strong>Capacity Planning:</strong> If total rooms are frequently fully occupied, management should consider expansion plans for the hotel.</li>
            </ul>
        </div>
    </div>

    <!-- Print Button -->
    <div style="text-align: center; margin-bottom: 30px;" class="no-print">
        <button onclick="window.print()" class="btn btn-primary" style="width: 200px;">Print Report</button>
        <a href="dashboard" class="btn btn-info" style="margin-left: 10px;">Back to Dashboard</a>
    </div>

</div>

</body>
</html>