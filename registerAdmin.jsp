<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register New Admin - Employee Management System</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .register-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            transition: all 0.3s ease;
        }

        .register-container:hover {
            transform: scale(1.02);
            box-shadow: 0 12px 36px rgba(0, 0, 0, 0.2);
        }

        h2 {
            margin-bottom: 30px;
            color: #343a40;
            font-weight: bold;
            text-align: center;
        }

        .form-control {
            border-radius: 30px;
        }

        .btn-custom {
            border-radius: 30px;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #ffc107;
            transform: scale(1.05);
        }

        label {
            color: #495057;
            font-weight: 500;
        }

        .text-center a {
            color: #007bff;
            text-decoration: underline;
            margin-top: 10px;
            display: inline-block;
        }

        .text-center a:hover {
            color: #0056b3;
        }
    </style>
</head>

<body>

    <div class="register-container">
        <h2>Register New Admin</h2>

        <form action="RegisterAdminServlet" method="post">
            <div class="form-group">
                <label for="username">Admin Username</label>
                <input type="text" class="form-control" id="username" name="username" placeholder="Enter Admin Username" required>
            </div>

            <div class="form-group">
                <label for="password">Admin Password</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Enter Admin Password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
            </div>

            <button type="submit" class="btn btn-warning btn-block btn-custom">Register</button>
        </form>

        <div class="text-center mt-3">
            <a href="adminLogin.jsp">Already have an account? Login here</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
