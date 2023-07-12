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
import javax.sound.midi.Soundbank;

import com.mysql.cj.Session;
import com.shopify.models.CartModel;

/**
 * Servlet implementation class IncreaseServelt
 */
@WebServlet("/IncreaseServelt")
public class IncreaseServelt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IncreaseServelt() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try(PrintWriter out = response.getWriter() ){
			int id = Integer.parseInt(request.getParameter("id"));
			String action = request.getParameter("action"); 
			ArrayList<CartModel> cart_items =(ArrayList<CartModel>) request.getSession().getAttribute("cart_items");
			if(cart_items !=null) {
			for(CartModel c:cart_items) {
				if(c.getId()==id)
				{
					int qty = c.getQty();
					if(action.equals("inc")) {
						//increasing the quantity if the cart items
						qty++;
						c.setQty(qty);
					}else if(action.equals("dec") && c.getQty()>1) {
						//decreasing the quantity if it is greater than 0
						qty--;
						c.setQty(qty);
					}else {
						//removing the item if quantity is below 1
						cart_items.remove(cart_items.indexOf(c));
					}
					
					response.sendRedirect(request.getContextPath()+"/Pages/Cart.jsp");
				}
				
			}
			}
		}catch (Exception e) {
			// TODO: handle exception
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
