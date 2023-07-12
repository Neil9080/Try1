package com.shopify.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopify.models.CartModel;
import com.shopify.models.OrderModel;

public class CartController {
	private Connection conn;

	public CartController(Connection conn) {
		this.conn = conn;
	}

	// storing all the cart items in a list of CartModel class
	public List<CartModel> getCartProd(ArrayList<CartModel> carts) {
		List<CartModel> cartItems = new ArrayList<>();
		try {
			if (carts.size() > 0) {
				// first all the products id are iterated and products from database is found
				// accrodiing
				// the id. then the product is stored in CartModel class.
				for (CartModel singleProd : carts) {
					String query = "select * from products where id=?";
					PreparedStatement prep = this.conn.prepareStatement(query);
					prep.setInt(1, singleProd.getId());
					ResultSet rs = prep.executeQuery();
					if (rs.next()) {
						CartModel single = new CartModel();
						single.setId(rs.getInt("id"));
						single.setName(rs.getString("name"));
						single.setCategory(rs.getString("category"));
						single.setStock(rs.getInt("stock"));
						single.setBrand(rs.getString("brand"));
						single.setPrice(rs.getInt("price"));
						single.setImg(rs.getString("img"));
						single.setDescription(rs.getString("description"));
						single.setQty(singleProd.getQty());
						single.setSize(singleProd.getSize());
						cartItems.add(single); // adding all the added items to the list

					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return cartItems;
	}

}
