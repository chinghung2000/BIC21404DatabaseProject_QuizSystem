package com.project.backend;

import java.util.Date;

public class Student {
	protected String id;
	protected String password;
	protected String name;
	protected String email;
	protected Admin modifiedBy;
	protected Date modifiedOn;

	public Student(String id, String password, String name, String email, Admin modifiedBy, Date modifiedOn) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.modifiedBy = modifiedBy;
		this.modifiedOn = modifiedOn;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Admin getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(Admin modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public Date getModifiedOn() {
		return modifiedOn;
	}

	public void setModifiedOn(Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
}
