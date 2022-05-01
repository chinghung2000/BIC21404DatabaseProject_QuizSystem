package com.project.backend;

import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Admin implements AdminInterface {
	protected int id;
	protected String password;
	protected String name;

	public Admin(ResultSet rs) {
		try {
			this.id = rs.getInt("");
			this.password = rs.getString("");
			this.name = rs.getString("");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}

/*
		DatabaseManager db = new DatabaseManager(new MySQL().connect());

		db.prepare("SELECT * FROM admin;");
		ResultSet rs = db.executeQuery();
		ArrayList<Admin> admins = new ArrayList<Admin>();

		try {
			while (rs.next()) {
				admins.add(new Admin(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return admins;
*/