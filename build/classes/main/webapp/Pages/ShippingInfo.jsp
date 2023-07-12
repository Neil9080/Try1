<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Shipping</title>
<style>

.container{
	display: flex;
	width:90vw;
	align-items:center;
	justify-content:center;
}
	.card {
  background-color: #fff;
  border-radius: 10px;
  padding: 20px;
  width: 40vw;
  display: flex;
  flex-direction: column;
}

.title {
  font-size: 24px;
  font-weight: 600;
  text-align: center;
}

.form {
  margin: 20px;
  display: flex;
  flex-direction: column;
}

.group {
  position: relative;
}

.form .group label {
  font-size: 14px;
  color: rgb(99, 102, 102);
  position: absolute;
  top: -10px;
  left: 10px;
  background-color: #fff;
  transition: all .3s ease;
}

.form .group input,
.form .group textarea {
  padding: 10px;
  border-radius: 5px;
  border: 1px solid rgba(0, 0, 0, 0.2);
  margin-bottom: 20px;
  outline: 0;
  width: 100%;
  background-color: transparent;
}

.form .group input:placeholder-shown+ label, .form .group textarea:placeholder-shown +label {
  top: 10px;
  background-color: transparent;
}

.form .group input:focus,
.form .group textarea:focus {
  border-color: #3366cc;
}

.form .group input:focus+ label, .form .group textarea:focus +label {
  top: -10px;
  left: 10px;
  background-color: #fff;
  color: #3366cc;
  font-weight: 600;
  font-size: 14px;
}

.form .group textarea {
  resize: none;
  height: 100px;
}

.form button {
  background-color: #3366cc;
  color: #fff;
  border: none;
  border-radius: 5px;
  padding: 10px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.form button:hover {
  background-color: #27408b;
}
	
</style>
</head>
<body>
<!-- this is the page that holds the shipping information during the order palcement -->
<%@include file="../Components/Navbar.jsp" %>
<div class="container">
<div class="card">
  <span class="title">Shipping Information</span>
  <form class="form" action="../ShippingServlet?action=placeorder" method="post">
    <div class="group">
    <input type="text" required="" name="name">
    <label for="name">Billname</label>
    </div>
	<div class="group">
    <input type="phone" id="email" name="phone">
    <label for="phone">Phone</label>
    </div>
	<div class="group">
    <textarea id="comment" name="address" rows="5"></textarea>
    <label for="comment">Address</label>
	</div>
    <button type="submit" >Proceed</button>
  </form>
</div>
</div>
</body>
</html>