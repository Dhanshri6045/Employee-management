<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-header {
            background-color: #007bff;
            color: white;
            padding: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .dashboard-card {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .btn-custom {
            background-color: #28a745;
            color: white;
        }
        .btn-custom:hover {
            background-color: #218838;
            color: white;
        }
        .logout-btn {
            background-color: #dc3545;
            color: white;
        }
        .logout-btn:hover {
            background-color: #c82333;
            color: white;
        }
        .welcome-message {
            font-size: 1.5rem;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    // Retrieve user information from session
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    String department = (String) session.getAttribute("department");

    // Check if the user is logged in
    if (username == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<div class="container mt-5">
    <div class="dashboard-header">
        <h2>Welcome to Your Dashboard</h2>
        <p class="welcome-message">Hello, <%= username %>!</p>
    </div>
    
    <div class="row mt-4">
        <div class="col-md-3">
            <div class="dashboard-card text-center">
                <a href="employeeProfile.jsp" class="btn btn-custom w-100">View Profile</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card text-center">
                <a href="attendance.jsp" class="btn btn-custom w-100">Attendance</a>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card text-center">
                <a href="leaveRequest.jsp" class="btn btn-custom w-100">Leave Request</a>
            </div>
        </div>
        <!-- New Button for Attendance List -->
        <div class="col-md-3">
            <div class="dashboard-card text-center">
                <a href="attendanceList.jsp" class="btn btn-custom w-100">Attendance List</a>
            </div>
        </div>
    </div>
    
    <div class="mt-4">
        <div class="dashboard-card">
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Role:</strong> <%= role %></p>
            <p><strong>Department:</strong> <%= department %></p>
        </div>
    </div>
    
    <a href="logout.jsp" class="btn logout-btn">Logout</a>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
