<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pay Salary - Admin Payroll</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e9ecef, #f8f9fa);
            font-family: 'Segoe UI', sans-serif;
        }

        .card {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
        }

        h2, h3 {
            color: #0d6efd;
            font-weight: bold;
            text-align: center;
        }

        .form-label {
            font-weight: 500;
        }

        .btn-success {
            background-color: #198754;
            border: none;
        }

        .btn-success:hover {
            background-color: #157347;
        }

        .btn-secondary {
            margin-left: 10px;
        }

        .table th {
            background-color: #0d6efd;
            color: white;
        }

        .table td {
            vertical-align: middle;
        }

        .alert {
            border-radius: 8px;
        }

        .payroll-history {
            max-width: 900px;
            margin: 30px auto;
        }
    </style>
</head>
<body>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
    String dbUser = "root";
    String dbPassword = "abc@123";
    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String message = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String employeeId = request.getParameter("employeeId");
        String basicSalary = request.getParameter("basicSalary");
        String bonus = request.getParameter("bonus");
        String deductions = request.getParameter("deductions");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "INSERT INTO payroll (employee_id, basic_salary, bonus, deductions) VALUES (?, ?, ?, ?)";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(employeeId));
            pst.setDouble(2, Double.parseDouble(basicSalary));
            pst.setDouble(3, Double.parseDouble(bonus));
            pst.setDouble(4, Double.parseDouble(deductions));

            int rowCount = pst.executeUpdate();
            if (rowCount > 0) {
                message = "<div class='alert alert-success text-center'>Salary Paid Successfully!</div>";
            } else {
                message = "<div class='alert alert-danger text-center'>Failed to Pay Salary.</div>";
            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "<div class='alert alert-danger text-center'>Error occurred: " + e.getMessage() + "</div>";
        } finally {
            try { if (pst != null) pst.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
%>

<div class="card">
    <h2>Pay Employee Salary</h2>
    <%= message %>

    <%
        String empId = request.getParameter("id");
        String fullName = "", username = "", email = "";

        if (empId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                String sql = "SELECT * FROM employees WHERE id=?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, empId);
                rs = pst.executeQuery();

                if (rs.next()) {
                    fullName = rs.getString("full_name");
                    username = rs.getString("username");
                    email = rs.getString("email");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) {}
                try { if (pst != null) pst.close(); } catch (SQLException e) {}
                try { if (conn != null) conn.close(); } catch (SQLException e) {}
            }
        }
    %>

    <form method="post">
        <input type="hidden" name="employeeId" value="<%= empId %>">

        <div class="mb-3">
            <label class="form-label">Employee Name</label>
            <input type="text" class="form-control" value="<%= fullName %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Username</label>
            <input type="text" class="form-control" value="<%= username %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" class="form-control" value="<%= email %>" readonly>
        </div>

        <div class="mb-3">
            <label for="basicSalary" class="form-label">Basic Salary</label>
            <input type="number" step="0.01" class="form-control" id="basicSalary" name="basicSalary" required>
        </div>

        <div class="mb-3">
            <label for="bonus" class="form-label">Bonus</label>
            <input type="number" step="0.01" class="form-control" id="bonus" name="bonus" value="0.00">
        </div>

        <div class="mb-3">
            <label for="deductions" class="form-label">Deductions</label>
            <input type="number" step="0.01" class="form-control" id="deductions" name="deductions" value="0.00">
        </div>

        <div class="text-center">
            <button type="submit" class="btn btn-success">Pay Salary</button>
            <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </div>
    </form>
</div>

<%
    if (empId != null && !empId.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String fetchPayroll = "SELECT * FROM payroll WHERE employee_id = ?";
            pst = conn.prepareStatement(fetchPayroll);
            pst.setInt(1, Integer.parseInt(empId));
            rs = pst.executeQuery();
%>

<div class="payroll-history">
    <h3>Payroll History</h3>
    <div class="table-responsive">
        <table class="table table-bordered table-hover mt-3">
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Basic Salary</th>
                    <th>Bonus</th>
                    <th>Deductions</th>
                    <th>Net Salary</th>
                </tr>
            </thead>
            <tbody>
                <%
                    boolean hasRecords = false;
                    while (rs.next()) {
                        hasRecords = true;
                        double basic = rs.getDouble("basic_salary");
                        double bonus = rs.getDouble("bonus");
                        double deduc = rs.getDouble("deductions");
                        double net = basic + bonus - deduc;
                %>
                <tr>
                    <td><%= rs.getInt("employee_id") %></td>
                    <td>₹<%= String.format("%.2f", basic) %></td>
                    <td>₹<%= String.format("%.2f", bonus) %></td>
                    <td>₹<%= String.format("%.2f", deduc) %></td>
                    <td><strong>₹<%= String.format("%.2f", net) %></strong></td>
                </tr>
                <% } if (!hasRecords) { %>
                <tr>
                    <td colspan="5" class="text-center">No payroll records found.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (pst != null) pst.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
