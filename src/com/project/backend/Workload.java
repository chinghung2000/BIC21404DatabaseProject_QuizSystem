package com.project.backend;

import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Workload {
	protected int id;
	protected int lecturerId;
	protected int subjectId;
	protected int modifiedBy;
	protected Date modifiedOn;

	public Workload(ResultSet rs) {
		try {
			this.id = rs.getInt("");
			this.lecturerId = rs.getInt("");
			this.subjectId = rs.getInt("");
			this.modifiedBy = rs.getInt("");
			this.modifiedOn = rs.getDate("");
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

	public int getLecturerId() {
		return lecturerId;
	}

	public void setLecturerId(int lecturerId) {
		this.lecturerId = lecturerId;
	}

	public int getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(int subjectId) {
		this.subjectId = subjectId;
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
