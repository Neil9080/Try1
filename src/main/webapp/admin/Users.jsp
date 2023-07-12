<%@page import="com.shopify.models.UserModel"%>
<%@page import="java.util.List"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.controllers.UserController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Users</title>
<% String path= request.getContextPath() ;%>
<link rel="stylesheet"  href=<%=path+"/admin/styles/orders.css"%>></link>
<style>
header>a{
	color:white;
}
tbody img {
    display: block;
    height: auto;
    max-width: 100%;
    border-radius:50%;
    padding-right:20px;
}
.none{
	background-color:transparent !important;
}
</style>
</head>
<body>
<%
//fetching all the users from the database
	UserController con = new UserController(ConnectionProvider.getconnection());
	List<UserModel> users = con.getAllUser();
	request.setAttribute("users", users);
%>
	<%@include file="Adminnav.jsp" %>
	 <div class="admin-main">
        <div class="left">
            <div class="admin-links">
                <a href="AdminDashboard.jsp">Admin Dashboard</a>
                <a href="Products.jsp">Manage Products</a>
                <a href="Orders.jsp">Manage Orders</a>
                <a href="Users.jsp" class="active">Manage Users</a>
            </div>
        </div>
        <div class="right">
	<header>
		<h1>Users</h1>
		<!-- changing the existing user to admin -->
		<a href="AddNewAdmin.jsp">Change Existing User To Admin</a>
	</header>
	<main>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>User Image</th>
					<th>User Name</th>
					<th>User Email</th>
					<th>User Phone</th>
					<th>User Address</th>
					<th>View Orders</th>
				</tr>
			</thead>
			<tbody>
			<c:choose >
			
				<c:when test="${users.size()>0}">
					<c:forEach var="user" items="${users}">
				<tr>
					<td>${user.id}</td>
					 <c:set var="img" value="../pictures/users/${user.img}"></c:set>
					<td><img src="${img}" alt="Product 1" width="100"></td>
					<td>${user.name }</td>
					<td>${user.email}</td>
					<td>${user.phone }</td>
					<td>${user.address}</td>
					<td class="delivered">
					<a href="SingleOrder.jsp?userId=${user.id}" class="none">View Orders</a>
					</td>
				</tr>
				</c:forEach>
				</c:when>
				<c:otherwise>
							<h1>No Users till now</h1>
				</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</main>
</div>
</body>
</html>