package com.project.backend;

public abstract class AdminAbstract implements AdminInterface {
	protected int id;
	protected String password;
	protected String name;

	public int getAdminID() {
		return id;
	}

	public void setAdminID(int adminID) {
		this.id = adminID;
	}

	public String getAdminPwd() {
		return password;
	}

	public void setAdminPwd(String adminPwd) {
		this.password = adminPwd;
	}

	public String getAdminName() {
		return name;
	}

	public void setAdminName(String adminName) {
		this.name = adminName;
	}
}
