package com.project.backend;

import java.util.ArrayList;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Student extends User implements StudentInterface {
	protected String id;
	protected String password;
	protected String name;
	protected String email;
	protected Admin modifiedBy;
	protected Date modifiedOn;

	public Student() {
		super();
	}

	public Student(ResultSet rs) {
		try {
			this.id = rs.getString("student_id");
			this.name = rs.getString("student_name");
			this.email = rs.getString("student_email");
			this.modifiedBy = new Admin();
			this.modifiedBy.id = rs.getInt("admin_id");
			this.modifiedBy.name = rs.getString("admin_name");
			this.modifiedOn = rs.getDate("modified_on");
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
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

	@Override
	public ArrayList<Workload> getWorkload(String studentId, String subjectId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<RegisteredSubject> getAllRegisteredSubjects(String studentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RegisteredSubject getRegisteredSubject(int registeredSubjectId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addRegisteredSubject(String studentId, int workloadId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Task> getAllTasks(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Task getTask(int taskId, int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Submission> getAllSubmissions(int taskId, String studentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addSubmission(int taskId, String studentId, String fileName) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<QuizTrueFalse> getAllQuizTF(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateQuizTFMark(int registeredSubjectId, int quizTFMark) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<QuizObjective> getAllQuizObj(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean updateQuizObjMark(int registeredSubjectId, int quizObjMark) {
		// TODO Auto-generated method stub
		return false;
	}
}
/*
+-------------------------------------------------------+
|						TEMPLATES						|
+-------------------------------------------------------+

========== Query execution with result ========== 

	DatabaseManager db = new DatabaseManager(new MySQL().connect());
	
	db.prepare("");
	ResultSet rs = db.executeQuery();
	
	try {
		? (rs.next()) {
			?
		}
	} catch (SQLException e) {
		System.out.println("Student: There are some errors: " + e.toString());
	}
	
	return ?;


========== Query execution without result ==========

	DatabaseManager db = new DatabaseManager(new MySQL().connect());
	
	db.prepare("");
	return db.executeUpdate();


*/