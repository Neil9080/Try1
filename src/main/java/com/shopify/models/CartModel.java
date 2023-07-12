package com.shopify.models;

//this is CartModel that extends ProductModel
public class CartModel extends ProductModel{
		
		private int qty ;
		private String size;
	public CartModel() {
			// TODO Auto-generated constructor stub
		} 
		
		public int getQty() {
			return qty;
		}
		public void setQty(int qty) {
			this.qty = qty;
		}

		public String getSize() {
			return size;
		}

		public void setSize(String size) {
			this.size = size;
		}
		
		
	}


