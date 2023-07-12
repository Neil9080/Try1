<%@page import="com.shopify.models.UserModel"%>
<%@page import="com.shopify.controllers.UserController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.shopify.models.OrderModel"%>
<%@page import="java.util.List"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.controllers.OrderController"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Orders of Each Customers</title>
<link rel="stylesheet" href="../Components/component.css"
	type="text/css"></link>
<link rel="stylesheet" href="styles/singleorder.css">
<style>
header>img {
	width: 200px;
	height: 200px;
	border-radius: 50%;
}
</style>
</head>

<body>
	<%
	UserModel curuser = null;
	if (request.getParameter("userId") != null) {
		//getting userid from params
		int userId = Integer.parseInt(request.getParameter("userId"));
		UserController usercon = new UserController(ConnectionProvider.getconnection());
		curuser = usercon.getUserbyId(userId);
		if (curuser != null) {
			request.setAttribute("user", curuser);
			OrderController con = new OrderController(ConnectionProvider.getconnection());
			List<OrderModel> orders = con.getOrdersById(userId); //fetching all the orders of a particular cusotmer 
			if (orders != null) {
		request.setAttribute("orders", orders);
			}
		}

	}
	%>

	<!-- Navbar of admin -->
	<%@include file="Adminnav.jsp"%>
	<header>
		<img src="<%="../pictures/users/" + curuser.getImg()%>">
		<h1>
			Orders Of
			<%=curuser.getName()%>
		</h1>
	</header>
	<c:choose>
		<c:when test="${orders.size()>0}">
			<c:forEach var="order" items="${orders }">
				<div class="container">
					<div class="order-card">
						<c:set var="img" value='../pictures/products/${order.prodImg}'></c:set>
						<img src="${img}" alt="Bluetooth Speaker">
						<div class="order-info">
							<h3>${order.prodname}</h3>
							<p>Order ID: ${order.orderid}</p>
							<p>Quantity: ${order.qty }</p>
							<p>
								Total: <span class="price">Rs. ${order.total}</span>
							</p>
							<p>Date: ${order.orderDate}</p>
							<p>Status: ${order.status }</p>
						</div>
						<div class="buttons">
							<c:choose>
								<c:when test="${order.status=='pending'}">
									<div class="button cancel">
										<a
											href="../AdminCrudServlet?action=updateorder&status=canceled&id=${order.orderid}">Cancel
											Order</a>
									</div>
									<div class="button status">
										<a
											href="../AdminCrudServlet?action=updateorder&status=completed&id=${order.orderid}">Complete
											Order</a>
									</div>
									<div class="button status">
										<a
											href="../AdminCrudServlet?action=updateorder&status=accepted&id=${order.orderid}">Accepted</a>
									</div>
								</c:when>
								<c:when test="${order.status=='canceled'}">
									<div class="button cancel">Order was canceled</div>
								</c:when>
								<c:when test="${order.status=='accepted'}">
									<div class="button cancel">
										<a
											href="../AdminCrudServlet?action=updateorder&status=canceled&id=${order.orderid}">Cancel
											Order</a>
									</div>
									<div class="button status">
										<a
											href="../AdminCrudServlet?action=updateorder&status=completed&id=${order.orderid}">Complete
											Order</a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="button status">Completed</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<h1>No Orders Placed Yet</h1>
		</c:otherwise>
	</c:choose>
</body>
</html>
