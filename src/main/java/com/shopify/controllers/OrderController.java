package com.shopify.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.x.protobuf.MysqlxCrud.Update;
import com.shopify.connection.ConnectionProvider;
import com.shopify.models.OrderModel;
import com.shopify.models.ProductModel;

public class OrderController {
	private Connection con;
	public OrderController(Connection con) {
		this.con=con;
	}
	
	//this method saves the orderd in the database
	public boolean saveOrder(OrderModel order) {
		boolean save=false;
		try {
			String query = "insert into orders(userId, prodId,qty,size,address,total,phone,billname) values (?,?,?,?,?,?,?,?)";
			PreparedStatement prep = this.con.prepareStatement(query);
			prep.setInt(1, order.getUserId());
			prep.setInt(2, order.getProdId());
			prep.setInt(3, order.getQty());
			prep.setString(4, order.getSize());
			prep.setString(5, order.getAddress());
			prep.setInt(6, order.getTotal());
			prep.setString(7, order.getPhone());
			prep.setString(8, order.getBillname());
			prep.executeUpdate();
			save = true;	
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return save;
	}
	
	//getting order of each customer by their id ande stroing in List
	public List<OrderModel> getOrdersById(int userId){
		List<OrderModel> orders = new ArrayList<>();
		try {
			String query="select * from orders where userId=?";
			PreparedStatement prep = this.con.prepareStatement(query);
			prep.setInt(1, userId);
			ResultSet rs = prep.executeQuery();
			while(rs.next()) {
				OrderModel order= new OrderModel();
				ProductController con = new ProductController(ConnectionProvider.getconnection());
				order.setOrderid(rs.getInt("orderid"));
				order.setUserId(rs.getInt("userId"));
				order.setProdId(rs.getInt("prodId"));
				order.setBillname(rs.getString("billname"));
				order.setPhone(rs.getString("phone"));
				order.setQty(rs.getInt("qty"));
				order.setSize(rs.getString("size"));
				order.setStatus(rs.getString("status"));
				order.setOrderDate(rs.getDate("date"));
				order.setAddress(rs.getString("address"));
				order.setTotal(rs.getInt("total"));
				ProductModel product = con.getProdById(order.getProdId());
				order.setProdname(product.getName());	
				order.setProdImg(product.getImg());
				orders.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return orders;
	} 
	
	//Getting all the orders of the customers for admin page 
	public List<OrderModel> getAllOrders(){
		List<OrderModel> orders = new ArrayList<>();
		try {
			String query="select * from orders";
			PreparedStatement prep = this.con.prepareStatement(query);
			ResultSet rs = prep.executeQuery();
			while(rs.next()) {
				OrderModel order= new OrderModel();
				ProductController con = new ProductController(ConnectionProvider.getconnection());
				order.setOrderid(rs.getInt("orderid"));
				order.setUserId(rs.getInt("userId"));
				order.setProdId(rs.getInt("prodId"));
				order.setBillname(rs.getString("billname"));
				order.setPhone(rs.getString("phone"));
				order.setQty(rs.getInt("qty"));
				order.setSize(rs.getString("size"));
				order.setStatus(rs.getString("status"));
				order.setOrderDate(rs.getDate("date"));
				order.setAddress(rs.getString("address"));
				order.setTotal(rs.getInt("total"));
				ProductModel product = con.getProdById(order.getProdId());
				order.setProdname(product.getName());	
				order.setProdImg(product.getImg());
				orders.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return orders;
	} 
	
	//this is for updating the order status acrording to the orderid
	public boolean UpdateOrder(int id, String action) {
		boolean updated = false;
		try {
			String query = "update orders set status=? where orderid=?";
			PreparedStatement prep = this.con.prepareStatement(query);
			prep.setString(1, action);
			prep.setInt(2, id);
			prep.executeUpdate();
			updated = true;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return updated;
		
	}
	
	//canceling the order
	public boolean cancelOrder(int id) {
		boolean updated = false;
		try {
			String query = "update orders set status='canceled' where orderid=?";
			PreparedStatement prep = this.con.prepareStatement(query);
			prep.setInt(1, id);
			prep.executeUpdate();
			updated = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updated;
		
	}
	
	//this is for deleting the order from the database
	public boolean deleteOrder(int id) {
		boolean updated = false;
		try {
			String query = "delete from orders where orderid=?";
			PreparedStatement prep = this.con.prepareStatement(query);
			prep.setInt(1, id);
			prep.executeUpdate();
			updated = true;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return updated;
		
	}
	
	//counting the total orders placed for admin dashboard
	public int countTotalOrders() {
		int total=0;
		try {
			String query = "select count(orderid) from orders";
			PreparedStatement prep = this.con.prepareStatement(query);
			ResultSet set = prep.executeQuery();
			if(set.next()) {
				total=set.getInt("count(orderid)");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return total;
	}
	
	//counting total canceled orders for admin dashboard
	public int countCanceledOrders() {
		int total=0;
		try {
			String query = "select count(orderid) from orders where status='canceled'";
			PreparedStatement prep = this.con.prepareStatement(query);
			ResultSet set = prep.executeQuery();
			if(set.next()) {
				total=set.getInt("count(orderid)");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return total;
	}
	
	//counting total accepted orders for admin dashboard
	public int countacceptedOrders() {
		int total=0;
		try {
			String query = "select count(orderid) from orders where status='accepted'";
			PreparedStatement prep = this.con.prepareStatement(query);
			ResultSet set = prep.executeQuery();
			if(set.next()) {
				total=set.getInt("count(orderid)");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return total;
	}
	
	//counting the total completed orders for admin dashboard
	public int countCompletedOrders() {
		int total=0;
		try {
			String query = "select count(orderid) from orders where status='completed'";
			PreparedStatement prep = this.con.prepareStatement(query);
			ResultSet set = prep.executeQuery();
			if(set.next()) {
				total=set.getInt("count(orderid)");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return total;
	}
	
	//counting the toal sales made by counting the sum of toal
	public int totalsales() {
		int total=0;
		try {
			String query = "select sum(total) from orders where status='completed'";
			PreparedStatement prep = this.con.prepareStatement(query);
			ResultSet set = prep.executeQuery();
			if(set.next()) {
				total=set.getInt("sum(total)");
			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return total;
	}
	
	
}
