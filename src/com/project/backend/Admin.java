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

	@Override
	public ArrayList<Admin> getAllAdmins() {
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
	}

	@Override
	public Admin getAdmin(int adminId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addAdmin(int adminId, String adminName) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateAdmin(int adminId, String adminName) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteAdmin(int adminId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Lecturer> getAllLecturers() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Lecturer getLecturer(int lecturerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addLecturer(int lecturerId, String lecturerName, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateLecturer(int lecturerId, String lecturerName, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteLecturer(int lecturerId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Student> getAllStudents() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Student getStudent(String studentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addStudent(String studentId, String studentName, String studentEmail, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateStudent(String studentId, String studentName, String studentEmail, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteStudent(String studentId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Subject> getAllSubjects() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Subject getSubject(String subjectId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addSubject(String subjectId, String subjectName, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateSubject(String subjectId, String subjectName, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteSubject(String subjectId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Workload> getAllWorkloads() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Workload getWorkload(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addWorkload(int lecturerId, String subjectId, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateWorkload(int workloadId, int lecturerId, String subjectId, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteWorkload(int workloadId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Log> getAllLogs() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Log> getAllLogs(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean newLog(String type, String description) {
		// TODO Auto-generated method stub
		return false;
	}

}
