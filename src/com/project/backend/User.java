package com.project.backend;

import java.sql.ResultSet;
import java.sql.SQLException;

public class User {
	public User login(String userType, String userId, String password) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		if (userType.equals("admin")) {
			db.prepare("SELECT admin_id, admin_name FROM admin WHERE admin_id = ? AND password = ?;",
					userId, AES.encrypt(password));
			ResultSet rs = db.executeQuery();
			
			if (rs != null) {
				try {
					if (rs.next()) {
						return new Admin(rs);
					}
				} catch (SQLException e) {
					System.out.println("User: There are some errors: " + e.toString());
				}
			} else {
				System.out.println("User: Cannot retrieve result from database");
			}
		} else if (userType.equals("lecturer")) {
			db.prepare("SELECT l.lecturer_id, l.lecturer_name, a.admin_id, a.admin_name, l.modified_on FROM lecturer l INNER JOIN admin a ON l.modified_by = a.admin_id WHERE l.lecturer_id = ? AND l.password = ?;",
					userId, AES.encrypt(password));
			ResultSet rs = db.executeQuery();
			
			if (rs != null) {
				try {
					if (rs.next()) {
						return new Lecturer(rs);
					}
				} catch (SQLException e) {
					System.out.println("User: There are some errors: " + e.toString());
				}
			} else {
				System.out.println("User: Cannot retrieve result from database");
			}
		} else if (userType.equals("student")) {
			db.prepare("SELECT s.student_id, s.student_name, s.student_email, a.admin_id, a.admin_name FROM student s INNER JOIN admin a ON s.modified_by = a.admin_id WHERE s.student_id = ? AND s.password = ?;",
					userId, AES.encrypt(password));
			ResultSet rs = db.executeQuery();
			
			if (rs != null) {
				try {
					if (rs.next()) {
						return new Student(rs);
					}
				} catch (SQLException e) {
					System.out.println("User: There are some errors: " + e.toString());
				}
			} else {
				System.out.println("User: Cannot retrieve result from database");
			}
		}
		
		return null;
	}
	
	public boolean updatePassword(String userType, String userId, String newPassword) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		if (userType.equals("admin")) {
			db.prepare("UPDATE admin SET password = ? WHERE admin_id = ?;", AES.encrypt(newPassword), userId);
			return db.executeUpdate();
		} else if (userType.equals("lecturer")) {
			db.prepare("UPDATE lecturer SET password = ? WHERE lecturer_id = ?;", AES.encrypt(newPassword), userId);
			return db.executeUpdate();
		} else if (userType.equals("student")) {
			db.prepare("UPDATE student SET password = ? WHERE student_id = ?;", AES.encrypt(newPassword), userId);
			return db.executeUpdate();
		}
		
		return false;
	}
	
	public boolean addLogRecord(String type, String description) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("INSERT INTO log (type, description) VALUES (?, ?);",
				type, description);
		return db.executeUpdate();
	}
}
