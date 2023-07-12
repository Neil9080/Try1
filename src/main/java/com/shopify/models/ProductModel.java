package com.shopify.models;


//this is the product model class
public class ProductModel {
	private int id;
	private String name;
	private String category;
	private int stock;
	private String brand;
	private int price;
	private String img;
	private String description;
	private int stars;
	public ProductModel(int id, String name, String category, int stock, String brand, int stars, int price, String img,String description) {
		
		this.id = id;
		this.name = name;
		this.category = category;
		this.stock = stock;
		this.brand = brand;
		this.price = price;
		this.stars = stars;
		this.img = img;
		this.description = description;
	}
	public ProductModel(String name, String category, int stock, String brand, int stars,int price, String img,String description) {
		
		this.name = name;
		this.category = category;
		this.stock = stock;
		this.brand = brand;
		this.price = price;
		this.img = img;
		this.stars=stars;
		this.description = description;
	}
	
	public ProductModel() {};
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getStars() {
		return stars;
	}
	public void setStars(int stars) {
		this.stars = stars;
	}
	
	
}
