<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Attendance List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 50px;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2 {
            margin-bottom: 30px;
            color: #343a40;
            font-weight: bold;
            text-align: center;
        }
        .form-inline label {
            font-weight: bold;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table thead th {
            background-color: #007bff;
            color: white;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-dashboard {
            background-color: #28a745;
            border-color: #28a745;
            color: white;
        }
        .btn-dashboard:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .footer {
            margin-top: 30px;
            text-align: center;
            color: #6c757d;
        }
        .form-inline {
            justify-content: center;
            margin-bottom: 30px;
        }
        .form-control {
            margin-right: 10px;
        }
        .text-center {
            text-align: center;
        }
        .btn-filter {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Employee Attendance Summary</h2>

    <!-- Admin Dashboard Button -->
    <div class="text-center mb-4">
        <a href="adminDashboard.jsp" class="btn btn-dashboard">Admin Dashboard</a>
    </div>

    <!-- Month Selection Form -->
    <form method="get" class="form-inline">
        <label for="month" class="mr-2">Select Month:</label>
        <select id="month" name="month" class="form-control">
            <option value="01">January</option>
            <option value="02">February</option>
            <option value="03">March</option>
            <option value="04">April</option>
            <option value="05">May</option>
            <option value="06">June</option>
            <option value="07">July</option>
            <option value="08">August</option>
            <option value="09">September</option>
            <option value="10">October</option>
            <option value="11">November</option>
            <option value="12">December</option>
        </select>

        <label for="year" class="mr-2">Select Year:</label>
        <select id="year" name="year" class="form-control">
            <option value="2025">2025</option>
            <option value="2024">2024</option>
            <option value="2023">2023</option>
            <!-- Add more years as needed -->
        </select>

        <button type="submit" class="btn btn-primary btn-filter">Filter</button>
    </form>

    <table class="table table-bordered table-striped">
        <thead class="thead-dark">
            <tr>
                <th>Employee ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Present Days</th>
                <th>Absent Days</th>
                <th>Month</th>
            </tr>
        </thead>
        <tbody>
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
                String dbUser  = "root";
                String dbPassword = "abc@123";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                PreparedStatement pstmt = null;
                ResultSet attendanceRs = null;

                // Get month and year from the form
                String month = request.getParameter("month");
                String year = request.getParameter("year");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcURL, dbUser , dbPassword);

                    String employeeSql = "SELECT id, username, full_name FROM employees";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(employeeSql);

                    while (rs.next()) {
                        int empId = rs.getInt("id");
                        String username = rs.getString("username");
                        String fullName = rs.getString("full_name");

                        int presentDays = 0;
                        int absentDays = 0;

                        // Query for Present Days in selected month and year
                        String presentSql = "SELECT COUNT(*) AS present_count FROM attendance WHERE employee_id = ? AND status = 'Present' AND MONTH(date) = ? AND YEAR(date) = ?";
                        pstmt = conn.prepareStatement(presentSql);
                        pstmt.setInt(1, empId);
                        pstmt.setString(2, month);
                        pstmt.setString(3, year);
                        attendanceRs = pstmt.executeQuery();
                        if (attendanceRs.next()) {
                            presentDays = attendanceRs.getInt("present_count");
                        }

                        // Query for Absent Days in selected month and year
                        String absentSql = "SELECT COUNT(*) AS absent_count FROM attendance WHERE employee_id = ? AND status = 'Absent' AND MONTH(date) = ? AND YEAR(date) = ?";
                        pstmt = conn.prepareStatement(absentSql);
                        pstmt.setInt(1, empId);
                        pstmt.setString(2, month);
                        pstmt.setString(3, year);
                        attendanceRs = pstmt.executeQuery();
                        if (attendanceRs.next()) {
                            absentDays = attendanceRs.getInt("absent_count");
                        }
            %>
            <tr>
                <td><%= empId %></td>
                <td><%= username %></td>
                <td><%= fullName %></td>
                <td><%= presentDays %></td>
                <td><%= absentDays %></td>
                <td><%= year + "-" + month %></td>
            </tr>
            <%
                        if (attendanceRs != null) attendanceRs.close();
                        if (pstmt != null) pstmt.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>

    <div class="footer">
        <p>&copy; 2025 Employee Management System | All Rights Reserved</p>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
