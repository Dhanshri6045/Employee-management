<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
    // Retrieve logged-in username from session
    String username = (String) session.getAttribute("username");
  //  if (username == null) {
  //      response.sendRedirect("login.jsp");
  //      return;
  //  }

    // Retrieve form data
    String leaveType = request.getParameter("leaveType");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String reason = request.getParameter("reason");

    // Database connection variables
    String jdbcURL = "jdbc:mysql://localhost:3306/your_database_name"; // Update DB name
    String dbUser = "root"; // Replace with your DB username
    String dbPassword = "your_password"; // Replace with your DB password

    Connection conn = null;
    PreparedStatement getEmpIdStmt = null;
    PreparedStatement insertLeaveStmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Get employee_id from employees table using username
        String getEmpIdSQL = "SELECT id FROM employees WHERE username = ?";
        getEmpIdStmt = conn.prepareStatement(getEmpIdSQL);
        getEmpIdStmt.setString(1, username);
        rs = getEmpIdStmt.executeQuery();

        if (rs.next()) {
            int employeeId = rs.getInt("id");

            // Insert leave request
            String insertSQL = "INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, reason) VALUES (?, ?, ?, ?, ?)";
            insertLeaveStmt = conn.prepareStatement(insertSQL);
            insertLeaveStmt.setInt(1, employeeId);
            insertLeaveStmt.setString(2, leaveType);
            insertLeaveStmt.setDate(3, Date.valueOf(startDate));
            insertLeaveStmt.setDate(4, Date.valueOf(endDate));
            insertLeaveStmt.setString(5, reason);

            int rowsInserted = insertLeaveStmt.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("leaveRequest.jsp?status=Leave+request+submitted+successfully");
            } else {
                response.sendRedirect("leaveRequest.jsp?status=Failed+to+submit+leave+request");
            }
        } else {
            response.sendRedirect("leaveRequest.jsp?status=Employee+not+found");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("leaveRequest.jsp?status=Error+occurred:+Please+try+again");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (getEmpIdStmt != null) getEmpIdStmt.close(); } catch (Exception e) {}
        try { if (insertLeaveStmt != null) insertLeaveStmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
