package com.project.backend;

import java.sql.Date;

public class SubjectRegistered {
	protected int id;
	protected String studentId;
	protected int workloadId;
	protected int quizTFMark;
	protected int quizObjMark;
	protected int modifiedBy;
	protected Date modifiedOn;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public int getWorkloadId() {
		return workloadId;
	}

	public void setWorkloadId(int workloadId) {
		this.workloadId = workloadId;
	}

	public int getQuizTFMark() {
		return quizTFMark;
	}

	public void setQuizTFMark(int quizTFMark) {
		this.quizTFMark = quizTFMark;
	}

	public int getQuizObjMark() {
		return quizObjMark;
	}

	public void setQuizObjMark(int quizObjMark) {
		this.quizObjMark = quizObjMark;
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
