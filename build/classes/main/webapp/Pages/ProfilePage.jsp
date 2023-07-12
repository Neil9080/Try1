<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Profile</title>
<link rel="stylesheet" href="styles/profile.css"></link>
</head>
<body>
	<!-- This page is showing the information of the logged in user -->
	<%@include file="../Components/Navbar.jsp"%>
	<header> User Profile </header>
	<div class="container">
		<div class="profile-card">
			<div class="right">
				<img src="<%="../pictures/users/" + user1.getImg()%>"
					alt="Profile Picture">
			</div>
			<div class="left">
				<h3><%=user1.getName()%></h3>
				<p>
					Email:
					<%=user1.getEmail()%></p>
				<p>
					Phone:
					<%=user1.getPhone()%></p>
				<p>
					Address:
					<%=user1.getAddress()%></p>
				<p>
					Secret Pin:
					<%=user1.getPin()%></p>
				<a href="Updateprofile.jsp" class="update-button">Update Profile</a>
				<a href="Myorders.jsp" class="update-button">View Orders</a>
			</div>

		</div>
	</div>
</body>
</html>