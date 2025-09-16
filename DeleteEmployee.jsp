<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Employee</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 50px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            background-color: white;
            padding: 30px;
        }
        h2 {
            color: #343a40;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Delete Employee</h2>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
    String dbUser = "root";
    String dbPassword = "abc@123";
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String empIdParam = request.getParameter("employeeId");

        try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            if (empIdParam != null && !empIdParam.isEmpty()) {
                int empId = Integer.parseInt(empIdParam);
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Delete from attendance
                String deleteAttendanceSql = "DELETE FROM attendance WHERE employee_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteAttendanceSql)) {
                    stmt.setInt(1, empId);
                    stmt.executeUpdate();
                }

                // Delete from leave_requests
                String deleteLeaveSql = "DELETE FROM leave_requests WHERE employee_id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteLeaveSql)) {
                    stmt.setInt(1, empId);
                    stmt.executeUpdate();
                }

                // Now delete the employee
                String deleteEmployeeSql = "DELETE FROM employees WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(deleteEmployeeSql)) {
                    stmt.setInt(1, empId);
                    int rowsDeleted = stmt.executeUpdate();
                    if (rowsDeleted > 0) {
                        message = "✅ Employee with ID " + empId + " deleted successfully!";
                    } else {
                        message = "⚠️ No employee found with ID " + empId + ".";
                    }
                }
            } else {
                message = "⚠️ Please select a valid Employee.";
            }
        } catch (NumberFormatException e) {
            message = "⚠️ Invalid Employee ID format.";
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            message = "❌ Database Driver not found.";
            e.printStackTrace();
        } catch (SQLException e) {
            message = "❌ Database Error: " + e.getMessage();
            e.printStackTrace();
        }
    }
%>

    <% if (!message.isEmpty()) { %>
        <div class="alert alert-info text-center mt-4">
            <%= message %>
        </div>
    <% } %>

    <form method="post" action="DeleteEmployee.jsp" onsubmit="return confirm('Are you sure you want to delete this employee?');">
        <div class="form-group">
            <label for="employeeId">Select Employee to Delete:</label>
            <select class="form-control" id="employeeId" name="employeeId" required>
                <option value="">-- Select Employee ID --</option>
                <%
                    try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery("SELECT id, full_name FROM employees")) {

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String fullName = rs.getString("full_name");
                %>
                            <option value="<%= id %>"><%= id %> - <%= fullName %></option>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </select>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-danger">Delete Employee</button>
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </form>

</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
