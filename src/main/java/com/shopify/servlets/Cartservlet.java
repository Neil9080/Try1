package com.shopify.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shopify.models.CartModel;

/**
 * Servlet implementation class Cartservlet
 */
@WebServlet("/Cartservlet")
public class Cartservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Cartservlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html");
		try (PrintWriter out = response.getWriter()) {
			// defining new ArrayList of CartModel class for storing the cart items
			ArrayList<CartModel> cartitems = new ArrayList<>();
			int id = Integer.parseInt(request.getParameter("id"));
			String size = request.getParameter("size");
			int qty = Integer.parseInt(request.getParameter("qty"));
			CartModel item = new CartModel();
			item.setId(id);
			item.setQty(qty);
			item.setSize(size);

			HttpSession session = request.getSession(false);
			ArrayList<CartModel> cart_list = (ArrayList<CartModel>) session.getAttribute("cart_items");
			if (cart_list == null) {
				// admin the cart items to list
				cartitems.add(item);
				session.setAttribute("cart_items", cartitems);
				session.setAttribute("page", "cart");
				session.setAttribute("successmessage", "Product Added to cart");
				response.sendRedirect(request.getContextPath() + "/Pages/Cart.jsp");
			} else {
				cartitems = cart_list;
				boolean exists = false;
				for (CartModel c : cart_list) {
					// checking if the item exists or not
					if (c.getId() == id) {
						exists = true;
					}
				}

				if (exists == false) {
					// adding new product to cart if not exists
					cartitems.add(item);
					session.setAttribute("cart_items", cartitems);
					session.setAttribute("page", "cart");
					session.setAttribute("successmessage", "Product added to cart");
					response.sendRedirect(request.getContextPath() + "/Pages/Cart.jsp");
				} else {
					// if the product exists, sending the message to the user
					session.setAttribute("page", "cart");
					session.setAttribute("errormessage", "Product already added to cart");
					response.sendRedirect(request.getContextPath() + "/Pages/Cart.jsp");
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
