package com.shopify.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shopify.connection.ConnectionProvider;
import com.shopify.controllers.CartController;
import com.shopify.controllers.OrderController;
import com.shopify.controllers.ProductController;
import com.shopify.models.CartModel;
import com.shopify.models.OrderModel;
import com.shopify.models.ProductModel;
import com.shopify.models.UserModel;

@WebServlet("/ShippingServlet")
public class ShippingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ShippingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try(PrintWriter out = response.getWriter() ){
			String action = request.getParameter("action");
			OrderController controller = new OrderController(ConnectionProvider.getconnection());
			//this is for placing the order and saving it to the order table
			if(action.equals("placeorder")) {
			boolean direct = false;
			String billname = request.getParameter("name");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			HttpSession session = request.getSession();
			ArrayList<CartModel> cart_list = (ArrayList<CartModel>) session.getAttribute("cart_items");
			List<CartModel> items=null;
			if(cart_list != null){
				CartController obj = new CartController(ConnectionProvider.getconnection());
				items = obj.getCartProd(cart_list);  //fetching all the cart items
			}
			//geting the userid of the order
			UserModel user = (UserModel) session.getAttribute("user");
			
			ProductController pro = new ProductController(ConnectionProvider.getconnection());
			for(CartModel c:items) {
				direct=false;
				OrderModel order = new OrderModel(user.getId(), c.getId(), c.getQty(), c.getSize(),
						address, (c.getPrice()*c.getQty()) ,phone,billname);
				if(controller.saveOrder(order)) {
					//saving the order in the order table
					if(pro.updateQty(c)) {
						direct=true;  //updating the stock of the product in product table
					}
					
				}
			}
			if(direct) {
				request.getSession(false).setAttribute("successmessage", "Order Placed Successfully");
				request.getSession(false).setAttribute("page", "index");
				response.sendRedirect(request.getContextPath()+"/Pages/index.jsp");
			}
			}
			//canceling the order
			else if(action.equals("cancelorder")) {
				int id = Integer.parseInt(request.getParameter("id"));
				boolean success = controller.cancelOrder(id);
				if(success) {
					request.getSession(false).setAttribute("successmessage", "Order Canceled");
					request.getSession(false).setAttribute("page", "myorder");
					response.sendRedirect(request.getContextPath()+"/Pages/Myorders.jsp");
				}else {
					request.getSession(false).setAttribute("page", "myorder");
					request.getSession(false).setAttribute("errormessage", "Error Occured. Please try again");
					response.sendRedirect(request.getContextPath()+"/Pages/Myorders.jsp");
				}
			}
		}
			
		catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
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
