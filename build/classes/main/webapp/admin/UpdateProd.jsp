<%@page import="com.shopify.models.ProductModel"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@page import="com.shopify.controllers.ProductController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Product</title>
<style>
body{
	
	background: #f2f2f2;
}
.section_form{
	display:flex;
	flex-direction:column;
	align-items:center;
	justify-content:center;
}
.section_form img{
	height:200px;
	width:200px;
	border-radius:50%;
	}
.feed-form {
  margin-top: 36px;
  display: flex;
  flex-direction: column;
  width: 40%;
}

.feed-form input {
  height: 54px;
  border-radius: 5px;
  background: white;
  margin-bottom: 15px;
  border: none;
  padding: 0 20px;
  font-weight: 300;
  font-size: 14px;
  color: #4B4B4B;
}

.button_submit:hover, .feed-form input:hover {
  transform: scale(1.009);
  box-shadow: 0px 0px 3px 0px #212529;
}

.button_submit {
  width: 100%;
  height: 54px;
  font-size: 14px;
  color: white;
  background: red;
  border-radius: 5px;
  border: none;
  font-weight: 500;
  text-transform: uppercase;
  margin-top:20px;
}

</style>
</head>
<%
	int id =Integer.parseInt(request.getParameter("id"));
	ProductController con = new ProductController(ConnectionProvider.getconnection());
	ProductModel product = con.getProdById(id); //getting products by their id
	request.setAttribute("single", product);
	
%>

<body>
<section class="section_form">
<!-- update product page -->
<h1>Update Product</h1>
<img src="<%="../pictures/products/"+product.getImg()%>">
  <form id="consultation-form" class="feed-form" enctype='multipart/form-data' action="../AdminCrudServlet?action=updateprod&id=<%=id%>" method="post">
    <input name="name" required="" placeholder="Name" type="text" value="<%= product.getName()%>">
    <input name="category" required="" placeholder="Category" value="<%= product.getCategory()%>">
    <input name="brand" required="" placeholder="Brand" type="text" value="<%= product.getBrand()%>">
    <input name="stock" required="" placeholder="Stock" type="number" value="<%= product.getStock()%>">
    <input name="stars" required="" placeholder="Rating" type="number" max="5" min="1" value="<%= product.getStars()%>">
    <input name="price" required="" placeholder="Price" type="number" value="<%= product.getPrice()%>">
    <input type="file" name="img" placeholder="product image" value="<%= product.getImg()%>" >
    <textarea name="desc"  rows="10" cols="10" required=""><%= product.getDescription()%></textarea>
    <button class="button_submit">Update Product</button>
  </form>
</section>
</body>
</html>