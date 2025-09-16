<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/Employee_management";
    String dbUser = "root";
    String dbPassword = "abc@123";
    String idStr = request.getParameter("id");

    if (idStr != null) {
        int id = Integer.parseInt(idStr);
        try (
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM admins WHERE id = ?");
        ) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("adminList.jsp");
%>
