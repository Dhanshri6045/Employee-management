<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%
    // Read form data (hidden input and select field)
    String leaveIdStr = request.getParameter("leaveId");
    String newStatus = request.getParameter("status");

    // JDBC Connection settings
    String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
    String dbUser = "root";
    String dbPassword = "abc@123";
    
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Prepare the SQL update statement
        String sql = "UPDATE leave_requests SET status = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, newStatus);
        pstmt.setInt(2, Integer.parseInt(leaveIdStr));

        // Execute update
        int updatedRows = pstmt.executeUpdate();

        if (updatedRows > 0) {
            // Update successful
            session.setAttribute("message", "Leave request updated successfully.");
        } else {
            // No rows updated (wrong ID?)
            session.setAttribute("message", "Failed to update leave request.");
        }

    } catch (Exception e) {
        e.printStackTrace();
        session.setAttribute("message", "Error occurred: " + e.getMessage());
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    // Redirect back to leave requests page
    response.sendRedirect("showLeaves.jsp");
%>
