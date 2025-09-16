<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="jakarta.servlet.ServletException"%>
<%@ page import="jakarta.servlet.http.HttpServlet"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>
<%@ page import="java.io.IOException"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show Leaves</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	background-color: #f0f2f5;
}

.container {
	margin-top: 30px;
	background: white;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
}

h2 {
	margin-bottom: 20px;
}

.table th {
	background-color: #28a745;
	color: white;
}
</style>
</head>
<body>

	<div class="container">
		<h2 class="text-center">Employee Leave Records</h2>

		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th>Employee ID</th>
					<th>Full Name</th>
					<th>Leave Type</th>
					<th>Start Date</th>
					<th>End Date</th>
					<th>Status</th>
					<th>Notify</th>
				</tr>
			</thead>
			<tbody>
				<%
				String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
				String dbUser = "root";
				String dbPassword = "abc@123";
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

					String sql = "SELECT lr.employee_id, e.full_name, e.email, lr.leave_type, lr.start_date, lr.end_date, lr.status "
					+ "FROM leave_requests lr " + "JOIN employees e ON lr.employee_id = e.id "
					+ "WHERE lr.status IN ('Approved', 'Rejected')";

					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();

					boolean hasData = false;
					while (rs.next()) {
						hasData = true;
						int empId = rs.getInt("employee_id");
						String fullName = rs.getString("full_name");
						String email = rs.getString("email");
						String leaveType = rs.getString("leave_type");
						String startDate = rs.getString("start_date");
						String endDate = rs.getString("end_date");
						String status = rs.getString("status");

						String subject = "Leave Request " + status;
						String body = "Hello " + fullName + ",%0D%0A%0D%0AYour leave request for " + leaveType + " from " + startDate
						+ " to " + endDate + " has been " + status + ".%0D%0A%0D%0ARegards,%0D%0AAdmin";
				%>
				<tr>
					<td><%=empId%></td>
					<td><%=fullName%></td>
					<td><%=leaveType%></td>
					<td><%=startDate%></td>
					<td><%=endDate%></td>
					<td><span
						class="badge badge-<%="Approved".equals(status) ? "success" : "danger"%>"><%=status%></span></td>
					<td>
						<form action="SendEmailServlet" method="post"
							style="display: inline;">
							<input type="hidden" name="email" value="<%=email%>"> <input
								type="hidden" name="name" value="<%=fullName%>"> <input
								type="hidden" name="leaveType" value="<%=leaveType%>">
							<input type="hidden" name="startDate" value="<%=startDate%>">
							<input type="hidden" name="endDate" value="<%=endDate%>">
							<input type="hidden" name="status" value="<%=status%>">
							<button type="submit"  action="SendEmailServlet"   class="btn btn-sm btn-outline-primary">Send
								Mail</button>
						</form>

					</td>
				</tr>
				<%
				}
				if (!hasData) {
				%>
				<tr>
					<td colspan="7" class="text-center">No approved or rejected
						leave requests available.</td>
				</tr>
				<%
				}
				} catch (Exception e) {
				e.printStackTrace();
				%>
				<tr>
					<td colspan="7" class="text-center text-danger">Error loading
						leave data.</td>
				</tr>
				<%
				} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				%>
			</tbody>
		</table>

		<div class="text-center mt-4">
			<a href="adminDashboard.jsp" class="btn btn-primary">Back to
				Dashboard</a>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
