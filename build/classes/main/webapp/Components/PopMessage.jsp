<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Popup Messages</title>
<style>

.notifications-container {
	  width: 320px;
	  height: 50px;
	  font-size: 0.875rem;
	  line-height: 1.25rem;
	  display: flex;
	  margin:20px auto 10px auto;
	  flex-direction: column;
	  gap: 1rem;
	  position:absolute;
	  top:30vh;
	  left:40%;
	  z-index:99;
	}
	.flex {
	  display: flex;
	}

	.flex-shrink-0 {
	  flex-shrink: 0;
	}

	.error-alert {
	  border-radius: 0.375rem;
	  padding: 1rem;
	  background-color: rgb(254 242 242);
	}

	.error-svg {
	  color: #F87171;
	  width: 1.25rem;
	  height: 1.25rem;
	}

	.error-prompt-heading {
	  color: #991B1B;
	  font-size: 0.875rem;
	  line-height: 1.25rem;
	  font-weight: bold;
	}

	.error-prompt-container {
	  display: flex;
	  flex-direction: column;
	  margin-left: 1.25rem;
	}

	.error-prompt-wrap {
	  margin-top: 0.5rem;
	  color: #B91C1C;
	  font-size: 0.875rem;
	  line-height: 1.25rem;
	}

	.error-prompt-list {
	  padding-left: 1.25rem;
	  margin-top: 0.25rem;
	  list-style-type: disc;
	}
	.notifications-container {
  width: 320px;
  height: auto;
  font-size: 0.875rem;
  line-height: 1.25rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.flex {
  display: flex;
}

.flex-shrink-0 {
  flex-shrink: 0;
}

.success {
  padding: 1rem;
  border-radius: 0.375rem;
  background-color: rgb(240 253 244);
}

.succes-svg {
  color: rgb(74 222 128);
  width: 1.25rem;
  height: 1.25rem;
}

.success-prompt-wrap {
  margin-left: 0.75rem;
}

.success-prompt-heading {
  font-weight: bold;
  color: rgb(22 101 52);
}

.success-prompt-prompt {
  margin-top: 0.5rem;
  color: rgb(21 128 61);
}

.success-button-container {
  display: flex;
  margin-top: 0.875rem;
  margin-bottom: -0.375rem;
  margin-left: -0.5rem;
  margin-right: -0.5rem;
}

.success-button-main {
  padding-top: 0.375rem;
  padding-bottom: 0.375rem;
  padding-left: 0.5rem;
  padding-right: 0.5rem;
  background-color: #ECFDF5;
  color: rgb(22 101 52);
  font-size: 0.875rem;
  line-height: 1.25rem;
  font-weight: bold;
  border-radius: 0.375rem;
  border: none
}

.success-button-main:hover {
  background-color: #D1FAE5;
}

.success-button-secondary {
  padding-top: 0.375rem;
  padding-bottom: 0.375rem;
  padding-left: 0.5rem;
  padding-right: 0.5rem;
  margin-left: 0.75rem;
  background-color: #ECFDF5;
  color: #065F46;
  font-size: 0.875rem;
  line-height: 1.25rem;
  border-radius: 0.375rem;
  border: none;
}
	
</style>
</head>
<body>
<%
	String errormessage = (String)request.getSession(false).getAttribute("errormessage");
	if(errormessage !=null){
		request.setAttribute("errormessage", errormessage);
	}
	String successmessage = (String)request.getSession(false).getAttribute("successmessage");
	if(successmessage !=null){
		request.setAttribute("successmessage", successmessage);
	}
	%>
<c:if test="${errormessage !=null}">
		<div class="notifications-container">
  	<div class="error-alert">
    <div class="flex">
      <div class="flex-shrink-0">
        <a href="../ClearMessageServlet">
        <svg aria-hidden="true" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" class="error-svg">
          <path clip-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" fill-rule="evenodd"></path>
        </svg>
        </a>
      </div>
      <div class="error-prompt-container">
        <p class="error-prompt-heading">
        ${errormessage}
        </p>
      </div>
      </div>
    </div>
  </div>
</div>
</c:if>	
<c:if test="${successmessage !=null}">
<div class="notifications-container">
  <div class="success">
    <div class="flex">
      <div class="flex-shrink-0">
        
        <svg class="succes-svg" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
        </svg>
      </div>
      <div class="success-prompt-wrap">
        <p class="success-prompt-heading">${successmessage}</p>
          <div class="success-button-container">
            <button type="button" class="success-button-secondary"><a href="../ClearMessageServlet">Dismiss</a></button>
          </div>
      </div>
    </div>
  </div>
</div>
</c:if>
</body>
</html>