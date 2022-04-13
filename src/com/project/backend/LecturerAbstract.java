package com.project.backend;

import java.util.Date;

public abstract class LecturerAbstract implements LecturerInterface {
	protected int id;
	protected String password;
	protected String name;
	protected int modifiedBy;
	protected Date modifiedOn;

	public int getLectID() {
		return id;
	}

	public void setLectID(int lectID) {
		this.id = lectID;
	}

	public String getLectPwd() {
		return password;
	}

	public void setLectPwd(String lectPwd) {
		this.password = lectPwd;
	}

	public String getLectName() {
		return name;
	}

	public void setLectName(String lectName) {
		this.name = lectName;
	}

	public int getModifiedBy() {
		return modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public Date getModifiedOn() {
		return modifiedOn;
	}

	public void setModifiedOn(Date modifiedOn) {
		this.modifiedOn = modifiedOn;
	}
}
