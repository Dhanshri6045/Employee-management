<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Success</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    String message = request.getParameter("message");
    if (message != null) {
%>
<script>
    alert("<%= message %>");
</script>
<%
    }
%>

<div class="container mt-5">
    <div class="alert alert-success text-center p-5 rounded shadow">
        <h1 class="mb-4">🎉 <%= message != null ? message : "Success!" %></h1>
        
        <a href="add_employee.jsp" class="btn btn-primary btn-lg m-2">Add Another Employee</a>
        <a href="adminDashboard.jsp" class="btn btn-success btn-lg m-2">Go to Dashboard</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
