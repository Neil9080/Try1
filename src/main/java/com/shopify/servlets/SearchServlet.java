package com.shopify.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.security.auth.message.config.AuthConfigFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.If;

import com.shopify.connection.ConnectionProvider;
import com.shopify.controllers.ProductController;
import com.shopify.models.ProductModel;

/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SearchServlet() {
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
			ProductController controller = new ProductController(ConnectionProvider.getconnection());
			String action = request.getParameter("action");
			String page = request.getParameter("from");
			List<ProductModel> list = null;
			if (action.equals("filter") && page.equals("admin")) {
				// this is the fitering for admin page. only by category and brand

				String cat = request.getParameter("category");
				String brd = request.getParameter("brand");

				if (cat.equals("all") && brd.equals("all")) {
					list = controller.getAllProd(); // geting all the products
					request.getSession(false).setAttribute("filterproducts", list);
				} else if (cat.equals("all") && !brd.equals("all")) {
					list = controller.getProdByBrand(brd); // filtering by brand
					request.getSession(false).setAttribute("filterproducts", list);
				} else if (brd.equals("all") && !cat.equals("all")) {
					list = controller.getProdByCategotry(cat); // filtering by category
					request.getSession(false).setAttribute("filterproducts", list);
				} else {
					list = controller.getProdByCatbrd(cat, brd); // filtering by both category and brand
					request.getSession(false).setAttribute("filterproducts", list);
				}
				response.sendRedirect(request.getContextPath() + "/admin/Products.jsp");
			} else if (action.equals("filter") && page.equals("user")) {
				// this is filtering for user
				String cat = request.getParameter("category");
				String brd = request.getParameter("brand");
				int price = Integer.parseInt(request.getParameter("price"));
				int star = Integer.parseInt(request.getParameter("star"));

				if (cat.equals("all") && brd.equals("all") && price == 0 && star == 0) {
					list = controller.getAllProd(); // getting all products
					request.getSession(false).setAttribute("filterproducts", list);

				} else if (cat.equals("all") && !brd.equals("all") && price == 0 && star == 0) {
					list = controller.getProdByBrand(brd); // filtering by brand
					request.getSession(false).setAttribute("filterproducts", list);

				} else if (brd.equals("all") && !cat.equals("all") && price == 0 && star == 0) {
					list = controller.getProdByCategotry(cat); // filtering by category
					request.getSession(false).setAttribute("filterproducts", list);

				} else if (!brd.equals("all") && !cat.equals("all") && price == 0 && star == 0) {
					list = controller.getProdByCatbrd(cat, brd); // filtering by category
					request.getSession(false).setAttribute("filterproducts", list);

				} else {
					list = controller.getSearch(brd, cat, price, star); // filtering by brand, category, price and stars
					request.getSession(false).setAttribute("filterproducts", list);
				}
				response.sendRedirect(request.getContextPath() + "/Pages/index.jsp");

			} else if (action.equals("search") && page.equals("user")) {
				// filtering according to searched value
				String key = request.getParameter("key");
				list = controller.getSearchKey(key);
				request.getSession(false).setAttribute("filterproducts", list);
				response.sendRedirect(request.getContextPath() + "/Pages/index.jsp");
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
