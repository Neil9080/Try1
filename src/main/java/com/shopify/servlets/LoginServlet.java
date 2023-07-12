package com.shopify.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.http.HttpRequest;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.midi.Soundbank;

import com.shopify.connection.ConnectionProvider;
import com.shopify.controllers.UserController;
import com.shopify.encryption.PasswordEncryption;
import com.shopify.models.UserModel;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try (PrintWriter out = response.getWriter()) {
			String action = request.getParameter("action");
			if (action.equals("login")) {
				// geting email and password entered by the user
				String email = request.getParameter("email");
				String pass = request.getParameter("password");
				UserController controller = new UserController(ConnectionProvider.getconnection());

				PasswordEncryption encryption = new PasswordEncryption();

				// finding the user accroding to their email
				UserModel user = controller.getUser(email);
				boolean login = false;
				if (user != null) {
					// decrypting the password and matching it with given password
					String decpass = encryption.decrypt(user.getPassword(), user.getEmail());
					if (decpass.equals(pass)) {
						login = true;
					}
					user.setPassword(decpass);
				}
				if (login) {
					// setting the user in session and sending to the index page
					HttpSession session = request.getSession();
					session.setAttribute("user", user);
					Cookie userId = new Cookie("userId", Integer.toString(user.getId()));
					userId.setMaxAge(60 * 60);
					response.addCookie(userId);
					request.getSession().setAttribute("successmessage", "Login Successfull");
					if (user.getIsadmin() == 1) {
						// if user is admin sending to admin page
						request.getSession().setAttribute("page", "admin");
						response.sendRedirect(request.getContextPath() + "/admin/AdminDashboard.jsp");
						return;
					} else if (user.getIsadmin() == 0) {
						// if user is not admin sending to index page
						request.getSession().setAttribute("page", "index");
						response.sendRedirect(request.getContextPath() + "/Pages/index.jsp");
						return;
					}
				} else {
					// sending to login page in case of any error
					request.getSession(false).setAttribute("page", "login");
					request.getSession(false).setAttribute("errormessage", "Invalid Email or Password");
					response.sendRedirect(request.getContextPath() + "/Pages/Login.jsp");

					return;
				}

			}

			else {
				// thhis is for logout of the user
				HttpSession session = request.getSession(false);
				session.setAttribute("user", null); // setting the user session to null
				session.removeAttribute("errormessage");
				session.setAttribute("successmessage", "LogOut Successfull");
				response.sendRedirect(request.getContextPath() + "/Pages/index.jsp");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
