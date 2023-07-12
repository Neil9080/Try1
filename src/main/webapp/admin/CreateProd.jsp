<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Product</title>
<style>
body {
	background: #f2f2f2;
}

.section_form {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
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
	margin-top: 20px;
}
</style>
</head>
<body>
	<section class="section_form">
		<!-- creating new product form -->
		<h1>Create Product</h1>
		<form id="consultation-form" class="feed-form"
			enctype='multipart/form-data'
			action="../AdminCrudServlet?action=createprod" method="post">
			<input name="name" required placeholder="Name" type="text"> <input
				name="category" required placeholder="Category"> <input
				name="brand" required placeholder="Brand" type="text"> <input
				name="stock" required placeholder="Stock" type="number"> <input
				name="stars" required placeholder="Rating" type="number" max="5"
				min="1"> <input name="price" required placeholder="Price"
				type="number"> <input type="file" name="img"
				placeholder="produc image" required>
			<textarea name="desc" placeholder="Product Description" rows="10"
				cols="10" required></textarea>
			<button class="button_submit">Create Product</button>
		</form>
	</section>
</body>
</html>