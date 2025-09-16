<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f4f7fc;
            font-family: Arial, sans-serif;
        }

        .container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 600px;
        }

        h2 {
            text-align: center;
            color: #007bff;
            margin-bottom: 30px;
        }

        .form-group label {
            font-weight: 600;
            color: #333;
        }

        .form-control {
            border-radius: 5px;
            padding: 10px;
        }

        .btn {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .alert {
            font-weight: 500;
            text-align: center;
        }

        .footer-link {
            text-decoration: none;
            color: #007bff;
            font-size: 14px;
            text-align: center;
            display: block;
            margin-top: 20px;
        }

        .footer-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>Mark Attendance</h2>

    <%
        String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
        String dbUser = "root";
        String dbPassword = "abc@123";
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        String message = "";

        // Session check
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int employeeId = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Fetch employee ID
            String fetchIdQuery = "SELECT id FROM employees WHERE username = ?";
            statement = connection.prepareStatement(fetchIdQuery);
            statement.setString(1, username);
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                employeeId = resultSet.getInt("id");
            } else {
                response.sendRedirect("login.jsp");
                return;
            }

            // Handle form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String date = request.getParameter("date");
                String status = request.getParameter("status");
                String timeIn = request.getParameter("timeIn");
                String timeOut = request.getParameter("timeOut");

                if (date != null && status != null && timeIn != null && timeOut != null) {
                    String insertQuery = "INSERT INTO attendance (employee_id, date, status, time_in, time_out) VALUES (?, ?, ?, ?, ?)";
                    statement = connection.prepareStatement(insertQuery);
                    statement.setInt(1, employeeId);
                    statement.setString(2, date);
                    statement.setString(3, status);
                    statement.setString(4, timeIn);
                    statement.setString(5, timeOut);

                    int rows = statement.executeUpdate();
                    if (rows > 0) {
                        message = "Attendance marked successfully!";
                    } else {
                        message = "Failed to mark attendance.";
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred.";
        } finally {
            if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

    <p>Hello, <strong><%= username %></strong>!</p>

    <% if (!message.equals("")) { %>
        <div class="alert alert-info"><%= message %></div>
    <% } %>

    <form name="attendanceForm" method="post" onsubmit="return validateForm();">
        <input type="hidden" name="employeeId" value="<%= employeeId %>">

        <div class="form-group">
            <label for="date">Date:</label>
            <input type="date" id="date" name="date" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="status">Status:</label>
            <select id="status" name="status" class="form-control" required>
                <option value="">Select Status</option>
                <option value="Present">Present</option>
                <option value="Absent">Absent</option>
                <option value="Leave">Leave</option>
            </select>
        </div>

        <div class="form-group">
            <label for="timeIn">Time In:</label>
            <input type="time" id="timeIn" name="timeIn" class="form-control" required>
        </div>

        <div class="form-group">
            <label for="timeOut">Time Out:</label>
            <input type="time" id="timeOut" name="timeOut" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary">Mark Attendance</button>
    </form>

    <a href="dashboard.jsp" class="btn btn-secondary footer-link">Back to Dashboard</a>

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
</body>
</html>
