package com.shopify.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shopify.connection.ConnectionProvider;
import com.shopify.controllers.ProductController;
import com.shopify.controllers.ReviewController;
import com.shopify.controllers.UserController;
import com.shopify.models.ProductModel;
import com.shopify.models.ReviewModel;
import com.shopify.models.UserModel;

/**
 * Servlet implementation class reviewServlet
 */
@WebServlet("/reviewServlet")
public class reviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public reviewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		try(PrintWriter out = response.getWriter() ){
			//this is for getting the parameter of review form
			
			int star=Integer.parseInt(request.getParameter("rating"));
			String comm= request.getParameter("desc");
			int prodid = Integer.parseInt(request.getParameter("id"));
			UserModel curuser = (UserModel) request.getSession(false).getAttribute("user"); 
			int userid = curuser.getId();
			ReviewModel review = new ReviewModel(userid,prodid,star,comm);
			UserController usercon = new UserController(ConnectionProvider.getconnection());
			ProductController prodcon = new ProductController(ConnectionProvider.getconnection());
			ProductModel prod = prodcon.getProdById(prodid);
			ReviewController reviewcon= new ReviewController(ConnectionProvider.getconnection());
			ReviewController revcon = new ReviewController(ConnectionProvider.getconnection());
			
			if(curuser !=null && prod !=null) {
				boolean found=false;
				List<ReviewModel> revList = reviewcon.getAllreviewById(prodid);
				for(ReviewModel r: revList) {
					
					if(r.getUserid()== userid) {
						//checking if the user has already reviewed the product or not
						found=true;
						break;
					}
				}
				if(found) {
					//sending back to the index page if the user has already reviewed
					response.sendRedirect(request.getContextPath()+"/Pages/index.jsp");
				}else {
				if(revcon.saveReview(review)) {
					//saving the new review of the product
					int totalStar=1;
					int avgStar=0;
					//counting the average of the rating and updating it to the product rating
					for(ReviewModel r: revList) {
						avgStar = avgStar+r.getStars();
					}
					if(revList.size()>0) {
						totalStar=(int)avgStar/revList.size();
					}else {
						totalStar= star;
					}
					
					
					if(prodcon.updateReview(prodid, totalStar)) {
						response.sendRedirect(request.getContextPath()+"/Pages/index.jsp");
						return;
					}
				}
				}
				//redirecting the user to the index page after review
				response.sendRedirect(request.getContextPath()+"/Pages/index.jsp");
			}
			
		}catch (Exception e) {
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
