<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Employee Management System</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(135deg, #f8f9fa, #e0e7ff);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            max-width: 420px;
            width: 100%;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #0d6efd;
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
        }

        label {
            color: #333;
            font-weight: 500;
        }

        .form-control {
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 15px;
        }

        .btn-login {
            width: 100%;
            border-radius: 30px;
            font-weight: bold;
            font-size: 16px;
            background-color: #0d6efd;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            background-color: #0b5ed7;
            box-shadow: 0 6px 15px rgba(13, 110, 253, 0.4);
        }

        .btn-register {
            width: 100%;
            margin-top: 15px;
            border-radius: 30px;
            font-weight: bold;
            background-color: #198754;
            color: #fff;
        }

        .btn-register:hover {
            background-color: #157347;
        }

        .text-link {
            color: #6c757d;
            text-align: center;
            margin-top: 20px;
        }

        .text-link a {
            color: #0d6efd;
            text-decoration: none;
        }

        .text-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <div class="login-container">
        <h2>Admin Login</h2>

        <form action="adminLoginServlet" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Admin Username</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="Enter Admin Username" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Admin Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter Admin Password" required>
            </div>

            <button type="submit" class="btn btn-login">Login</button>
        </form>

        <div class="text-link mt-3">
            <a href="index.jsp">← Back to Home</a>
        </div>

        <a href="registerAdmin.jsp" class="btn btn-register mt-3">New Admin? Register Here</a>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
