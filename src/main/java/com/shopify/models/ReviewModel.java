package com.shopify.models;

import java.sql.Date;

//this is the ReviewMOdel class
public class ReviewModel {
		private int revid;
		private int userid;
		private String userimg;
		private String username;
 		private int prodid;
		private int stars;
		private String comm;
		private Date date;

		
		public ReviewModel(int revid, int userid, int prodid, int stars, String comm, String date, String username,String userimg) {
			this.revid = revid;
			this.userid = userid;
			this.prodid = prodid;
			this.stars = stars;
			this.comm = comm;
			this.userimg=userimg;
			this.username = username;
		}
		
		public ReviewModel( int userid, int prodid, int stars, String comm) {
			this.userid = userid;
			this.prodid = prodid;
			this.stars = stars;
			this.comm = comm;
		}
		public ReviewModel() {}
		
		public int getRevid() {
			return revid;
		}
		public void setRevid(int revid) {
			this.revid = revid;
		}
		public int getUserid() {
			return userid;
		}
		public void setUserid(int userid) {
			this.userid = userid;
		}
		public int getProdid() {
			return prodid;
		}
		public void setProdid(int prodid) {
			this.prodid = prodid;
		}
		public int getStars() {
			return stars;
		}
		public void setStars(int stars) {
			this.stars = stars;
		}
		public String getComm() {
			return comm;
		}
		public void setComm(String comm) {
			this.comm = comm;
		}
		public String getUserimg() {
			return userimg;
		}
		public void setUserimg(String userimg) {
			this.userimg = userimg;
		}
		public Date getDate() {
			return date;
		}
		public void setDate(Date date2) {
			this.date = date2;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}
		
		
		
	}

