<%@page import="com.shopify.models.ProductModel"%>
<%@page import="java.util.List"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@page import="com.shopify.controllers.ProductController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Filter Nav</title>
<style>
	.filter-main{
		width:90vw;
		margin: 10px auto;
		display:flex;
		height:100px;
		flex-direction:column;
		padding:10px;
	}
	.filterbybrand{
		display:flex;
		width:100%;
		height:100%;
	}
	.filterbycat{
		display:flex;
		width:98%;
		margin:5px auto;
		height:100%;
	}
	.filt-left{
		margin:10px;
		font-size:25px;
		width:20%;
		display:flex;
	}
	.filt-left select, .filt-left option{
		font-size:20px;
		width:90%;
		padding:5px;
		margin-left:5px;
		font-weight:bold;
		border-radius:10px;
		background-color:black;
		color:white;
	}
	.filt-btn input{
		width:250px;
		height:100%;
		background-color:red;
		color:black;
		border:none;
	}
	.filt-btn input:hover{
		background-color:black;
		color:white;
	}
	
	
</style>
</head>
<%
	ProductController cont = new ProductController(ConnectionProvider.getconnection());
	List category = cont.getCategory();  //getting all the category
	List brand = cont.getBrand(); //fretching all the brands
	request.setAttribute("cat", category); //setting the lists to request
	request.setAttribute("brand", brand);
	if (request.getSession(false).getAttribute("filterproducts") != null) {
		//getting the filtered products and setting it to the session
		List<ProductModel> filterprod = (List<ProductModel>) request.getSession(false).getAttribute("filterproducts");
		request.setAttribute("filterprod", filterprod);
	}else{
		request.setAttribute("filterprod", null);
	}
	%>
<body>
	<div class="filter-main">
	<div class="filterbybrand">
	<form class="filterbycat" action="../SearchServlet?action=filter&from=user" method="post">
	<div class="filt-left">
		<select name="category">
		<option value="all">Category</option>
		<!-- iterating the category list -->
			<c:forEach var="cat" items="${cat}">
			<option value="${cat}">${cat}</option>
			</c:forEach>
		</select>
	</div>
	<div class="filt-left">
		<select name="brand">
		<option value="all">Brand</option>
		<!-- Iterating the brand list -->
			<c:forEach var="brand" items="${brand}">
			<option value="${brand}">${brand}</option>
			</c:forEach>
		</select>
	</div>
	<div class="filt-left">
		<select name="price">
			<option value="0">Price</option>
			<option value="5000">Below 5000</option>
			<option value="1000">Below 10000</option>
			<option value="20000">Below 20000</option>
			<option value="50000">Below 50000</option>
		</select>
	</div>
	<div class="filt-left">
		<select name="star">
		<option value="0">Ratings</option>
		<option value="5">5 stars</option>
		<option value="4">Above 4 stars</option>
		<option value="3">Above 3 stars</option>
		<option value="2">Above 2 stars</option>
		</select>
	</div>
	<div class="filt-btn">
	<input type="submit" value="filter">
	</div>
	</form>
	</div>
	</div>
	</body>
	</html>