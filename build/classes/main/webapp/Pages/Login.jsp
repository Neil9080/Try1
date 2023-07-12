<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LogIn Page</title>
<link rel="stylesheet" href="./styles/login.css">
</head>
<body>
<!-- This is the login page -->
<%@include file="../Components/Navbar.jsp" %>	
<%@include file="../Components/PopMessage.jsp" %>
<div class="login-box">
		<h1>Login</h1>
		<form action="../LoginServlet?action=login" method="post">
			<label>Email</label>
			<input type="text" name="email" placeholder="Enter username" required>
			<label>Password</label>
			<input type="password" name="password" placeholder="Enter password" required>
			<a href="ForgetPassword.jsp">Forgot Password</a>
			<input type="submit" value="Login">
		</form>
		<a href="Register.jsp">Not registered yet?</a>
	</div>
</body>
</html>