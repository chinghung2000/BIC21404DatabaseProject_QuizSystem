package com.project.backend;

import java.util.Date;

public class Lecturer {
	protected int id;
	protected String password;
	protected String name;
	protected Admin modifiedBy;
	protected Date modifiedOn;

	public Lecturer(int id, String password, String name, Admin modifiedBy, Date modifiedOn) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.modifiedBy = modifiedBy;
		this.modifiedOn = modifiedOn;
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
