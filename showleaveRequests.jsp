<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Leave Requests</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .container {
            margin-top: 50px;
            background: white;
            padding: 30px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            border-radius: 10px;
        }
        h2 {
            margin-bottom: 30px;
            color: #343a40;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .table thead th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Leave Requests</h2>

    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>Full Name</th> <!-- Added Full Name column -->
                <th>Leave Type</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
                String dbUser = "root";
                String dbPassword = "abc@123";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                    
                    // JOIN Query to get full name from employee table
                    String sql = "SELECT lr.id, lr.employee_id, e.full_name, lr.leave_type, lr.start_date, lr.end_date, lr.reason, lr.status " +
                                 "FROM leave_requests lr " +
                                 "INNER JOIN employees e ON lr.employee_id = e.id";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    while (rs.next()) {
                        int leaveId = rs.getInt("id");
                        int empId = rs.getInt("employee_id");
                        String fullName = rs.getString("full_name");
                        String leaveType = rs.getString("leave_type");
                        String startDate = rs.getString("start_date");
                        String endDate = rs.getString("end_date");
                        String reason = rs.getString("reason");
                        String status = rs.getString("status");
            %>
            <tr>
                <td><%= empId %></td>
                <td><%= fullName %></td> <!-- Displaying Full Name -->
                <td><%= leaveType %></td>
                <td><%= startDate %></td>
                <td><%= endDate %></td>
                <td><%= reason %></td>
                <td><%= status %></td>
                <td>
                    <form method="post" action="updateLeaveRequest.jsp">
                        <input type="hidden" name="leaveId" value="<%= leaveId %>">
                        <select name="status" class="form-control mb-2">
                            <option value="Pending" <%= "Pending".equals(status) ? "selected" : "" %>>Pending</option>
                            <option value="Approved" <%= "Approved".equals(status) ? "selected" : "" %>>Approved</option>
                            <option value="Rejected" <%= "Rejected".equals(status) ? "selected" : "" %>>Rejected</option>
                        </select>
                        <button type="submit" class="btn btn-primary btn-sm">Update</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <tr><td colspan="8" class="text-center text-danger">Error loading data</td></tr>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>

    <!-- Add a "Go to Dashboard" Button -->
    <div class="text-center mt-4">
        <a href="adminDashboard.jsp" class="btn btn-success btn-lg">Go to Dashboard</a>
    </div>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
