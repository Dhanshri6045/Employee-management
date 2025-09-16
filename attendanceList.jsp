<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.TextStyle" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance List</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .attendance-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .summary-box {
            background-color: #f1f1f1;
            border-radius: 8px;
            padding: 20px;
        }
        .summary-box span {
            font-weight: bold;
            font-size: 1.1rem;
        }
        .badge-status {
            font-size: 0.95rem;
            padding: 5px 10px;
            border-radius: 5px;
        }
        .table-hover tbody tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
    String dbUser = "root";
    String dbPassword = "abc@123";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int empId = -1;

    int presentCount = 0;
    int absentCount = 0;
    int leaveCount = 0;

    LocalDate today = LocalDate.now();
    int currentMonth = today.getMonthValue();
    int currentYear = today.getYear();
    String monthName = today.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH);
%>

<div class="container mt-5">
  <a href="dashboard.jsp" class="btn btn-secondary ml-2">Back to Dashboard</a>
  <br><br>
    <div class="attendance-card">
        <h3 class="mb-4">Attendance List for <span class="text-primary"><%= username %></span></h3>

        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // Get employee ID
                String empSql = "SELECT id FROM employees WHERE username = ?";
                pstmt = conn.prepareStatement(empSql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    empId = rs.getInt("id");
                }

                rs.close();
                pstmt.close();

                // Get attendance summary
                if (empId != -1) {
                    String countSql = "SELECT status, COUNT(*) AS count FROM attendance WHERE employee_id = ? AND MONTH(date) = ? AND YEAR(date) = ? GROUP BY status";
                    pstmt = conn.prepareStatement(countSql);
                    pstmt.setInt(1, empId);
                    pstmt.setInt(2, currentMonth);
                    pstmt.setInt(3, currentYear);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        String status = rs.getString("status");
                        int count = rs.getInt("count");
                        if ("Present".equalsIgnoreCase(status)) {
                            presentCount = count;
                        } else if ("Absent".equalsIgnoreCase(status)) {
                            absentCount = count;
                        } else if ("Leave".equalsIgnoreCase(status)) {
                            leaveCount = count;
                        }
                    }

                    rs.close();
                    pstmt.close();
                }
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error loading summary: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        %>

        <div class="summary-box mb-4">
            <h5>Summary for <%= monthName %>:</h5>
            <span class="badge badge-success badge-status">Present: <%= presentCount %> days</span>
            <span class="badge badge-danger badge-status">Absent: <%= absentCount %> days</span>
            <span class="badge badge-warning badge-status">Leave: <%= leaveCount %> days</span>
        </div>

        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Time In</th>
                    <th>Time Out</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    if (empId != -1) {
                        String attSql = "SELECT date, status, time_in, time_out FROM attendance WHERE employee_id = ? ORDER BY date DESC";
                        pstmt = conn.prepareStatement(attSql);
                        pstmt.setInt(1, empId);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            String status = rs.getString("status");
                            String badgeClass = "badge-secondary";
                            if ("Present".equalsIgnoreCase(status)) badgeClass = "badge-success";
                            else if ("Absent".equalsIgnoreCase(status)) badgeClass = "badge-danger";
                            else if ("Leave".equalsIgnoreCase(status)) badgeClass = "badge-warning";
            %>
                            <tr>
                                <td><%= rs.getDate("date") %></td>
                                <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
                                <td><%= rs.getTime("time_in") != null ? rs.getTime("time_in") : "N/A" %></td>
                                <td><%= rs.getTime("time_out") != null ? rs.getTime("time_out") : "N/A" %></td>
                            </tr>
            <%
                        }
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
