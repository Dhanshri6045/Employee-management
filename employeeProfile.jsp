<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Profile</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<head>
<meta charset="UTF-8">
<title>Employee Profile</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background: linear-gradient(to right, #e3f2fd, #f1f8e9);
	font-family: 'Segoe UI', sans-serif;
}

.container {
	margin-top: 40px;
	max-width: 900px;
}

.profile-header {
	background: linear-gradient(135deg, #007bff, #00c6ff);
	color: white;
	padding: 25px 30px;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 123, 255, 0.2);
	text-align: center;
	margin-bottom: 30px;
}

.profile-card {
	background-color: white;
	border-radius: 15px;
	padding: 25px 30px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}

h4 {
	border-bottom: 2px solid #dee2e6;
	padding-bottom: 10px;
	margin-bottom: 20px;
	color: #343a40;
}

.profile-info p {
	margin: 6px 0;
	font-size: 16px;
}

.profile-info strong {
	color: #495057;
}

.btn-custom {
	background-color: #28a745;
	color: white;
	border-radius: 8px;
	padding: 10px 20px;
}

.btn-custom:hover {
	background-color: #218838;
}

.btn-danger {
	border-radius: 8px;
}

.table-striped th {
	background-color: #007bff;
	color: white;
	text-align: center;
}

.table td, .table th {
	text-align: center;
	vertical-align: middle;
}

.btn-group {
	text-align: center;
}
</style>


</head>
<body>

	<%
	// Session values
	String username = (String) session.getAttribute("username");
	String email = (String) session.getAttribute("email");
	String role = (String) session.getAttribute("role");
	String department = (String) session.getAttribute("department");

	if (username == null) {
		response.sendRedirect("login.jsp");
		return;
	}

	// DB variables
	String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
	String dbUser = "root";
	String dbPassword = "abc@123";

	// Employee info
	int employeeId = -1;
	String phone = "";
	String address = "";
	String full_name = "";
	String gender = "";

	// Payroll info
	double basicSalary = 0.0;
	double bonus = 0.0;
	double deductions = 0.0;

	Connection connection = null;
	PreparedStatement statement = null;
	ResultSet resultSet = null;

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

		// First, get the employee's ID and other details
		String sql = "SELECT id, full_name, email, password, phone, department, role, gender, dob, address, status FROM employees WHERE username = ?";
		statement = connection.prepareStatement(sql);
		statement.setString(1, username);
		resultSet = statement.executeQuery();

		if (resultSet.next()) {
			employeeId = resultSet.getInt("id");
			phone = resultSet.getString("phone");
			address = resultSet.getString("address");
			full_name = resultSet.getString("full_name");
			gender = resultSet.getString("gender");
		}

		resultSet.close();
		statement.close();

		// Now get payroll details using employeeId
		if (employeeId != -1) {
			String payrollSql = "SELECT basic_salary, bonus, deductions FROM payroll WHERE employee_id = ?";
			statement = connection.prepareStatement(payrollSql);
			statement.setInt(1, employeeId);
			resultSet = statement.executeQuery();

			if (resultSet.next()) {
		basicSalary = resultSet.getDouble("basic_salary");
		bonus = resultSet.getDouble("bonus");
		deductions = resultSet.getDouble("deductions");
			}
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if (resultSet != null)
			try {
		resultSet.close();
			} catch (SQLException e) {
		e.printStackTrace();
			}
		if (statement != null)
			try {
		statement.close();
			} catch (SQLException e) {
		e.printStackTrace();
			}
		if (connection != null)
			try {
		connection.close();
			} catch (SQLException e) {
		e.printStackTrace();
			}
	}
	%>

	<div class="container mt-5">
		<div class="profile-header">
			<h2>Employee Profile</h2>
			<p>
				Hello,
				<%=username%>!
			</p>
		</div>

		<div class="profile-card">
			<h4>Profile Information</h4>
			<p>
				<strong>Username:</strong>
				<%=username%></p>
			<p>
				<strong>Full Name:</strong>
				<%=full_name%></p>
			<p>
				<strong>Email:</strong>
				<%=email%></p>
			<p>
				<strong>Role:</strong>
				<%=role%></p>
			<p>
				<strong>Gender:</strong>
				<%=gender%></p>
			<p>
				<strong>Department:</strong>
				<%=department%></p>
			<p>
				<strong>Contact Number:</strong>
				<%=phone%></p>
			<p>
				<strong>Address:</strong>
				<%=address%></p>
		</div>

	<div class="btn-group mb-4">
    <a href="dashboard.jsp" class="btn btn-custom mr-2">Back to Dashboard</a>
    <a href="leaveRequest.jsp" class="btn btn-warning mr-2">Request Leave</a>
    <a href="logout.jsp" class="btn btn-danger">Logout</a>
</div>
	


		<div class="profile-card">
			<h4>Payroll History</h4>

			<table class="table table-striped">
				<thead>
					<tr>
						<th>Payment ID</th>
						<th>Basic Salary</th>
						<th>Bonus</th>
						<th>Deductions</th>
						<th>Payment Date</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (employeeId != -1) {
						try {
							Class.forName("com.mysql.cj.jdbc.Driver");
							connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

							String payrollSql = "SELECT * FROM payroll WHERE employee_id = ?";
							statement = connection.prepareStatement(payrollSql);
							statement.setInt(1, employeeId);
							resultSet = statement.executeQuery();

							while (resultSet.next()) {
					%>
					<tr>
						<td><%=resultSet.getInt("id")%></td>
						<td>₹<%=String.format("%.2f", resultSet.getDouble("basic_salary"))%></td>
						<td>₹<%=String.format("%.2f", resultSet.getDouble("bonus"))%></td>
						<td>₹<%=String.format("%.2f", resultSet.getDouble("deductions"))%></td>
						<td><%=resultSet.getTimestamp("payment_date")%></td>
					</tr>
					<%
					}
					} catch (Exception e) {
					e.printStackTrace();
					} finally {
					if (resultSet != null)
					try {
						resultSet.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					if (statement != null)
					try {
						statement.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					if (connection != null)
					try {
						connection.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					}
					}
					%>

				</tbody>
			</table>
		</div>
	</div>
</body>
</html>

