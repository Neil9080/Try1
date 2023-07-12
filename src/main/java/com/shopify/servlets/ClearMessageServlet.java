package com.shopify.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ClearMessageServlet
 */
@WebServlet("/ClearMessageServlet")
public class ClearMessageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public ClearMessageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		try(PrintWriter out = response.getWriter() ){
			HttpSession session = request.getSession(false);
			String page = (String) session.getAttribute("page");
			if(session.getAttribute("errormessage") !=null) {
				session.removeAttribute("errormessage");
			}
			if(session.getAttribute("successmessage") !=null) {
				session.removeAttribute("successmessage");
			}
			//sending user back to their respective page after the message is cleared by them
			if(page.equals("login")) {
				response.sendRedirect(request.getContextPath()+"/Pages/Login.jsp");
			}else if(page.equals("index")) {
				response.sendRedirect(request.getContextPath()+"/Pages/index.jsp");
			}else if(page.equals("register")) {
				response.sendRedirect(request.getContextPath()+"/Pages/Register.jsp");
			}else if(page.equals("cart")) {
				response.sendRedirect(request.getContextPath()+"/Pages/Cart.jsp");
			}else if(page.equals("forgot")) {
				response.sendRedirect(request.getContextPath()+"/Pages/ForgetPassword.jsp");
			}else if(page.equals("admin")) {
				response.sendRedirect(request.getContextPath()+"/admin/AdminDashboard.jsp");
			}else if(page ==null) {
				response.sendRedirect(request.getContextPath()+"/Pages/index.jsp");
			}else if (page.equals("myorder")) {
				response.sendRedirect(request.getContextPath()+"/Pages/Myorders.jsp");
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
