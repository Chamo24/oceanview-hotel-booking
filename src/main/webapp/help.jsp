<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Guide - Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Navigation Bar -->
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
            </c:if>
            <li><a href="help.jsp" class="active">Help</a></li>
            <li class="navbar-user">
                Welcome, <strong>${sessionScope.fullName}</strong>
            </li>
            <li><a href="logout" style="color: #e74c3c;">Logout</a></li>
        </ul>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">

    <div class="page-header">
        <h2>❓ Help Guide</h2>
        <p>Guidelines for using the Ocean View Resort Reservation System</p>
    </div>

    <!-- Section 1: Login -->
    <div class="card">
        <div class="card-header">1. How to Login to the System</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Step 1:</strong> Open the system URL in your browser.
                    The Login page will appear automatically.
                </li>
                <li>
                    <strong>Step 2:</strong> Enter your <strong>Username</strong>
                    and <strong>Password</strong> provided by your administrator.
                </li>
                <li>
                    <strong>Step 3:</strong> Click the 
                    <strong>"Login to System"</strong> button.
                </li>
                <li>
                    <strong>Default Admin Credentials:</strong>
                    Username: <code>admin</code> | Password: <code>admin123</code>
                </li>
                <li>
                    <strong>Note:</strong> If you forget your password, 
                    contact the System Administrator.
                </li>
            </ul>
        </div>
    </div>

    <!-- Section 2: Add Reservation -->
    <div class="card">
        <div class="card-header">2. How to Add a New Reservation</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Step 1:</strong> Click 
                    <strong>"New Reservation"</strong> from the 
                    navigation menu or Dashboard.
                </li>
                <li>
                    <strong>Step 2:</strong> Enter the 
                    <strong>Guest Full Name</strong> 
                    (letters and spaces only, 2-100 characters).
                </li>
                <li>
                    <strong>Step 3:</strong> Enter the 
                    <strong>Contact Number</strong> 
                    (Sri Lankan format: 0771234567 or +94771234567).
                </li>
                <li>
                    <strong>Step 4:</strong> Enter the 
                    <strong>Guest Address</strong> 
                    (minimum 5 characters).
                </li>
                <li>
                    <strong>Step 5:</strong> Select the 
                    <strong>Room Type</strong> 
                    (Single / Double / Deluxe / Suite).
                    Available rooms will load automatically.
                </li>
                <li>
                    <strong>Step 6:</strong> Select a specific 
                    <strong>Room</strong> from the dropdown.
                </li>
                <li>
                    <strong>Step 7:</strong> Select 
                    <strong>Check-In Date</strong> 
                    (today or a future date).
                </li>
                <li>
                    <strong>Step 8:</strong> Select 
                    <strong>Check-Out Date</strong> 
                    (must be after check-in date).
                </li>
                <li>
                    <strong>Step 9:</strong> The system will show an 
                    <strong>estimated cost</strong> automatically.
                </li>
                <li>
                    <strong>Step 10:</strong> Click 
                    <strong>"Create Reservation"</strong>. 
                    A unique Reservation Number (e.g., OVR-2025-0001) 
                    will be generated automatically.
                </li>
            </ul>
        </div>
    </div>

    <!-- Section 3: Search Reservation -->
    <div class="card">
        <div class="card-header">3. How to Search for a Reservation</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Method 1 - Search by Number:</strong> 
                    Click <strong>"Search"</strong> from the menu. 
                    Enter the Reservation Number 
                    (format: OVR-2025-0001) and click Search.
                </li>
                <li>
                    <strong>Method 2 - Browse All:</strong> 
                    Click <strong>"All Reservations"</strong> 
                    to view and browse all bookings.
                </li>
                <li>
                    <strong>View Details:</strong> 
                    Click the <strong>"View"</strong> button 
                    next to any reservation to see full details.
                </li>
            </ul>
        </div>
    </div>

    <!-- Section 4: Generate Bill -->
    <div class="card">
        <div class="card-header">4. How to Generate and Print a Bill</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Step 1:</strong> Find the reservation from 
                    <strong>"All Reservations"</strong> page.
                </li>
                <li>
                    <strong>Step 2:</strong> Click the 
                    <strong>"Bill"</strong> button next to 
                    the reservation, OR open the reservation and click 
                    <strong>"Generate Bill"</strong>.
                </li>
                <li>
                    <strong>Step 3:</strong> The system will automatically 
                    calculate the total bill based on number of nights 
                    and room rate.
                </li>
                <li>
                    <strong>Step 4:</strong> To print, click the 
                    <strong>"Print Bill"</strong> button. 
                    The navigation bar will be hidden for a clean printout.
                </li>
                <li>
                    <strong>Note:</strong> A bill can only be generated 
                    once per reservation.
                </li>
            </ul>
        </div>
    </div>

    <!-- Section 5: Check-Out / Cancel -->
    <div class="card">
        <div class="card-header">5. How to Check-Out a Guest or Cancel a Reservation</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Check-Out:</strong> Open the reservation → 
                    Click <strong>"Check-Out Guest"</strong>. 
                    The room will automatically become 
                    Available for new bookings.
                </li>
                <li>
                    <strong>Cancel:</strong> Open the reservation → 
                    Click <strong>"Cancel Reservation"</strong>. 
                    The room will automatically become Available.
                </li>
                <li>
                    <strong>Note:</strong> Only 
                    <strong>Confirmed</strong> reservations 
                    can be checked-out or cancelled.
                </li>
            </ul>
        </div>
    </div>

    <!-- Section 6: Reports (Admin Only) -->
    <div class="card">
        <div class="card-header">6. Management Reports (Admin Only)</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Access:</strong> 
                    Reports are only available to 
                    <strong>Admin</strong> users.
                </li>
                <li>
                    <strong>Occupancy Report:</strong> 
                    Shows room availability and occupancy rate 
                    across all room types.
                </li>
                <li>
                    <strong>Revenue Report:</strong> 
                    Shows total revenue generated and 
                    breakdown by room type.
                </li>
                <li>
                    <strong>Print:</strong> 
                    Click <strong>"Print Report"</strong> 
                    to get a printed copy for management review.
                </li>
            </ul>
        </div>
    </div>

    <!-- Section 7: Room Types -->
    <div class="card">
        <div class="card-header">7. Room Types and Rates</div>
        <div class="help-section">
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Room Type</th>
                            <th>Rate Per Night</th>
                            <th>Description</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Single</strong></td>
                            <td>LKR 5,000 - 5,500</td>
                            <td>Standard single room, garden/partial sea view</td>
                        </tr>
                        <tr>
                            <td><strong>Double</strong></td>
                            <td>LKR 8,000 - 8,500</td>
                            <td>Spacious double room with sea view</td>
                        </tr>
                        <tr>
                            <td><strong>Deluxe</strong></td>
                            <td>LKR 12,000</td>
                            <td>Deluxe room with panoramic ocean view</td>
                        </tr>
                        <tr>
                            <td><strong>Suite</strong></td>
                            <td>LKR 20,000 - 25,000</td>
                            <td>Luxury suite with living area and terrace</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Section 8: Logout -->
    <div class="card">
        <div class="card-header">8. How to Logout (Exit System)</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>Step 1:</strong> Click the 
                    <strong style="color: #e74c3c;">"Logout"</strong> 
                    button in the top navigation bar.
                </li>
                <li>
                    <strong>Step 2:</strong> Your session will be 
                    securely terminated and you will be 
                    redirected to the Login page.
                </li>
                <li>
                    <strong>Important:</strong> Always logout when 
                    leaving the system unattended to 
                    maintain security. Sessions automatically 
                    expire after <strong>30 minutes</strong> 
                    of inactivity.
                </li>
            </ul>
        </div>
    </div>

    <!-- Contact -->
    <div class="card">
        <div class="card-header">Need Further Assistance?</div>
        <div class="help-section">
            <ul class="help-steps">
                <li>
                    <strong>System Administrator:</strong> 
                    Contact the admin user for 
                    account issues or system access problems.
                </li>
                <li>
                    <strong>Hotel:</strong> 
                    Ocean View Resort | 
                    No. 42, Lighthouse Street, Galle Fort, 
                    Galle, Sri Lanka.
                </li>
                <li>
                    <strong>Tel:</strong> +94 91 223 4567 | 
                    <strong>Email:</strong> info@oceanviewgalle.lk
                </li>
            </ul>
        </div>
    </div>

    <!-- Back Button -->
    <div style="text-align: center; margin-bottom: 30px;">
        <a href="dashboard" class="btn btn-primary" 
           style="width: 200px;">Back to Dashboard</a>
    </div>

</div>

</body>
</html>