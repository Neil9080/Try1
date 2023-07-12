package com.shopify.models;

import java.sql.Date;

//this is the ordermodel class
public class OrderModel {
	private int orderid;
	private int userId;
	private int prodId;
	private int qty;
	private String size;
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	private String address;
	private int total;
	private String phone;
	private String prodname;
	private String billname;
	private String status;
	private Date orderDate;
	private String prodImg;
	public int getOrderid() {
		return orderid;
	}
	public OrderModel(int orderid, int userId, int prodId, int qty, String size, String address, int total, String phone,
			String billname, Date orderDate,String prodname,String prodImg,String status) {
		this.orderid = orderid;
		this.userId = userId;
		this.prodId = prodId;
		this.qty = qty;
		this.size=size;
		this.address = address;
		this.total = total;
		this.phone = phone;
		this.billname = billname;
		this.orderDate=orderDate;
		this.status=status;
		this.prodname=prodname;
		this.prodImg=prodImg;
	}
	public String getProdImg() {
		return prodImg;
	}
	public void setProdImg(String prodImg) {
		this.prodImg = prodImg;
	}
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	public OrderModel(int userId, int prodId, int qty,String size, String address, int total, String phone,
			String billname) {
		this.userId = userId;
		this.prodId = prodId;
		this.qty = qty;
		this.address = address;
		this.total = total;
		this.phone = phone;
		this.billname = billname;
		this.size=size;
	}
	
	public OrderModel() {}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getProdId() {
		return prodId;
	}
	public void setProdId(int prodId) {
		this.prodId = prodId;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBillname() {
		return billname;
	}
	public void setBillname(String billname) {
		this.billname = billname;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	

	
}
