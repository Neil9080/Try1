package com.shopify.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopify.connection.ConnectionProvider;
import com.shopify.models.ReviewModel;
import com.shopify.models.UserModel;

public class ReviewController {
	private Connection conn;
	public ReviewController(Connection conn) {
		this.conn=conn;
	}
	
	//saving the product review in the review table 
	public boolean saveReview(ReviewModel review) {
		boolean isSaved = false;
		try {
			
			String query ="insert into reviews(userid,prodid,stars,comm) values (?,?,?,?)";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setInt(1, review.getUserid());
			prep.setInt(2,review.getProdid());
			prep.setInt(3, review.getStars());
			prep.setString(4, review.getComm());
			prep.executeUpdate();
			isSaved=true;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return isSaved;
		
	}
	
	//geting the all reviews of the product
	public List<ReviewModel> getAllreviewById(int prodid) {
		List<ReviewModel> reviews =new ArrayList<ReviewModel>();
		try {
			UserController con = new UserController(ConnectionProvider.getconnection()); 
			UserModel user=null;
			String query="select * from reviews where prodid=?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setInt(1, prodid);
			ResultSet rs =prep.executeQuery();
			while (rs.next()) {
				ReviewModel review = new ReviewModel() ;
				review.setRevid(rs.getInt("revid"));
				review.setUserid(rs.getInt("userid"));
				review.setProdid(rs.getInt("prodid"));
				review.setStars(rs.getInt("stars"));
				review.setComm(rs.getString("comm"));
				review.setDate(rs.getDate("date"));
				user= con.getUserbyId(rs.getInt("userid"));
				if(user !=null) {
					review.setUsername(user.getName());
					review.setUserimg(user.getImg());
				}
				
				reviews.add(review);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return reviews;
		
	}
}
