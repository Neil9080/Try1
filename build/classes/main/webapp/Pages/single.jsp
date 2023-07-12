<%@page import="java.util.List"%>
<%@page import="com.shopify.controllers.ReviewController"%>
<%@page import="com.shopify.models.ReviewModel"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@page import="com.shopify.models.ProductModel"%>
<%@page import="com.shopify.controllers.ProductController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Single Page</title>
<link rel="stylesheet" href="styles/single.css" type="text/css"></link>
</head>
<%
int id = Integer.parseInt(request.getParameter("id"));
ProductController con = new ProductController(ConnectionProvider.getconnection());
ProductModel product = con.getProdById(id);
request.setAttribute("single", product); //fetching the product accroding to the id
ReviewController revcon = new ReviewController(ConnectionProvider.getconnection());
List<ReviewModel> reviews = revcon.getAllreviewById(id); //getting the review of all the products
if (reviews != null || reviews.size() > 0) {
	request.setAttribute("rev", reviews);
} else {
	request.setAttribute("rev", null);
}
%>

<body>
	<%@include file="../Components/Navbar.jsp"%>
	<div class="column">
		<div class="url">
			<a href="index.jsp">Home > Products </a>
		</div>
		<div class="flex-box">
			<div class="left">
				<div class="big-img">
					<img src="<%="../pictures/products/" + product.getImg()%>">
				</div>
			</div>
			<div class="right">
				<!-- Displaying the product information -->
				<form action="../Cartservlet?id=<%=product.getId()%>" method="post">
					<div class="pname"><%=product.getName()%></div>
					<div class="ratings">
						<c:forEach var="star" begin="1" end="${single.stars}">
							<svg fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                    <path
									d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                  </svg>
						</c:forEach>
					</div>
					<div class="price">
						Rs.
						<%=product.getPrice()%></div>
					<div class="size">
						<p>Size :</p>
						<select name="size">
							<option value="M" name="size">Select Size</option>
							<option value="XL" name="size">XL</option>
							<option value="L" name="size">L</option>
							<option value="XXL" name="size">XXL</option>
						</select>
					</div>
					<div class="quantity">
						<p>Quantity :</p>
						<input type="number" min="1" max="5" value="1" name="qty">
					</div>
					<div class="desc">
						<%=product.getDescription()%>
					</div>
					<div class="btn-box">
						<c:if test="${ single.stock < 1}">
							<button>Out Of Stock</button>
						</c:if>
						<c:if test="${ single.stock >= 1}">
							<input type="submit" value="Add to Cart" class="cart-btn">
						</c:if>
					</div>
				</form>
			</div>
		</div>
		<div class="rev-title">Reviews</div>
		<div class="review-container">
			<div class="all-reviews">
				<c:choose>
					<c:when test="${rev.size()<=0 || rev ==null}">
						<p>No reviews Yet</p>
					</c:when>
					<c:otherwise>
						<!-- Displaying all the products reviews -->
						<c:forEach var="rev" items="${rev}">
							<div class="single-review">
								<div class="flex">
									<c:set var="img" value="../pictures/users/${rev.userimg}"></c:set>
									<div class="rev-image">
										<img src="${img}">
									</div>
									<div class="flex-col">
										<p class="rev-name">${rev.username}</p>
										<div class="rev-stars">
											<c:forEach var="star" begin="1" end="${rev.stars}">
												<svg fill="currentColor" viewBox="0 0 20 20"
													xmlns="http://www.w3.org/2000/svg">
                      <path
														d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                    </svg>
											</c:forEach>
										</div>
										<div class="comment">${rev.comm}</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			<c:if test="${user !=null}">
				<!-- This is the review form only appreared if the user is logged in -->
				<div class="rev-form">
					<h1>Leave Your Review</h1>
					<form action="../reviewServlet?id=<%=id%>" method="post">
						<div class="flex">
							<input type="radio" value="5" name="rating" required="required">
							<label>5 stars</label> <input type="radio" value="4"
								name="rating" required="required"> <label>4
								stars</label> <input type="radio" value="3" name="rating"
								required="required"> <label>3 stars</label> <input
								type="radio" value="2" name="rating" required="required">
							<label>2 stars</label>
						</div>
						<textarea cols="50" rows="5" type="text" name="desc"
							placeholder="Leave Comment For The Product..."
							required="required"></textarea>
						<input type="submit"></input>
					</form>
				</div>
			</c:if>
		</div>

	</div>
	<%@include file="../Components/Footer.jsp" %>
</body>
</html>