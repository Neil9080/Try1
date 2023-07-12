
<%@page import="com.shopify.controllers.UserController"%>
<%@page import="com.shopify.controllers.ProductController"%>
<%@page import="com.shopify.connection.ConnectionProvider"%>
<%@page import="com.shopify.controllers.OrderController"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="styles/admindash.css">
    <style>
    .right{
   	 	width: 80vw;
    	display:flex;
	}
	
.dash-card {
	    display: grid;
	    gap: 50px;
	    grid-template-columns: 33% 33% 33%;
	    width: 80%;
	    margin: 10px auto;
}
.card {
	  padding: 1rem;
	  background-color: #fff;
	  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
	  border-radius: 20px;
	  display:flex;
	  border-radius:50%;
	  align-items:center;
	  justify-content:center;
	  flex-direction:column;
	   background-color: rgb(255, 140, 118);
	}



	</style>
</head>
<body>
<%
OrderController ordercon = new OrderController(ConnectionProvider.getconnection());
int totalorders = ordercon.countTotalOrders();
int totalsales = ordercon.totalsales();
int accorders = ordercon.countacceptedOrders();
int comporders = ordercon.countCompletedOrders();
int cancorders = ordercon.countCanceledOrders();

ProductController prodcon = new ProductController(ConnectionProvider.getconnection());
int totalprod = prodcon.countTotalProd();

UserController usercon = new UserController(ConnectionProvider.getconnection());
int totalusers = usercon.countTotalusers();
%>
   <%@include file="Adminnav.jsp" %>
   <div class="admin-main">
        <div class="left">
            <div class="admin-links">
                <a href="AdminDashboard.jsp" class="active">Admin Dashboard</a>
                <a href="Products.jsp">Manage Products</a>
                <a href="Orders.jsp">Manage Orders</a>
                <a href="Users.jsp">Manage Users</a>
            </div>
        </div>
        <div class="right">
        	<div class="dash-card">
				<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Total Orders
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%=totalorders%> 
        		</p>
    		</div>
			</div>
			<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Total Sales
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%= totalsales %> 
        		</p>
    		</div>
			</div>
			<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Completed Orders
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%=comporders %>
        		</p>
    		</div>
			</div>
			<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Accepted Orders
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%= accorders %>
        		</p>
    		</div>
			</div>
			<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Canceled Orders
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%= cancorders %>
        		</p>
    		</div>
			</div>
        	<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Total Users
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%=totalusers %> 
        		</p>
    		</div>
			</div>
			<div class="card">
    				<div class="title">
        				<p class="title-text">
            				Total Products
        				</p>
    			</div>
    			<div class="data">
        		<p>
            		<%=totalprod %>
        		</p>
    		</div>
			</div>
        </div>
        </div>
        </div>
</body>
</html>
