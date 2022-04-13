package com.project.backend;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;

public class MySQL {
	private String serverName = "localhost";
	private String portNumber = "3306";
	private String username = "appuser";
	private String password = "1234";
	private String url = "jdbc:mysql://" + serverName + ":" + portNumber;
	
	public Connection connect() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("MySQL: Error occured when adding JDBC:");
			e.printStackTrace();
			return null;
		}
		
		try {
			Connection connection = DriverManager.getConnection(url, username, password);
			System.out.println("MySQL: Connection successful.");
			return connection;
		} catch (SQLException e) {
			System.out.println("MySQL: Connection failed! There are some errors:");
			e.printStackTrace();
			return null;
		}
	}
}
