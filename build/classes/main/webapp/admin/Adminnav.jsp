<%@page import="com.shopify.models.UserModel"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Navbar</title>
</head>
 <style>
        body{
        padding: 0%;
        margin: 0%;
        width:100vw;
        height:100vh;
    }
    .admin-nav{
        background-color: rgb(255, 255, 255);
        justify-content: space-between;
        display:flex;
        align-items: center;
        width: 100vw;
        height: 10vh;
        margin-bottom:20px;
    }
    .nav-header{
        Color:rgb(0, 0, 0);
        font-family: Impact, Haettenschweiler, 'Arial Narrow Bold', sans-serif;
        font-weight: bold;
        padding-left: 30px;
        word-spacing:10;
        font-size:23px;
    }
    .ad-pr-log{
        display: flex;
        align-items: center;
        justify-content: space-around;
        padding: 0px 20px;
        width: 15%;
        height: 100%;
    }
    .profile{
        height: 100%;
        width: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .profile img{
        height: 70%;
        width: 70%;
        border-radius: 50%;
        border: 1px solid red;
    }
    .logout{
        height: 50%;
    }
    .logout form{
        height: 100%;
        width: 100%;
    }
    form button{
        border: none;
        padding: 10px;
        color: white;
        font-weight: bold;
        background-color: #FF7F50;
    }
    button:hover{
        background-color: rgb(0, 0, 0);
        color: white;
    }

</style>
<%
//getting the user from session
	UserModel user1 =(UserModel) session.getAttribute("user");
	if(user1 !=null){
		request.setAttribute("user", user1);
	}else{
		request.setAttribute("user", null);
	}
%>
<body>
   <div class="admin-nav">
        <div class="nav-header">
            <h2>Admin Panel</h2>
        </div>
        <div class="ad-pr-log">
            <div class="profile">
            <!-- Showing the profile picture of the user -->
                <img src="<%="../pictures/users/"+user1.getImg()%>" alt="profile">
            </div>
            <div class="logout">
            <!--  this is for logout servlet -->
                <form action="../LoginServlet?action=logout" method="post"><button type="submit">Logout</button></form>
            </div>
        </div>
    </div>
</body>
</html>