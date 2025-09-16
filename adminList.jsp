<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin List</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: linear-gradient(to right, #e0f7fa, #ffffff);
	font-family: 'Segoe UI', sans-serif;
}

.container {
	margin-top: 60px;
	background: #fff;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 0 25px rgba(0, 0, 0, 0.1);
}

h2 {
	color: #0d6efd;
	margin-bottom: 25px;
}

.table th {
	background-color: #0d6efd;
	color: white;
	text-align: center;
}

.table td {
	text-align: center;
	vertical-align: middle;
}

.table-hover tbody tr:hover {
	background-color: #f2f2f2;
}

.back-btn {
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center">Admin List</h2>

		<div class="table-responsive">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>ID</th>
						<th>Username</th>
						<th>Action</th>
						
					</tr>
				</thead>
				<tbody>
					<%
					String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
					String dbUser = "root";
					String dbPassword = "abc@123";

					try (Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
							Statement stmt = conn.createStatement();
							ResultSet rs = stmt.executeQuery("SELECT * FROM admins");) {
						while (rs.next()) {
							int id = rs.getInt("id");
							String username = rs.getString("username");
					%>
					<tr>
						<td><%=id%></td>
						<td><%=username%></td>
						<td>
							<form method="post" action="deleteAdmin.jsp"
								onsubmit="return confirm('Are you sure you want to delete this admin?');">
								<input type="hidden" name="id" value="<%=id%>">
								<button type="submit" class="btn btn-danger btn-sm">Delete</button>
							</form>
						</td>
					</tr>

					<%
					}
					} catch (Exception e) {
					out.println("<tr><td colspan='2'>Error loading admin data.</td></tr>");
					e.printStackTrace();
					}
					%>
				</tbody>
			</table>
		</div>

		<div class="text-center back-btn">
			<a href="adminDashboard.jsp" class="btn btn-outline-primary">←
				Back to Dashboard</a>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
