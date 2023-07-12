<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change To Admin</title>
 <% String path= request.getContextPath() ;%>
<link rel="stylesheet"  href=<%=path+"/admin/styles/orders.css"%>></link>
<style>
	.up-ad-form{
		width:90%;
		display:flex;
		align-items:center;
		justify-content:center;
	}
	.up-ad-form>form{
		width:40%;
		margin-top:50px;
		background-color: #1F2833;
		display:flex;
		flex-direction:column;
		padding:50px;
	}
	form>h1{
		color:white;
		letter-spacing:1.5;
	}
	form>p{
	color:white
	}
	form >input{
	padding:5px;
	font-size:20px;
	margin:10px;
	}
	form >input[type="submit"]{
	padding:10px;
	font-size:20px;
	margin:10px;
	background-color:red;
	border:none;
	color:white;
	cursor:pointer;
	border-radius:20px;
	
	}
	
</style>
</head>
<body>
	 <%@include file="Adminnav.jsp" %>
   <div class="admin-main">
        <div class="left">
            <div class="admin-links">
                <a href="AdminDashboard.jsp" class="active">Admin Dashboard</a>
                <a href="Products.jsp">Manage Products</a>
                <a href="Orders.jsp">Manage Orders</a>
                <a href="Users.jsp">Manage Users</a>
            </div>
        </div>
        <div class="right">
        	<div class="up-ad-form">
        	<!--  this form is for changing the existing user to admin -->
        	<form action="../AdminCrudServlet?action=newadmin" method="post">
        		<h1>Change Existing User to admin</h1>
        		<p>Enter the id of the user to change to admin</p>
        		<input type="number" name="id" placeholder="Enter Id" required>
        		<input type="submit">
        	</form>
        		
        	</div>
        </div>
</body>
</html>