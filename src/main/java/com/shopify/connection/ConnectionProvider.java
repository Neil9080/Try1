package com.shopify.connection;
import java.sql.*;


//making class for connecting to the local database
public class ConnectionProvider {
	 public static Connection conn;
	 public static Connection getconnection() {
		 try {
				
				if (conn==null) {
				
				Class.forName("com.mysql.jdbc.Driver");
				conn=DriverManager.getConnection
						("jdbc:mysql://localhost:3306/shopify","root","");
				
				}
				
			} catch (Exception e) {
				System.out.println(e);
				return null;
			}
			return conn;
		}
}
