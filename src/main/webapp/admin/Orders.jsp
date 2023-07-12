<%@page import="com.shopify.models.OrderModel"%>
<%@page import="java.util.List"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.controllers.OrderController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Order History</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<% String path= request.getContextPath() ;%>
<link rel="stylesheet"  href=<%=path+"/admin/styles/orders.css"%>></link>
<body>
<%
	OrderController con = new OrderController(ConnectionProvider.getconnection());
	List<OrderModel> orders= con.getAllOrders();  //getting the list of all the orders placed
	request.setAttribute("orders", orders);
%>

<%@include file="Adminnav.jsp" %>
	 <div class="admin-main">
        <div class="left">
            <div class="admin-links">
                <a href="AdminDashboard.jsp">Admin Dashboard</a>
                <a href="Products.jsp">Manage Products</a>
                <a href="Orders.jsp"  class="active">Manage Orders</a>
                <a href="Users.jsp">Manage Users</a>
            </div>
        </div>
        <div class="right">
	<header>
		<h1>Order History</h1>
	</header>
	<main>
		<table>
			<thead>
				<tr>
					<th>ID</th>
					<th>Product Image</th>
					<th>Product Name</th>
					<th>Quantity</th>
					<th>Order Date</th>
					<th>Order Total</th>
					<th>Order Status</th>
					<th>Update Order</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
			<c:choose >
			
				<c:when test="${orders.size()>0}">
					<c:forEach var="order" items="${orders}">
				<tr>
					<td>${order.orderid}</td>
					 <c:set var="img" value='../pictures/products/${order.prodImg}'></c:set>
					<td><img src="${img}" alt="Product 1" width="100"></td>
					<td>${order.prodname }</td>
					<td>${order.qty}</td>
					<td>${order.orderDate }</td>
					<td>Rs. ${order.total }</td>
					<td>
					<p>${order.status }</p>
					</td>
					<td>
					<form action="../AdminCrudServlet?action=updateorder&id=${order.orderid}" method="post">
					<select name="status">
						<option  value="completed">Completed</option>
						<option  value="accepted">Accepted</option>
						<option  value="canceled">Cancel</option>
					</select>
					<input type="submit" value="submit"> 
					</form>
					</td>
					<td><a href="../AdminCrudServlet?action=deleteorder&id=${order.orderid}">Delete Order</a></td>
				</tr>
				</c:forEach>
				</c:when>
				<c:otherwise>
				
				<h1>No orders till now</h1>
				</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</main>
</div>
</body>
</html>
