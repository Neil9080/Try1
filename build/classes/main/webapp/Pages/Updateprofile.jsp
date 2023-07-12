<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Profile</title>
<style>
body {
	background: #f2f2f2;
}

.section_form {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.center {
	display: flex;
	width: 100%;
	height: 150px;
	align-items: center;
	justify-content: center;
	margin-bottom: 20px;
}

.center img {
	height: 140px;
	width: 140px;
	border-radius: 50%;
	margin-bottom: 10px;
}

.feed-form {
	margin-top: 36px;
	display: flex;
	flex-direction: column;
	width: 40%;
	background-color: white;
	padding: 20px;
}

.feed-form input {
	height: 54px;
	border-radius: 5px;
	background: white;
	margin-bottom: 15px;
	border: none;
	padding: 0 20px;
	font-weight: 300;
	font-size: 14px;
	color: #4B4B4B;
}

.button_submit:hover, .feed-form input:hover {
	transform: scale(1.009);
	box-shadow: 0px 0px 3px 0px #212529;
}

.button_submit {
	width: 100%;
	height: 54px;
	font-size: 14px;
	color: white;
	background: red;
	border-radius: 5px;
	border: none;
	font-weight: 500;
	text-transform: uppercase;
	margin-top: 20px;
}
</style>
</head>
<body>
	<!-- This is the page for updating the user information -->
	<%@include file="../Components/Navbar.jsp"%>
	<section class="section_form">
		<h1>Update Profile</h1>
		<form id="consultation-form" class="feed-form"
			enctype='multipart/form-data'
			action="../RegisterServlet?action=update&id=<%=user1.getId()%>"
			method="post">
			<div class="center">
				<img src="<%="../pictures/users/" + user1.getImg()%>">

			</div>
			<input type="text" name="name" placeholder="Enter new name"
				value=<%=user1.getName()%> required> <input type="tel"
				name="phone" placeholder="Enter phone number"
				value=<%=user1.getPhone()%> required> <input type="email"
				name="email" placeholder="Enter new email"
				value=<%=user1.getEmail()%> required> <input type="text"
				name="password" placeholder="Enter new Password"
				value=<%=user1.getPassword()%> required> <input type="text"
				name="address" placeholder="Enter address"
				value=<%=user1.getAddress()%> required> <input
				type="number" name="pin" placeholder="Enter your new pin"
				value=<%=user1.getPin()%> required> <label>Profile
				Image</label> <input type="file" name="img">
			<button class="button_submit">Update Profile</button>
		</form>
	</section>
</body>
</html>