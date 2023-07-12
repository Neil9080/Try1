package com.shopify.controllers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.shopify.models.CartModel;
import com.shopify.models.OrderModel;
import com.shopify.models.ProductModel;

public class ProductController {
	private Connection conn;

	public ProductController(Connection conn) {
		this.conn = conn;
	}

	// creating new product by admin
	public boolean createProcuct(ProductModel product) {
		boolean save = false;
		try {

			String query = "insert into products (name,category,stock,brand,price,img,description) values(?,?,?,?,?,?,?)";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setString(1, product.getName());
			prep.setString(2, product.getCategory());
			prep.setInt(3, product.getStock());
			prep.setString(4, product.getBrand());
			prep.setInt(5, product.getPrice());
			prep.setString(6, product.getImg());
			prep.setString(7, product.getDescription());
			prep.executeUpdate();
			save = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return save;
	}

	// updating the product according to id
	public boolean updateProduct(int id, ProductModel product) throws SQLException {
		boolean success = false;
		try {
			String query = "update products set name=?,category=?,stock=?,brand=?,stars=?,price=?,img=?,description=? where id = ?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setString(1, product.getName());
			prep.setString(2, product.getCategory());
			prep.setInt(3, product.getStock());
			prep.setString(4, product.getBrand());
			prep.setInt(5, product.getStars());
			prep.setInt(6, product.getPrice());
			prep.setString(7, product.getImg());
			prep.setString(8, product.getDescription());
			prep.setInt(9, id);
			prep.executeUpdate();
			success = true;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return success;
	}

	// deleting the product according to id for admin
	public boolean deleteProduct(int id) {
		boolean success = false;
		try {
			String query = "delete from products where id=?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setInt(1, id);
			prep.executeUpdate();
			success = true;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return success;
	}

	// fetching all the products from the database
	public List<ProductModel> getAllProd() {
		List<ProductModel> list = new ArrayList<>();
		try {
			String query = "select * from products";
			PreparedStatement pre = this.conn.prepareStatement(query);
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductModel single = new ProductModel();
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setStars(rs.getInt("stars"));
				single.setBrand(rs.getString("brand"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));

				list.add(single);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

	// geting single products from their id for single product page
	public ProductModel getProdById(int id) {

		ProductModel single = new ProductModel();
		try {
			String query = "select * from products where id=?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setInt(1, id);
			ResultSet rs = prep.executeQuery();
			if (rs.next()) {
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setBrand(rs.getString("brand"));
				single.setStars(rs.getInt("stars"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return single;
	}

	// geting the category available for product filter
	public List getCategory() {
		String query = "select category from products";
		ArrayList cat = new ArrayList();
		try {
			PreparedStatement prep = this.conn.prepareStatement(query);
			ResultSet rs = prep.executeQuery();
			boolean isMatched = false;
			while (rs.next()) {
				if (cat.size() > 0) {
					// matching if the same category is already in the list or not and not adding
					// same category twice
					for (int i = 0; i < cat.size(); i++) {

						if (rs.getString("category").toLowerCase().equalsIgnoreCase(cat.get(i).toString())) {
							isMatched = true;
							break;

						} else {
							isMatched = false;
						}
					}

					if (isMatched == false) {
						cat.add(rs.getString("category"));
					}

				} else {
					cat.add(rs.getString("category"));
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return cat;
	}

	// getting the brands available in the database for filtering
	public List getBrand() {
		String query = "select brand from products";
		ArrayList cat = new ArrayList();
		try {
			PreparedStatement prep = this.conn.prepareStatement(query);
			ResultSet rs = prep.executeQuery();
			boolean isMatched = false;
			while (rs.next()) {
				if (cat.size() > 0) {

					for (int i = 0; i < cat.size(); i++) {

						if (rs.getString("brand").toLowerCase().equalsIgnoreCase(cat.get(i).toString())) {
							// matching if the same category is already in the list or not and not adding
							// same category twice

							isMatched = true;
							break;

						} else {
							isMatched = false;
						}
					}

					if (isMatched == false) {
						cat.add(rs.getString("brand"));
					}

				} else {

					cat.add(rs.getString("brand"));
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return cat;
	}

//updating the product quantity after the oreder has been placed
	public boolean updateQty(CartModel product) {
		boolean updated = false;
		try {
			System.out.println(product.getId() + product.getQty() + product.getStock());
			String query = "update products set stock=? where id=?";
			PreparedStatement pre = this.conn.prepareStatement(query);
			pre.setInt(1, (product.getStock() - product.getQty()));
			pre.setInt(2, (product.getId()));
			pre.executeUpdate();
			updated = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updated;
	}

//getting the products according to the brand,category,price and rating
	public List<ProductModel> getSearch(String brand, String category, int price, int star) {
		List<ProductModel> list = new ArrayList<>();
		try {

			String query = null;

			if (!brand.equals("all") && category.equals("all") && price != 0 && star != 0) {
				query = "select * from products where brand=? and price=? and stars=?";

			} else if (!brand.equals("all") && !category.equals("all") && price != 0 && star != 0) {
				query = "select * from products where brand=? and category=? and price<=? and stars>=?";

			} else if (brand.equals("all") && !category.equals("all") && price != 0 && star != 0) {
				query = "select * from products where category=? and price<=? and stars>=?";

			} else if (!brand.equals("all") && category.equals("all") && price != 0 && star == 0) {
				query = "select * from products where brand=? and price<=?";

			} else if (brand.equals("all") && !category.equals("all") && price != 0 && star == 0) {

				query = "select * from products where category=? and price<=?";
			} else {
				query = "select * from products";
			}

			PreparedStatement pre = this.conn.prepareStatement(query);
			if (!brand.equals("all") && category.equals("all") && price != 0 && star != 0) {
				query = "select * from products where brand=? and price=? and stars=?";
				pre.setString(1, brand);
				pre.setInt(2, price);
				pre.setInt(3, star);

			} else if (!brand.equals("all") && !category.equals("all") && price != 0 && star != 0) {
				query = "select * from products where brand=? and category=? and price<=? and stars>=?";
				pre.setString(1, brand);
				pre.setString(2, category);
				pre.setInt(3, price);
				pre.setInt(4, star);

			} else if (brand.equals("all") && !category.equals("all") && price != 0 && star != 0) {
				query = "select * from products where category=? and price<=? and stars>=?";
				pre.setString(1, category);
				pre.setInt(2, price);
				pre.setInt(3, star);

			} else if (!brand.equals("all") && category.equals("all") && price != 0 && star == 0) {
				query = "select * from products where brand=? and price<=?";
				pre.setString(1, brand);
				pre.setInt(2, price);

			} else if (brand.equals("all") && !category.equals("all") && price != 0 && star == 0) {

				query = "select * from products where category=? and price<=?";
				pre.setString(1, category);
				pre.setInt(2, price);

			}
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductModel single = new ProductModel();
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setBrand(rs.getString("brand"));
				single.setStars(rs.getInt("stars"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));
				list.add(single);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

//geting product according to the category
	public List<ProductModel> getProdByCategotry(String category) {
		List<ProductModel> list = new ArrayList<>();
		try {

			String query = "select * from products where category=?";

			PreparedStatement pre = this.conn.prepareStatement(query);
			pre.setString(1, category);
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductModel single = new ProductModel();
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setBrand(rs.getString("brand"));
				single.setStars(rs.getInt("stars"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));

				list.add(single);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

//geting prodcuct according to the brand
	public List<ProductModel> getProdByBrand(String brand) {
		List<ProductModel> list = new ArrayList<>();
		try {

			String query = "select * from products where brand=?";
			PreparedStatement pre = this.conn.prepareStatement(query);
			pre.setString(1, brand);
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductModel single = new ProductModel();
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setBrand(rs.getString("brand"));
				single.setStars(rs.getInt("stars"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));
				System.out.println(single.getName());
				list.add(single);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

//geting product both by brand and category
	public List<ProductModel> getProdByCatbrd(String category, String brand) {
		List<ProductModel> list = new ArrayList<>();
		try {

			String query = "select * from products where category=? and brand=?";
			PreparedStatement pre = this.conn.prepareStatement(query);
			pre.setString(1, category);
			pre.setString(2, brand);
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductModel single = new ProductModel();
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setBrand(rs.getString("brand"));
				single.setStars(rs.getInt("stars"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));

				list.add(single);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

//geting the searched products
	public List<ProductModel> getSearchKey(String key) {
		List<ProductModel> list = new ArrayList<>();
		try {
			String query = "SELECT * FROM products WHERE name REGEXP" + "'[[:<:]]" + key + "[[:>:]]' ";
			PreparedStatement pre = this.conn.prepareStatement(query);
			ResultSet rs = pre.executeQuery();
			while (rs.next()) {
				ProductModel single = new ProductModel();
				single.setId(rs.getInt("id"));
				single.setName(rs.getString("name"));
				single.setCategory(rs.getString("category"));
				single.setStock(rs.getInt("stock"));
				single.setBrand(rs.getString("brand"));
				single.setStars(rs.getInt("stars"));
				single.setPrice(rs.getInt("price"));
				single.setImg(rs.getString("img"));
				single.setDescription(rs.getString("description"));
				list.add(single);

			}

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return list;
	}

//updating the number of stars of the product according to the id 
	public boolean updateReview(int id, int stars) throws SQLException {
		boolean success = false;
		try {
			String query = "update products set stars=? where id = ?";
			PreparedStatement prep = this.conn.prepareStatement(query);
			prep.setInt(1, stars);
			prep.setInt(2, id);
			prep.executeUpdate();
			success = true;
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}

		return success;
	}

//counting the total products of the database
	public int countTotalProd() {
		int total = 0;
		try {
			String query = "select count(id) from products";
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

}
