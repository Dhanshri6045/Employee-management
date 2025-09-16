<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Employee Management System - Home</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            height: 100vh;
            background: linear-gradient(135deg, #f8b5c5, #fcd4ea);
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Outfit', sans-serif;
        }

        .glass-container {
            background: #ffffff;
            border-radius: 25px;
            padding: 60px 40px;
            max-width: 520px;
            width: 100%;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            position: relative;
        }

        .glass-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15);
        }

        .logo {
            width: 80px;
            height: auto;
            margin-bottom: 25px;
        }

        h1 {
            font-size: 2.5rem;
            color: #333333;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .slogan {
            font-size: 1.1rem;
            color: #666666;
            margin-bottom: 30px;
        }

        .btn-custom {
            display: inline-block;
            width: 220px;
            height: 50px;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            margin: 12px 0;
            border-radius: 30px;
            transition: all 0.3s ease-in-out;
            letter-spacing: 1px;
            border: none;
        }

        .btn-employee {
            background: linear-gradient(to right, #00c6ff, #0072ff);
            color: #fff;
        }

        .btn-admin {
            background: linear-gradient(to right, #ffb347, #ffcc33);
            color: #fff;
        }

        .btn-custom:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>

<body>

    <div class="glass-container">
        <img src="./images/logo.jpg" alt="EMS Logo" class="logo">
        <h1>Employee Management System</h1>
        <p class="slogan">Empowering your workforce with efficiency</p>

        <a href="login.jsp" class="btn btn-custom btn-employee">Employee Login</a><br>
        <a href="adminLogin.jsp" class="btn btn-custom btn-admin">Admin Login</a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
