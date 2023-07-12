<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Register Page</title>
<style>
body {
	margin: 0;
	padding: 0;
	background: #f2f2f2;
	font-family: sans-serif;
}

.register-box {
	width: 40vw;
	height: auto;
	background: #fff;
	margin: 10px 29vw;
	color: #000;
	padding: 70px 30px;
	box-shadow: 0 15px 25px rgba(0, 0, 0, 0.5);
	border-radius: 10px;
}

.register-box h1 {
	margin: 0;
	padding: 0 0 20px;
	text-align: center;
	font-size: 28px;
}

.register-box label {
	margin: 0;
	padding: 0;
	font-weight: bold;
	display: block;
}

.register-box input[type="text"], .register-box input[type="number"],
	.register-box input[type="password"], .register-box input[type="email"],
	.register-box input[type="tel"] {
	width: 100%;
	margin-bottom: 20px;
	padding: 4px;
	border: none;
	border-bottom: 1px solid #ccc;
	font-family: sans-serif;
	font-size: 16px;
	color: #555;
	outline: none;
	background: transparent;
}

.register-box input[type="file"] {
	margin-bottom: 20px;
	padding: 4px;
	font-family: sans-serif;
	font-size: 16px;
	color: #555;
	outline: none;
	background: transparent;
}

.register-box input[type="submit"] {
	border: none;
	outline: none;
	height: 40px;
	width: 20%;
	background: #333;
	color: #fff;
	font-size: 18px;
	border-radius: 20px;
}

.register-box input[type="submit"]:hover {
	cursor: pointer;
	background: #ffc107;
	color: #000;
}

.register-box a {
	color: #000;
	font-size: 14px;
	text-decoration: none;
	line-height: 30px;
	display: block;
	text-align: center;
}

.register-box a:hover {
	color: #ffc107;
}

.note {
	margin: 10px;
	paddiong: 10px;
}
</style>
</head>
<body>
	<!-- This is the register page -->
	<%@include file="../Components/Navbar.jsp"%>
	<%@include file="../Components/PopMessage.jsp"%>
	<div class="register-box">
		<h1>Register</h1>
		<form action="../RegisterServlet?action=register"
			enctype='multipart/form-data' method="post">
			<label>Name</label> <input type="text" name="name"
				placeholder="Enter name" required> <label>Phone</label> <input
				type="tel" name="phone" placeholder="Enter phone number" required>
			<label>Email</label> <input type="email" name="email"
				placeholder="Enter email" required> <label>Password</label>
			<input type="password" name="password" placeholder="Enter password"
				required> <label>Address</label> <input type="text"
				name="address" placeholder="Enter address" required> <label>Security
				Pin</label> <input type="number" name="pin" placeholder="Enter Security pin"
				required> <label>Profile Image</label> <input type="file"
				name="img" required> <input type="submit" value="Register">
		</form>
		<a href="Login.jsp">Already registered?</a>
		<p class="note">Note : This security pin is important when you
			forget your password.</p>
	</div>