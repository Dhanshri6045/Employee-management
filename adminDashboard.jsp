<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #dee2ff, #f8f9fa);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            margin-top: 50px;
            padding: 40px;
            border-radius: 15px;
            background-color: #fff;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
        }

        h2, h3 {
            color: #0d6efd;
            font-weight: 600;
        }

        .btn {
            margin: 5px;
            font-weight: 500;
        }

        .btn-danger, .btn-warning {
            color: #fff;
        }

        .table th {
            background-color: #0d6efd;
            color: white;
        }

        .table td, .table th {
            vertical-align: middle;
            text-align: center;
        }

        .table-striped > tbody > tr:nth-of-type(odd) {
            background-color: #f9f9f9;
        }

        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }

        .dashboard-actions {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-end;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Admin Dashboard</h2>

   <div class="dashboard-actions mb-4">
    <a href="addEmployee.jsp" class="btn btn-primary">Add New Employee</a>
    <a href="departments.jsp" class="btn btn-secondary">Manage Departments</a>
    <a href="attendanceshow.jsp" class="btn btn-info">Attendance</a>
    <a href="showleaveRequests.jsp" class="btn btn-warning">Leave Requests</a>
    <a href="DeleteEmployee.jsp" class="btn btn-danger">Delete Employee</a>
    <a href="generateReport.jsp" class="btn btn-success">Generate Reports</a>
    <a href="adminList.jsp" class="btn btn-dark">Admin List</a>
    <a href="index.jsp" class="btn btn-outline-danger">Logout</a>
</div>
   
    <h3 class="mb-3">Employee List</h3>

    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
                    String dbUser = "root"; 
                    String dbPassword = "abc@123"; 

                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                        String sql = "SELECT * FROM employees";
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery(sql);

                        while (resultSet.next()) {
                            int id = resultSet.getInt("id");
                            String username = resultSet.getString("username");
                            String name = resultSet.getString("full_name");
                            String email = resultSet.getString("email");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= username %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td>
                        <a href="adminpay.jsp?id=<%= id %>" class="btn btn-sm btn-outline-warning">Pay</a>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error loading data.</td></tr>");
                        e.printStackTrace();
                    } finally {
                        if (resultSet != null) try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (statement != null) try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
