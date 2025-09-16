<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <title>Employee Registration</title>
    <link rel="stylesheet" href="./css/style.css">
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        function validateForm() {
            var name = document.forms["registrationForm"]["name"].value;
            var email = document.forms["registrationForm"]["email"].value;
            var password = document.forms["registrationForm"]["password"].value;
            var confirmPassword = document.forms["registrationForm"]["confirmPassword"].value;
            var department = document.forms["registrationForm"]["department"].value;
            var role = document.forms["registrationForm"]["role"].value;

            if (name == "" || email == "" || password == "" || confirmPassword == "" || department == "" || role == "") {
                alert("Please fill out all required fields.");
                return false;
            }

            if (password !== confirmPassword) {
                alert("Passwords do not match.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
  <!--  -->  <div class="container">
        <h2>Employee Registration</h2>
        <form name="registrationForm" action="RegisterServlet" onsubmit="return validateForm()" method="post">
        <div class="form-group">
                <label for="name">User Name:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <div class="form-group">
                <label for="phone">Contact Number:</label>
                <input type="text" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="department">Department:</label>
                <select id="department" name="department" required>
                    <option value="">Select Department</option>
                    <option value="HR">HR</option>
                    <option value="IT">IT</option>
                    <option value="Finance">Finance</option>
                    <option value="Marketing">Marketing</option>
                </select>
            </div>
            <div class="form-group">
                <label for="role">Designation/Role:</label>
                <select id="role" name="role" required>
                    <option value="">Select Role</option>
                    <option value="Manager">Manager</option>
                    <option value="Developer">Developer</option>
                    <option value="Analyst">Analyst</option>
                    <option value="Intern">Intern</option>
                </select>
            </div>
            <div class="form-group">
                <label>Gender:</label>
                <label><input type="radio" name="gender" value="Male"> Male</label>
                <label><input type="radio" name="gender" value="Female"> Female</label>
            </div>
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob">
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <textarea id="address" name="address"></textarea>
            </div>
        <button type="submit" class="btn btn-primary btn-block">Register</button>
        
          
            <div class="login">
            <a href="login.jsp" class="btn btn-primary">Login</a>
            </div>
        </form>
    </div>
<!-- Already existing scripts... -->

<script>
    if (window.location.search.includes('success=true')) {
        alert('Registration Successful!');
    }
</script>
</body>
</html>
    