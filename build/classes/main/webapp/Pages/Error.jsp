<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Error Page</title>
<style>
body {
  background-color: #f5f5f5;
  font-family: Arial, sans-serif;
  font-size: 16px;
  line-height: 1.5;
  color: #333;
  text-align: center;
}

h1 {
  font-size: 36px;
  margin-top: 100px;
  margin-bottom: 20px;
}

p {
  font-size: 20px;
  margin-bottom: 30px;
}

a {
  background-color: #008CBA;
  border: none;
  color: #fff;
  font-size: 20px;
  padding: 10px 20px;
  border-radius: 5px;
  cursor: pointer;
  text-decoration:none;
}

a:hover {
  background-color: #005f6b;
}

</style>
</head>
<body>
  <% String url = request.getContextPath(); %>
   <h1>Oops, something went wrong!</h1>
    <p>We're sorry, but it looks like there was an error. Please try again later.</p>
    <p>Exception is: <%= exception %>  </p>
    <a href="<%= url+"/Pages/index.jsp" %>">Go to Home Page</a> 
</body>
</html>