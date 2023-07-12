<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<style>
body{
	display:flex;
	align-items:center;
	justify-conetnt:center;
	flex-direction:column;
	
}
.form {
  margin:50px auto 10px auto;
  background-color: #fff;
  display: block;
  padding: 1rem;
  max-width: 35vw;
  border-radius: 0.5rem;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

.form-title {
  font-size: 1.25rem;
  line-height: 1.75rem;
  font-weight: 600;
  text-align: center;
  color: #000;
}

.input-container {
  position: relative;
}

.input-container input, .form button {
  outline: none;
  border: 1px solid #e5e7eb;
  margin: 8px 0;
}

.input-container input {
  background-color: #fff;
  padding: 1rem;
  padding-right: 3rem;
  font-size: 0.875rem;
  line-height: 1.25rem;
  width: 80%;
  border-radius: 0.5rem;
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
}

.submit {
  display: block;
  padding-top: 0.75rem;
  padding-bottom: 0.75rem;
  padding-left: 1.25rem;
  padding-right: 1.25rem;
  background-color: #4F46E5;
  color: #ffffff;
  font-size: 0.875rem;
  line-height: 1.25rem;
  font-weight: 500;
  width: 100%;
  border-radius: 0.5rem;
  text-transform: uppercase;
}

.signup-link {
  color: #6B7280;
  font-size: 0.875rem;
  line-height: 1.25rem;
  text-align: center;
}

.signup-link a {
  text-decoration: underline;
}
</style>
</head>
<body>
<!-- this is the forget password page that is redirected while user forgrt their password -->
<%@include file="../Components/PopMessage.jsp" %>
    <form class="form" action="../RegisterServlet?action=forgotpass" method="post">
       <p class="form-title">Change your account password</p>
        <div class="input-container">
          <input type="email" placeholder="Enter email" name="email">
          <span>
          </span>
      </div>
       <div class="input-container">
          <input type="number" placeholder="Enter security pin" name="pin">
          <span>
          </span>
      </div>
      <div class="input-container">
          <input type="password" placeholder="Enter password" name="newpass">
        </div>
       <div class="input-container">
          <input type="password" placeholder="Confirm Password" name="conpass">
        </div>
         <button type="submit" class="submit">
        Change Password
      </button>

      <p class="signup-link">
      <a href="Login.jsp">Go To Login Page</a>
      	Note: The security pin is the pin that you entered while registering to this website
      </p>
   </form>

</body>
</html>