<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Departments and Employees</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #f0f4f8, #e0eafc);
            font-family: 'Segoe UI', sans-serif;
        }
        .container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
            margin-top: 60px;
        }
        h2, h3 {
            font-weight: 700;
            color: #343a40;
        }
        .btn-secondary {
            border-radius: 8px;
        }
        .form-control {
            border-radius: 8px;
            padding: 10px;
        }
        label {
            font-weight: 600;
        }
        table {
            background-color: #fff;
        }
        th {
            background-color: #007bff;
            color: white;
            text-align: center;
        }
        td {
            text-align: center;
        }
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Manage Departments</h2>

    <div class="text-right mb-3">
        <a href="adminDashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <!-- Department List Dropdown -->
    <form method="get" action="departments.jsp" class="mb-4">
        <div class="form-group">
            <label for="department">Select Department</label>
            <select name="department" id="department" class="form-control" onchange="this.form.submit()">
                <option value="">-- Select Department --</option>
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

                        String sql = "SELECT DISTINCT department FROM employees";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            String deptName = rs.getString("department");
                            String selected = request.getParameter("department") != null && request.getParameter("department").equals(deptName) ? "selected" : "";
                %>
                    <option value="<%= deptName %>" <%= selected %>><%= deptName %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </select>
        </div>
    </form>

    <%
        String selectedDepartment = request.getParameter("department");
        if (selectedDepartment != null && !selectedDepartment.isEmpty()) {
    %>

    <h3 class="text-center">Employees in <%= selectedDepartment %> Department</h3>

    <table class="table table-bordered table-striped mt-4">
        <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn2 = null;
                PreparedStatement pstmt = null;
                ResultSet rs2 = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn2 = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                    String sql2 = "SELECT * FROM employees WHERE department = ?";
                    pstmt = conn2.prepareStatement(sql2);
                    pstmt.setString(1, selectedDepartment);
                    rs2 = pstmt.executeQuery();

                    while (rs2.next()) {
            %>
            <tr>
                <td><%= rs2.getInt("id") %></td>
                <td><%= rs2.getString("username") %></td>
                <td><%= rs2.getString("full_name") %></td>
                <td><%= rs2.getString("email") %></td>
                <td><%= rs2.getString("phone") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs2 != null) try { rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn2 != null) try { conn2.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </tbody>
    </table>

    <% } %>

</div>

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
