package com.shopify.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.jasper.compiler.JspUtil;

import com.shopify.models.ProductModel;
import com.shopify.models.UserModel;

public class UserController {
	private Connection conn;

	public UserController(Connection conn) {
		this.conn = conn;
	}

	// registering the new user into the database
	public boolean registerUser(UserModel user) {
		boolean save = false;
		try {
			String query = "insert into users (fullname,email,password,img,address,phone,pin) values(?,?,?,?,?,?,?)";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setString(1, user.getName());
			prep.setString(2, user.getEmail());
			prep.setString(3, user.getPassword());
			prep.setString(4, user.getImg());
			prep.setString(5, user.getAddress());
			prep.setString(6, user.getPhone());
			prep.setInt(7, user.getPin());
			prep.executeUpdate();
			save = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return save;
	}

	// geting user by their email
	public UserModel getUser(String email) {
		UserModel user = null;
		try {
			String query = "select * from users where email=?";
			PreparedStatement stat = conn.prepareStatement(query);
			stat.setString(1, email);
			ResultSet set = stat.executeQuery();

			if (set.next()) {
				user = new UserModel();
				user.setEmail(set.getString("email"));
				user.setId(set.getInt("id"));
				user.setPassword(set.getString("password"));
				user.setAddress(set.getString("address"));
				user.setPhone(set.getString("phone"));
				user.setName(set.getString("fullname"));
				user.setImg(set.getString("img"));
				user.setIsadmin(set.getInt("isadmin"));
				user.setPin(set.getInt("pin"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return user;

	}

	// geting user by their id
	public UserModel getUserbyId(int id) {
		UserModel user = new UserModel();
		try {
			String query = "select * from users where id=?";
			PreparedStatement pre = this.conn.prepareStatement(query);
			pre.setInt(1, id);
			ResultSet set = pre.executeQuery();
			if (set.next()) {
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setAddress(set.getString("address"));
				user.setPhone(set.getString("phone"));
				user.setName(set.getString("fullname"));
				user.setImg(set.getString("img"));
				user.setIsadmin(set.getInt("isadmin"));
				user.setPin(set.getInt("pin"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return user;
	}

	// getting user by their email and pin while forgeting password
	public UserModel getUserbyEmailPin(String email, int pin) {
		UserModel user = new UserModel();
		try {
			String query = "select * from users where email=? and pin=?";
			PreparedStatement pre = this.conn.prepareStatement(query);
			pre.setString(1, email);
			pre.setInt(2, pin);
			ResultSet set = pre.executeQuery();
			if (set.next()) {
				user.setId(set.getInt("id"));
				user.setEmail(set.getString("email"));
				user.setPassword(set.getString("password"));
				user.setAddress(set.getString("address"));
				user.setPhone(set.getString("phone"));
				user.setName(set.getString("fullname"));
				user.setImg(set.getString("img"));
				user.setIsadmin(set.getInt("isadmin"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	// fetching all the users from database
	public List<UserModel> getAllUser() {
		List<UserModel> list = new ArrayList<>();
		try {
			String query = "select * from users";
			PreparedStatement pre = this.conn.prepareStatement(query);
			ResultSet set = pre.executeQuery();
			while (set.next()) {
				UserModel user = new UserModel();
				user.setEmail(set.getString("email"));
				user.setId(set.getInt("id"));
				user.setPassword(set.getString("password"));
				user.setAddress(set.getString("address"));
				user.setPhone(set.getString("phone"));
				user.setName(set.getString("fullname"));
				user.setImg(set.getString("img"));
				user.setIsadmin(set.getInt("isadmin"));

				list.add(user);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

	// updating the user profile
	public boolean updateUser(int id, UserModel user) {
		boolean save = false;
		try {
			String query = "update users set fullname=?,email=?,password=?,img=?,address=?,phone=?,pin=? where id=?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setString(1, user.getName());
			prep.setString(2, user.getEmail());
			prep.setString(3, user.getPassword());
			prep.setString(4, user.getImg());
			prep.setString(5, user.getAddress());
			prep.setString(6, user.getPhone());
			prep.setInt(7, user.getPin());
			prep.setInt(8, id);
			prep.executeUpdate();
			save = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return save;
	}

	// this is for changing the password
	public boolean updatePassword(int id, String password) {
		boolean save = false;
		try {
			String query = "update users set password=? where id=?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setString(1, password);
			prep.setInt(2, id);
			prep.executeUpdate();
			save = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return save;
	}

	// counting the total registered user for admin dashboard
	public int countTotalusers() {
		int total = 0;
		try {
			String query = "select count(id) from users";
			PreparedStatement prep = this.conn.prepareStatement(query);
			ResultSet set = prep.executeQuery();
			if (set.next()) {
				total = set.getInt("count(id)");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return total;
	}

	// changing existing user to admin
	public boolean updateisadmin(int id) {
		boolean save = false;
		try {
			String query = "update users set isadmin=1 where id=?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setInt(1, id);
			prep.executeUpdate();
			save = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return save;
	}

}
