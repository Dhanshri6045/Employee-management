<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #ffe6e6;
            text-align: center;
            padding-top: 100px;
        }
        .error-box {
            background-color: #fff;
            border: 1px solid #ff4d4d;
            padding: 40px;
            display: inline-block;
            border-radius: 10px;
        }
        h1 {
            color: #cc0000;
        }
        p {
            font-size: 16px;
        }
        a {
            text-decoration: none;
            color: #0066cc;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h1>Something Went Wrong</h1>
        <p>We encountered an error during your registration process.</p>
        <p>Please try again later or contact support.</p>
        <br>
        <a href="register.jsp">Go back to Registration Page</a>
    </div>
</body>
</html>
