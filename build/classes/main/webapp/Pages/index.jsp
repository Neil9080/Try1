<%@page import="java.util.List"%>
<%@page import="com.shopify.models.ProductModel"%>
<%@page import="com.shopify.controllers.ProductController"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Home Page</title>
<%
String path = request.getContextPath();
%>
<link rel="stylesheet" href=<%=path + "/Pages/styles/productcard.css"%>
	type="text/css"></link>
<style>
.index-container>.banner {
	height: 65vh;
	width: 95%;
	margin: 10px auto;
}

.banner img {
	width: 100%;
	height: 100%;
}

.products-container {
	width: 95%;
	display: grid;
	grid-template-columns: 23.5% 23.5% 23.5% 23.5%;
	padding: 10px;
	margin: 10px auto;
	gap: 15px;
	height: max-content;
}

.product-card {
	background-color: #fff;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	margin: 15px;
	padding: 20px;
	width: 99%;
	box-sizing: border-box;
	transition: transform 0.3s, box-shadow 0.3s;
	height: max-content;
}

.ratings {
	display: flex;
	height: 30px;
	margin: 2px;
}

.ratings svg {
	color: rgb(255, 136, 0);
}
</style>
</head>
<body>
	<%
	//getting the list of all the products
	ProductController con = new ProductController(ConnectionProvider.getconnection());
	List<ProductModel> products = con.getAllProd();
	request.setAttribute("products", products);
	%>
	<!-- Including the navbar and message page -->
	<%@include file="../Components/Navbar.jsp"%>
	<%@include file="../Components/PopMessage.jsp"%>
	<div class="index-container">
		<div class="banner">
			<img src="../pictures/webimages/banner2.jpg" class="active">
		</div>
		<%@include file="../Components/FilterNav.jsp"%>
		<div class="products-container">
			<c:choose>
				<c:when test="${filterprod ==null}">
					<!-- Displaying all the products when the filtered products is null  -->
					<c:forEach items="${products }" var="prod">
						<a href="single.jsp?id=${prod.id}">
							<div class="product-card">
								<c:set var="img" value='../pictures/products/${prod.img}'></c:set>
								<img src="${img}" alt="prodimg" class="product-image">
								<h2 class="product-title">${prod.name}</h2>
								<div class="ratings">
									<c:forEach var="star" begin="1" end="${prod.stars}">
										<svg fill="currentColor" viewBox="0 0 20 20"
											xmlns="http://www.w3.org/2000/svg">
                    	<path
												d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                 		 </svg>
									</c:forEach>
								</div>
								<p class="product-price">Rs. ${prod.price}</p>
							</div>

						</a>
					</c:forEach>
				</c:when>

				<c:otherwise>

					<c:choose>
						<c:when test="${filterprod.size()==0 }">
							<h1>No Products Found</h1>
						</c:when>
						<c:otherwise>
							<!-- Displaying the filtered products of user according to their choice -->
							<c:forEach items="${filterprod}" var="prod">
								<a href="single.jsp?id=${prod.id}">
									<div class="product-card">
										<c:set var="img" value="../pictures/products/${prod.img}"></c:set>
										<img src="${img}" alt="Product Image" class="product-image">
										<h2 class="product-title">${prod.name}</h2>
										<div class="ratings">
											<c:forEach var="star" begin="1" end="${prod.stars}">
												<svg fill="currentColor" viewBox="0 0 20 20"
													xmlns="http://www.w3.org/2000/svg">
                    <path
														d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                  </svg>
											</c:forEach>
										</div>
										<p class="product-price">Rs. ${prod.price}</p>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
		<%@include file="../Components/Footer.jsp"%>
	</div>
</body>
</html>