<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Generate Salary Report</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e9ecef;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 50px;
            border-radius: 10px;
            background-color: white;
            padding: 30px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
        }
        h2 {
            color: #343a40;
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
        .table th {
            background-color: #343a40;
            color: white;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Employee Salary Payment Report</h2>

    <div class="text-right mb-3">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th>Payment ID</th>
                <th>Employee Name</th>
                <th>Username</th>
                <th>Email</th>
                <th>Basic Salary</th>
                <th>Bonus</th>
                <th>Deductions</th>
                <th>Total Salary</th>
                <th>Payment Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
                String dbUser = "root"; 
                String dbPassword = "abc@123"; 

                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    String sql = "SELECT p.id AS payment_id, e.full_name, e.username, e.email, " +
                                 "p.basic_salary, p.bonus, p.deductions, p.payment_date " +
                                 "FROM payroll p " +
                                 "JOIN employees e ON p.employee_id = e.id " +
                                 "ORDER BY p.payment_date DESC";

                    pst = conn.prepareStatement(sql);
                    rs = pst.executeQuery();

                    while (rs.next()) {
                        int paymentId = rs.getInt("payment_id");
                        String fullName = rs.getString("full_name");
                        String username = rs.getString("username");
                        String email = rs.getString("email");
                        double basicSalary = rs.getDouble("basic_salary");
                        double bonus = rs.getDouble("bonus");
                        double deductions = rs.getDouble("deductions");
                        double totalSalary = basicSalary + bonus - deductions;
                        Timestamp paymentDate = rs.getTimestamp("payment_date");
            %>
            <tr>
                <td><%= paymentId %></td>
                <td><%= fullName %></td>
                <td><%= username %></td>
                <td><%= email %></td>
                <td>₹<%= String.format("%.2f", basicSalary) %></td>
                <td>₹<%= String.format("%.2f", bonus) %></td>
                <td>₹<%= String.format("%.2f", deductions) %></td>
                <td>₹<%= String.format("%.2f", totalSalary) %></td>
                <td><%= paymentDate.toString() %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
                <tr>
                    <td colspan="9" class="text-danger text-center">Error loading report. Please try again later.</td>
                </tr>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
