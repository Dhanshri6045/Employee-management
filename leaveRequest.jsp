<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Leave Request</title>
    <link rel="stylesheet"
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

    int employeeId = -1;
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Get employee ID from username
        String sql = "SELECT id FROM employees WHERE username = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        rs = stmt.executeQuery();
        if (rs.next()) {
            employeeId = rs.getInt("id");
        }

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String leaveType = request.getParameter("leaveType");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String reason = request.getParameter("reason");

            if (employeeId != -1) {
                String insertSql = "INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, reason) VALUES (?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setInt(1, employeeId);
                stmt.setString(2, leaveType);
                stmt.setString(3, startDate);
                stmt.setString(4, endDate);
                stmt.setString(5, reason);
                stmt.executeUpdate();
%>
                <div class="alert alert-success m-3">Leave request submitted successfully!</div>
<%
            }
        }
    } catch (Exception e) {
        out.println("<div class='alert alert-danger m-3'>Error: " + e.getMessage() + "</div>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>

<div class="container mt-5">
    <h2 class="mb-4">Leave Request Form</h2>
    <form method="post">
        <div class="form-group">
            <label for="leaveType">Leave Type</label>
            <select class="form-control" name="leaveType" id="leaveType" required>
                <option value="">Select Leave Type</option>
                <option value="Sick Leave">Sick Leave</option>
                <option value="Casual Leave">Casual Leave</option>
                <option value="Annual Leave">Annual Leave</option>
                <option value="Maternity Leave">Maternity Leave</option>
            </select>
        </div>
        <div class="form-group">
            <label for="startDate">Start Date</label>
            <input type="date" class="form-control" name="startDate" required>
        </div>
        <div class="form-group">
            <label for="endDate">End Date</label>
            <input type="date" class="form-control" name="endDate" required>
        </div>
        <div class="form-group">
            <label for="reason">Reason</label>
            <textarea class="form-control" name="reason" rows="4" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Submit Request</button>
        <a href="dashboard.jsp" class="btn btn-secondary ml-2">Back to Dashboard</a>
    </form>
</div>
</body>
</html>
