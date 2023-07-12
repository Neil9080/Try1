package com.shopify.models;

//this is the UserrModel class
public class UserModel {
	private String name;
	private String email;
	private String password;
	private String img;
	private String address;
	private String phone;
	private int id;
	private int pin;
	private int isadmin;

	public UserModel(String name, String email, String password, String img, String address, String phone, int id,
			int pin, int isadmin) {
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.img = img;
		this.phone = phone;
		this.address = address;
		this.pin = pin;
		this.isadmin = isadmin;
	}

	public UserModel(String name, String email, String password, String img, String address, String phone, int pin) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.img = img;
		this.pin = pin;
		this.address = address;
	}

	public UserModel() {

	}

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public int getIsadmin() {
		return isadmin;
	}

	public void setIsadmin(int isadmin) {
		this.isadmin = isadmin;
	}

	public int getPin() {
		return pin;
	}

	public void setPin(int pin) {
		this.pin = pin;
	}

}
