<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@page import="com.mysql.cj.conf.ConnectionPropertiesTransform"%>
<%@page import="com.shopify.controllers.CartController"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shopify.models.CartModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="styles/cart.css" type="text/css">
<meta charset="ISO-8859-1">
<title>Cart Page</title>
</head>
<%
	int totals=100;
	ArrayList<CartModel> cart_items =(ArrayList<CartModel>) session.getAttribute("cart_items");
	if(cart_items != null){
	CartController obj = new CartController(ConnectionProvider.getconnection());
	List<CartModel> items = obj.getCartProd(cart_items); //getting the list of all the products in cart
	if(items !=null){
		request.setAttribute("cart_items", items);
		for(CartModel c:items){
			totals=totals+(c.getQty()*c.getPrice());  //calculating the total price
		}
	}
	}else{
		request.setAttribute("cart_items", null);
	}
%>
<body>

<%@include file="../Components/Navbar.jsp" %>
<%@include file="../Components/PopMessage.jsp" %>
<div class='cart-page-container'>
        <div class='cart-page-heading'>
            <h1 class='cart-page-title'>Your Cart</h1>
        </div>
        <div class='cart-page-main'>
            <h1>Products</h1>
            <h1>Name</h1>
            <h1>Quantity</h1>
            <h1>Size</h1>
            <h1>Brand</h1>
            <h1>Total</h1>
            <h1>  </h1>
        </div>
<c:choose>
	<c:when test="${(cart_items==null) || cart_items.size()<1}">
		<h1>Cart is empty</h1>
	</c:when>
	<c:otherwise>
        <div class='cart-page-items'>
        <!-- Iterating through the Arraylist to obtain cart items  -->
        <c:forEach var="x" items="${cart_items }">
        	<div class='cart-prod-container'>
        <div class='cart-prod'>
        <c:set var="img" value='../pictures/products/${x.img}'></c:set>
              <img src="${img}" alt="prod"></img>
        </div>
        <div class='cart-prod'>
          <h2 class='cart-prod-title'>${x.name}</h2>
        </div>
        <div class='cart-prod'>
        <div class='cart-prod-qty'>
         <form action="../IncreaseServelt?action=inc&id=${x.id}" method="post"><button type="submit">+</button></form>
          <h3 class='cart-prod-num'>${x.qty}</h3>
          <form action="../IncreaseServelt?action=dec&id=${x.id}" method="post"><button type="submit">-</button></form>
          </div>
        </div>
         <div class='cart-prod'>
          <h3 class='cart-prod-brand'>${x.size}</h3>
        </div>
        <div class='cart-prod'>
          <h3 class='cart-prod-brand'>${x.brand}</h3>
        </div>
        <div class='cart-prod'>
        <c:set var="total" value="${x.price * x.qty}"/>
          <h3 class='cart-prod-rup'>Rs.<c:out value="${ total}"/></h3>
        </div>
        <div class='cart-prod'>
          <div class='cart-prod-remove'>
           <form action="../IncreaseServelt?action=rem&id=${x.id}" method="post"><button type="submit">X</button></form/>
          </div>
        </div>
    </div>
         </c:forEach>
        </div>
        <div class='cart-total'>
            <div class='total-price'>
 <!-- Displaying the total price -->
                <h2>Subtotal: <%=totals-100 %></h2>
                <h2>Delivery Charge: Rs. 100</h2>
                <h2>Total: Rs. <%=totals%></h2>
            </div>
        </div>
        <div class='proceed-btn'>
            <a href="ShippingInfo.jsp" class='proceed'>Proceed To Checkout</a>
        </div>
	</c:otherwise>
</c:choose>
	</div>
</body>
</html>