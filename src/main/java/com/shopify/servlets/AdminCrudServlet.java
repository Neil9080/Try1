package com.shopify.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.jasper.tagplugins.jstl.core.If;

import com.shopify.connection.ConnectionProvider;
import com.shopify.controllers.OrderController;
import com.shopify.controllers.ProductController;
import com.shopify.controllers.UserController;
import com.shopify.models.ProductModel;
import com.shopify.models.UserModel;

/**
 * Servlet implementation class AdminCrudServlet
 */
@WebServlet("/AdminCrudServlet")

//defining sizes for uploading the images
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AdminCrudServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AdminCrudServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try (PrintWriter out = response.getWriter()) {
			ProductController conn = new ProductController(ConnectionProvider.getconnection());
			String action = request.getParameter("action"); // geting the parameter value of action keyword

			// deleting the product according to the id
			if (action.equals("deleteprod")) {
				int id = Integer.parseInt(request.getParameter("id"));
				boolean deleted = conn.deleteProduct(id);
				if (deleted) {
					request.setAttribute("message", "Product Deleted");
					response.sendRedirect(request.getContextPath() + "/admin/Products.jsp");
				}

			}

			// creating new product by admin
			else if (action.equals("createprod")) {
				String name = request.getParameter("name");
				String category = request.getParameter("category");
				String brand = request.getParameter("brand");
				int stock = Integer.parseInt(request.getParameter("stock"));
				int price = Integer.parseInt(request.getParameter("price"));
				int stars = Integer.parseInt(request.getParameter("stars"));
				String desc = request.getParameter("desc");
				Part filepart = request.getPart("img");

				String img = name.replaceAll("\s", "") + filepart.getSubmittedFileName();

				ProductModel prod = new ProductModel(name, category, stock, brand, stars, price, img, desc);
				ProductController controller = new ProductController(ConnectionProvider.getconnection());

				if (controller.createProcuct(prod)) {
					request.getSession().setAttribute("message", "Product Created");
					response.sendRedirect(request.getContextPath() + "/admin/Products.jsp");
					// path of the folder to save image of user
					String endPathString = "C:\\Users\\avish\\OneDrive\\Desktop\\jsp\\Shopify\\src\\main\\webapp\\pictures\\products\\"
							+ img;
					boolean created = new File(endPathString).createNewFile();
					if (created) {
						// replacing the already existed image with same name
						Files.copy(filepart.getInputStream(), Paths.get(endPathString),
								StandardCopyOption.REPLACE_EXISTING);
					}
					return;
				} else {
					request.getSession().setAttribute("message", "Please Fill the form Properly");
					response.sendRedirect(request.getContextPath() + "/admin/CreateProd.jsp");
					return;
				}

			}

			// updating the product
			else if (action.equals("updateprod")) {
				int id = Integer.parseInt(request.getParameter("id"));
				ProductController controller = new ProductController(ConnectionProvider.getconnection());
				ProductModel prevProd = controller.getProdById(id);
				String name = request.getParameter("name");
				String category = request.getParameter("category");
				String brand = request.getParameter("brand");
				int stock = Integer.parseInt(request.getParameter("stock"));
				int price = Integer.parseInt(request.getParameter("price"));
				int stars = Integer.parseInt(request.getParameter("stars"));
				String desc = request.getParameter("desc");
				Part filepart = request.getPart("img");

				String img = null;
				Boolean delprevBoolean = false;
				if (filepart.getSubmittedFileName().length() > 0) {
					// checking if the user has inserted image or not
					delprevBoolean = true;
					img = name.replaceAll("\s", "") + filepart.getSubmittedFileName();
				} else {
					// geting the previous uploaded image
					img = prevProd.getImg();
				}

				ProductModel prod = new ProductModel(name, category, stock, brand, stars, price, img, desc);

				if (controller.updateProduct(id, prod)) {
					request.getSession().setAttribute("message", "Product Updated");
					response.sendRedirect(request.getContextPath() + "/admin/Products.jsp");
					if (delprevBoolean) {
						String pathString = "C:\\Users\\avish\\OneDrive\\Desktop\\jsp\\Shopify\\src\\main\\webapp\\pictures\\products\\";
						String endPathString = pathString + img;
						// uploading new uploaded image
						boolean created = new File(endPathString).createNewFile();
						// deleting the previous image
						boolean deleted = new File(pathString + prevProd.getImg()).delete();
						if (created) {
							System.out.println("image Updated");
							Files.copy(filepart.getInputStream(), Paths.get(endPathString),
									StandardCopyOption.REPLACE_EXISTING);
						}
						if (deleted) {
							System.out.println("Image deleted");
						}
					}

					return;
				} else {
					request.getSession().setAttribute("message", "Please Fill the form Properly");
					response.sendRedirect(request.getContextPath() + "/admin/CreatePord.jsp");
					return;
				}

			}

			// deleting the order according to the id
			else if (action.equals("deleteorder")) {
				try {
					OrderController controller = new OrderController(ConnectionProvider.getconnection());
					int id = Integer.parseInt(request.getParameter("id"));
					boolean success = controller.deleteOrder(id);
					if (success) {
						request.setAttribute("message", "Order deleted successfully");
						response.sendRedirect(request.getContextPath() + "/admin/Orders.jsp");
					} else {
						request.setAttribute("message", "Error Occured");
						response.sendRedirect(request.getContextPath() + "/admin/Orders.jsp");
					}
				} catch (Exception e) {
					e.printStackTrace();
					// TODO: handle exception
				}
			}
			// updating the order
			else if (action.equals("updateorder")) {
				try {
					OrderController controller = new OrderController(ConnectionProvider.getconnection());
					int id = Integer.parseInt(request.getParameter("id"));
					String status = request.getParameter("status");
					boolean success = controller.UpdateOrder(id, status);
					if (success) {
						request.setAttribute("message", "Order updated successfully");
						response.sendRedirect(request.getContextPath() + "/admin/Orders.jsp");
					} else {
						request.setAttribute("message", "Error Occured");
						response.sendRedirect(request.getContextPath() + "/admin/Orders.jsp");
					}
				} catch (Exception e) {
					e.printStackTrace();
					// TODO: handle exception
				}

			}
			// canceling the placed order by admin
			else if (action.equals("cancel")) {
				try {
					OrderController controller = new OrderController(ConnectionProvider.getconnection());
					int id = Integer.parseInt(request.getParameter("id"));
					boolean success = controller.cancelOrder(id);
					if (success) {
						request.setAttribute("message", "Order canceled successfully");
						response.sendRedirect(request.getContextPath() + "/admin/SingleOrder.jsp");
					} else {
						request.setAttribute("message", "Error Occured");
						response.sendRedirect(request.getContextPath() + "/admin/Orders.jsp");
					}
				} catch (Exception e) {
					e.printStackTrace();
					// TODO: handle exception
				}

			}
			// changing the existing user to admin
			else if (action.equals("newadmin")) {
				try {
					int id = Integer.parseInt(request.getParameter("id"));
					UserController controller = new UserController(ConnectionProvider.getconnection());
					if (controller.updateisadmin(id)) {
						response.sendRedirect(request.getContextPath() + "/admin/Products.jsp");
					} else {
						response.sendRedirect(request.getContextPath() + "/admin/AddNewAdmin.jsp");
					}
					;

				} catch (Exception e) {
					e.printStackTrace();
					// TODO: handle exception
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
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
