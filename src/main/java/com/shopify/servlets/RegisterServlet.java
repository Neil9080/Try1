package com.shopify.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.FileAttribute;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.shopify.connection.ConnectionProvider;
import com.shopify.controllers.UserController;
import com.shopify.encryption.PasswordEncryption;
import com.shopify.models.ProductModel;
import com.shopify.models.UserModel;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")

//setting the limits for image upload
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
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
			UserController controller = new UserController(ConnectionProvider.getconnection());
			// registering the new user
			if (action.equals("register")) {
				// getting all the required parameters
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String pass = request.getParameter("password");
				String phone = request.getParameter("phone");
				String address = request.getParameter("address");
				int pin = Integer.parseInt(request.getParameter("pin"));
				Part filepart = request.getPart("img");

				String img = email + filepart.getSubmittedFileName();
				PasswordEncryption encryption = new PasswordEncryption();
				// encrypting the password of the user
				String encpass = encryption.encrypt(email, pass);

				UserModel user = new UserModel(name, email, encpass, img, address, phone, pin);

				// saving the user to database
				if (controller.registerUser(user)) {
					request.getSession(false).setAttribute("page", "login");
					request.getSession(false).setAttribute("successmessage", "Registration Successfull");
					response.sendRedirect(request.getContextPath() + "/Pages/Login.jsp");
					// path of the image uploading folder
					String pathString = "C:\\\\Users\\\\avish\\\\OneDrive\\\\Desktop\\\\jsp\\\\Shopify\\\\src\\\\main\\\\webapp\\\\pictures\\\\users\\\\";
					String endPathString = pathString + img;
					boolean created = new File(endPathString).createNewFile();
					if (created) {
						Files.copy(filepart.getInputStream(), Paths.get(endPathString),
								StandardCopyOption.REPLACE_EXISTING);
					}
					return;
				} else {
					request.getSession(false).setAttribute("page", "register");
					request.getSession(false).setAttribute("errormessage", "Some Error Occured, Please try again");
					response.sendRedirect(request.getContextPath() + "/Pages/Register.jsp");
					return;
				}

				// updating the user's inforamtion
			} else if (action.equals("update")) {
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String pass = request.getParameter("password");
				String phone = request.getParameter("phone");
				String address = request.getParameter("address");
				Part filepart = request.getPart("img");
				int pin = Integer.parseInt(request.getParameter("pin"));
				int id = Integer.parseInt(request.getParameter("id"));
				UserModel user = controller.getUserbyId(id);
				String img = null;
				boolean upimg = false;
				if (filepart.getSubmittedFileName().length() > 0) {
					// checking if user has uploaded new profile image or not
					upimg = true;
					img = email + filepart.getSubmittedFileName();
				} else {
					img = user.getImg();
				}
				PasswordEncryption encryption = new PasswordEncryption();
				// encrypting the password of the user
				String encpass = encryption.encrypt(email, pass);
				UserModel updatedUser = new UserModel(name, email, encpass, img, address, phone, pin);
				// updating user information
				if (controller.updateUser(id, updatedUser)) {
					request.getSession(false).setAttribute("page", "login");
					request.getSession(false).setAttribute("successmessage", "User Updated");
					response.sendRedirect(request.getContextPath() + "/Pages/Login.jsp");
					if (upimg) {
						String pathString = "C:\\Users\\avish\\OneDrive\\Desktop\\jsp\\Shopify\\src\\main\\webapp\\pictures\\users\\";
						String endPathString = pathString + img;
						boolean created = new File(endPathString).createNewFile();
						boolean deleted = new File(pathString + user.getImg()).delete();
						if (created) {
							Files.copy(filepart.getInputStream(), Paths.get(endPathString),
									StandardCopyOption.REPLACE_EXISTING);
						}
						if (deleted) {
							// deleting previously uploaded image
							System.out.println("Image deleted");
						}
					}
					return;
				}
			}
			// for forgeting password
			else if (action.equals("forgotpass")) {
				int pin = Integer.parseInt(request.getParameter("pin"));
				String email = request.getParameter("email");
				String pass = request.getParameter("newpass");
				String conpass = request.getParameter("conpass");
				try {
					// checking if confirm password and password is equal
					if (pass.equals(conpass)) {
						UserModel user = controller.getUserbyEmailPin(email, pin);
						// checking if user exists or not
						if (user.getPassword() != null && user.getEmail() != null && user.getId() != 0) {
							// decryping the password and storing the password in database
							PasswordEncryption encryption = new PasswordEncryption();
							// encrypting the password of the user
							String encpass = encryption.encrypt(email, pass);
							boolean updated = controller.updatePassword(user.getId(), encpass);

							if (updated) {
								// if password is updated sending the user to login page
								request.getSession(false).setAttribute("page", "login");
								request.getSession(false).setAttribute("successmessage",
										"Password Changed Sucessfully");
								response.sendRedirect(request.getContextPath() + "/Pages/Login.jsp");
							} else {
								request.getSession(false).setAttribute("page", "forgot");
								request.getSession(false).setAttribute("errormessage",
										"Error Occured. please try again");
								response.sendRedirect(request.getContextPath() + "/Pages/ForgetPassword.jsp");
							}

						} else {
							// incase of error sending to same page
							request.getSession(false).setAttribute("page", "forgot");
							request.getSession(false).setAttribute("errormessage", "No user found");
							response.sendRedirect(request.getContextPath() + "/Pages/ForgetPassword.jsp");
						}

					} else {
						request.getSession(false).setAttribute("page", "forgot");
						request.getSession(false).setAttribute("errormessage", "Password and confirm does not match");
						response.sendRedirect(request.getContextPath() + "/Pages/ForgetPassword.jsp");
					}

				} catch (Exception e) {
					e.printStackTrace();
					request.getSession(false).setAttribute("page", "forgot");
					request.getSession().setAttribute("errormessage", "Error occured. Please try again");
					response.sendRedirect(request.getContextPath() + "/Pages/ForgetPassword.jsp");
				}

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
