<%@page import="com.shopify.models.CartModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.shopify.models.UserModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Navbar</title>
</head>
<style>
*{
    margin: 0;
    padding: 0;
}
body{
	background-color: rgb(201, 201, 201);
}

.nav{
    display: flex;
    align-items: center;
    height: 9vh;
    width: 98vw;
    padding: 10px;
    margin-bottom:20px;
    position:sticky;
	top:0;
    background-color: #222222;
    color: #ffffff;
    

}
.logo{
    height: 100%;
    width: 20%;
    font-size: x-larger;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    color:white;
}
.logo>a{
	margin-left:20px;
	color:white;
	  font-size: x-larger;
   
}

.search-box{
    width: 50%;
    height: 80%;
    
}
.search-box>form{
    height: 100%;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
}
.search-box form>input{
    border: 4px solid black;
    width: 80%;
    height: 70%;
    border: none;
    padding: 5px;
    background-color: rgb(219, 219, 219);
}
.search-box form>button{
    width: 20%;
    height: 90%;
     background-color: #ff5e00;
     color:white;
     font-weight:bold;
     letter-spacing:1.5;
     font-size:large;
    border:none;
}

.links>a{
    text-align:center;
    justify-content:center;
    padding: 7px;
    margin: 5px;
    width:33.33%;
}

.links>form{
    width: 20%;
    height: 100%;
}
.links>form>input{
    width: 100%;
    height: 100%;
    background-color: #ff2400;
    border:none;
    color: white;
    padding: 7px;
    margin: 5px;
    font-weight: bold;
    letter-spacing:1.2px;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
.links{
    display: flex;
    width: 25%;
    justify-content:center;
    margin-left:170px;
    margin-right:20px;
    align-items: center;
}
#logbtn, #regbtn{
	width:80%;
	color:white;
	margin-left:30px;
	background-color: #6a0dad !important;
	border-radius:10px;
	padding:8px;
	display:flex !important;
	align-items:center !important;
	justify-centent:center !important;
}
a{
    color: black;
    text-decoration: none;
    font-weight: bold;
    display:flex;
    align-items:center;
    letter-spacing:1.2px;
    margin-left:5px;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;

}
	
.links>a img{
	width:80px;
	height:70px;
	border-radius:50%;
	margin-top:10px;
}

.links>form>input:hover{
	transform:scale(1.05);
	cursor:pointer;
	background-color:white;
	color:black;
}
.img-a{
	color:white !important;
	font-size:20px;
}

	
</style>
<body>
<%
int items=0;
if(session.getAttribute("cart_items") !=null){
 ArrayList<CartModel> cart_item =(ArrayList<CartModel>) session.getAttribute("cart_items");
 items = cart_item.size(); //getting the cart items list size 
}
//getting the loggedin user
	UserModel user1 =(UserModel) session.getAttribute("user");
if(user1 !=null){
	request.setAttribute("user", user1); //setting the user to request
}else{
	request.setAttribute("user", null);
}
%>
    <div class="nav">
        <div class="logo">
            <a href="index.jsp">Shopify</a>
        </div>
        <div class="search-box">
            <form action="../SearchServlet?action=search&from=user" method="post">
                <input type="text" placeholder="Search.." name="key">
                <button type="submit">Search</button>
            </form>
        </div>
        <div class="links">
        <c:choose>
        <c:when test="${user ==null}">
        	 <a href="../Pages/Login.jsp" id="logbtn">LogIn</a>
            <a href="../Pages/Register.jsp" id="regbtn">Register</a>
        </c:when>
        <c:otherwise>
        <c:set var="img" value='../pictures/users/${user.img}'></c:set>
        <!-- Displaying the user profile image -->
        	 <a href="ProfilePage.jsp"><img src="${img}" class="cart-img"></a>
        	 <!-- Displaying the amount of items in cart -->
            <a href="Cart.jsp" class="img-a"><img src="../pictures/webimages/cart.jpg" class="cart-img">(<%= items%>)</a>
            <form action="../LoginServlet?action=logout" method="post"> <input type="submit" value="LogOut"></form>
        </c:otherwise>
        </c:choose>
   
        </div>
    </div>
</body>
</html>