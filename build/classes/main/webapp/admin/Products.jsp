<%@page import="org.apache.catalina.Server"%>
<%@page import="com.shopify.models.ProductModel"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@page import="com.shopify.controllers.ProductController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Products</title>
<%
String path = request.getContextPath();
%>
<link rel="stylesheet" href="<%=path + "/admin/styles/products.css"%>"></link>
<style>
.product-card {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0px 3px 10px rgba(0, 0, 0, 0.1);
	padding: 20px;
	margin-bottom: 20px;
	height: max-content;
	max-height: max-content;
}
</style>
</head>
<%
ProductController con = new ProductController(ConnectionProvider.getconnection());
List<ProductModel> products = con.getAllProd(); //geting all the products list
request.setAttribute("products", products);
List category = con.getCategory(); //fetching all the category
List brand = con.getBrand(); //fetching all the brand
request.setAttribute("cat", category);
request.setAttribute("brand", brand);
if (request.getSession(false).getAttribute("filterproducts") != null) {
	//fetching the filtered and dearched [products]
	List<ProductModel> filterprod = (List<ProductModel>) request.getSession(false).getAttribute("filterproducts");
	request.setAttribute("filterprod", filterprod);
} else {
	request.setAttribute("filterprod", null);
}
%>
<body>
	<%@include file="Adminnav.jsp"%>
	<div class="admin-main">
		<div class="left">
			<div class="admin-links">
				<a href="AdminDashboard.jsp">Admin Dashboard</a> <a
					href="Products.jsp" class="active">Manage Products</a> <a
					href="Orders.jsp">Manage Orders</a> <a href="Users.jsp">Manage
					Users</a>
			</div>
		</div>
		<div class="right">
			<div class="container">
				<div class="create">
					<form action="../SearchServlet?action=filter&from=admin"
						method="post" class="filter">
						<div class="flex">
							<div class="first">
								<p>Filter by Category:</p>
								<select name="category">
									<option value="all">All</option>
									<!-- Iterating through category list usinf foreach loop of jstl -->
									<c:forEach var="cat" items="${cat}">
										<option value="${cat}">${cat}</option>
									</c:forEach>
								</select>
							</div>
							<div class="first">
								<p>Filter by Brand:</p>
								<select name="brand">
									<option value="all">All</option>
									<!--  using jstl foreach loop to iterate all the brands list -->
									<c:forEach var="brand" items="${brand}">
										<option value="${brand}">${brand}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<input type="submit" value="Filter">
					</form>
					<a href="CreateProd.jsp">Create Products</a>
				</div>
				<div class="grid">
					<!--  itrating through all the products list if filtered product is not available -->
					<c:choose>
						<c:when test="${filterprod ==null}">
							<c:forEach var="prod" items="${products}">
								<div class="product-card">
									<c:set var="img" value='../pictures/products/${prod.img}'></c:set>
									<img src="${img}" alt="prodimg">
									<h3>${prod.name}</h3>
									<p>
										<span>Price:</span> Rs. ${prod.price}
									</p>
									<p>
										<span>Brand: </span> ${prod.brand}
									</p>
									<p class="flex">
										<c:forEach var="star" begin="1" end="${prod.stars}">
											<svg fill="currentColor" viewBox="0 0 20 20"
												xmlns="http://www.w3.org/2000/svg">
                		<path
													d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
             			 </svg>
										</c:forEach>
									</p>

									<p>
										<span>Stock: </span>${prod.stock}</p>
									<p>
										<span>Category: </span>${prod.category}</p>
									<p>${prod.description}</p>
									<div class="product-buttons">
										<a class="update" href="UpdateProd.jsp?id=${prod.id}">Update</a>
										<a class="delete"
											href="../AdminCrudServlet?action=delete&id=${prod.id}">Delete</a>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:when test="${filterprod.size()==0 }">
							<h1>No Products Found</h1>
						</c:when>
						<c:otherwise>
							<!-- iterating through all the filtered products -->
							<c:forEach items="${filterprod}" var="prod">
								<div class="product-card">
									<c:set var="img" value='../pictures/products/${prod.img}'></c:set>
									<img src="${img}" alt="prodimg">
									<h3>${prod.name}</h3>
									<p>
										<span>Price:</span> Rs. ${prod.price}
									</p>
									<p>
										<span>Brand: </span> ${prod.brand}
									</p>
									<p class="flex">
										<c:forEach var="star" begin="1" end="${prod.stars}">
											<svg fill="currentColor" viewBox="0 0 20 20"
												xmlns="http://www.w3.org/2000/svg">
                <path
													d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
              </svg>
										</c:forEach>
									</p>
									<p>
										<span>Stock: </span>${prod.stock}</p>
									<p>
										<span>Caterogy: </span>${prod.category}</p>
									<p>${prod.description}</p>
									<div class="product-buttons">
										<a class="update" href="UpdateProd.jsp?id=${prod.id}">Update</a>
										<a class="delete"
											href="../AdminCrudServlet?action=deleteprod&id=${prod.id}">Delete</a>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
</body>
</html>