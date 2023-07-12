<%@page import="com.shopify.models.OrderModel"%>
<%@page import="java.util.List"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.controllers.OrderController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders</title>
<link rel="stylesheet" href="styles/myorders.css">
</head>
<body>
	<%
	//getting the userId from cookies
	String userId;
	Cookie[] cookies = request.getCookies();

	if (cookies != null) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("userId")) {
		userId = cookie.getValue();
		OrderController con = new OrderController(ConnectionProvider.getconnection());
		//storing the orders of that customer in a list 
		List<OrderModel> orders = con.getOrdersById(Integer.parseInt(userId));
		if (orders != null) {
			request.setAttribute("orders", orders);
		}
		break;
			}
		}
	}
	%>
	<%@include file="../Components/Navbar.jsp"%>
	<%@include file="../Components/PopMessage.jsp"%>
	<header> My Orders </header>
	<c:if test="${orders.size()==0}">
		<h1 style="margin: 20px;">No orders placed yet</h1>
	</c:if>
	<!-- Iterating the list of orders to display ALL the orders -->
	<c:forEach var="order" items="${orders }">
		<div class="container">
			<div class="order-card">
				<c:set var="img" value="../pictures/products/${order.prodImg}"></c:set>
				<img src="${img}" alt="Bluetooth Speaker">
				<div class="order-info">
					<h3>${order.prodname}</h3>
					<p>Order ID: ${order.orderid}</p>
					<p>Quantity: ${order.qty }</p>
					<p>
						Total: <span class="price">Rs. ${order.total}</span>
					</p>
					<p>Date: ${order.orderDate}</p>
				</div>
				<div class="buttons">
					<!-- This is the condition to show particular button in case of order status -->
					<c:choose>
						<c:when test="${order.status=='pending'}">
							<div class="button cancel">
								<a
									href="../ShippingServlet?action=cancelorder&id=${order.orderid}">Cancel
									Order</a>
							</div>
							<div class="button status">${order.status}</div>
						</c:when>
						<c:when test="${order.status=='canceled'}">
							<div class="button cancel">Order was canceled</div>
							<div class="button status">${order.status}</div>
						</c:when>
						<c:otherwise>
							<div class="button status">Completed</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>
