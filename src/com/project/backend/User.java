package com.project.backend;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
	public User login(String userType, String id, String password) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		if (userType.equals("admin")) {
			db.prepare("SELECT id, name FROM admin WHERE id = ? AND password = ?;", id, AES.encrypt(password));
			ResultSet rs = db.executeQuery();
			
			try {
				if (rs.next()) {
					return new Admin(rs);
				}
			} catch (SQLException e) {
				System.out.println("User: There are some errors: " + e.toString());
			}
		} else if (userType.equals("lecturer")) {
			db.prepare("SELECT id, name FROM lecturer WHERE id = ? AND password = ?;", id, AES.encrypt(password));
			ResultSet rs = db.executeQuery();
			
			try {
				if (rs.next()) {
					return new Lecturer(rs);
				}
			} catch (SQLException e) {
				System.out.println("User: There are some errors: " + e.toString());
			}
		} else if (userType.equals("student")) {
			db.prepare("SELECT id, name FROM student WHERE id = ? AND password = ?;", id, AES.encrypt(password));
			ResultSet rs = db.executeQuery();
			
			try {
				if (rs.next()) {
					return new Student(rs);
				}
			} catch (SQLException e) {
				System.out.println("User: There are some errors: " + e.toString());
			}
		}
		
		return null;
	}
}
