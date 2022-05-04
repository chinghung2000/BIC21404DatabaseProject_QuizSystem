package com.project.backend;

import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Admin extends User implements AdminInterface {
	protected int id;
	protected String password;
	protected String name;

	public Admin() {
		super();
	}

	public Admin(ResultSet rs) {
		try {
			this.id = rs.getInt("admin_id");
			this.name = rs.getString("admin_name");
		} catch (SQLException e) {
			System.out.println("Admin: There are some errors: " + e.toString());
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

		db.prepare("SELECT id, name FROM admin;");
		ResultSet rs = db.executeQuery();
		ArrayList<Admin> admins = new ArrayList<Admin>();

		try {
			while (rs.next()) {
				admins.add(new Admin(rs));
			}
		} catch (SQLException e) {
			System.out.println("Admin: There are some errors: " + e.toString());
		}

		return admins;
	}

	@Override
	public Admin getAdmin(int adminId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT id, name FROM admin WHERE id = ?;", adminId);
		ResultSet rs = db.executeQuery();
		
		try {
			if (rs.next()) {
				return new Admin(rs);
			}
		} catch (SQLException e) {
			System.out.println("Admin: There are some errors: " + e.toString());
		}
		
		return null;
	}

	@Override
	public boolean addAdmin(int adminId, String adminName) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("INSERT INTO admin (id, password, name) VALUES (?, ?, ?);", adminId, AES.encrypt(Integer.toString(adminId)), adminName);
		return db.executeUpdate();
	}

	@Override
	public boolean updateAdmin(int oldAdminId, int adminId, String adminName) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("UPDATE admin SET (id = ?, name = ?) WHERE id = ?;", adminId, adminName, oldAdminId);
		return db.executeUpdate();
	}

	@Override
	public boolean deleteAdmin(int adminId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("DELETE FROM admin WHERE id = ?;", adminId);
		return db.executeUpdate();
	}

	@Override
	public ArrayList<Lecturer> getAllLecturers() {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT id, name, modified_by, modified_on FROM lecturer;");
		ResultSet rs = db.executeQuery();
		ArrayList<Lecturer> lecturers = new ArrayList<Lecturer>();
		
		try {
			if (rs.next()) {
				lecturers.add(new Lecturer(rs));
			}
		} catch (SQLException e) {
			System.out.println("Admin: There are some errors: " + e.toString());
		}
		
		return lecturers;
	}

	@Override
	public Lecturer getLecturer(int lecturerId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT id, name, modified_by, modified_on FROM lecturer WHERE id = ?;", lecturerId);
		ResultSet rs = db.executeQuery();
		
		try {
			if (rs.next()) {
				return new Lecturer(rs);
			}
		} catch (SQLException e) {
			System.out.println("Admin: There are some errors: " + e.toString());
		}
		
		return null;
	}

	@Override
	public boolean addLecturer(int lecturerId, String lecturerName, int modifiedBy) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT ");
		return db.executeUpdate();
	}

	@Override
	public boolean updateLecturer(int oldLecturerId, int lecturerId, String lecturerName, int modifiedBy) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("");
		return db.executeUpdate();
	}

	@Override
	public boolean deleteLecturer(int lecturerId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("");
		return db.executeUpdate();
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
	public boolean updateSubject(String oldSubjectId, String subjectId, String subjectName, int modifiedBy) {
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
	public Workload getWorkload(int lecturerId, String subjectId) {
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
	public boolean updateStudent(String oldStudentId, String studentId, String studentName, String studentEmail, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteStudent(String studentId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<Log> getSystemLogs() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Log> getSystemLogs(String type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addLogRecord(String type, String description) {
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
		if (rs.next()) {
			return new ???;
		}
	} catch (SQLException e) {
		System.out.println("Admin: There are some errors: " + e.toString());
	}
	
	return ???;


========== Query execution without result ==========

	DatabaseManager db = new DatabaseManager(new MySQL().connect());
	
	db.prepare("");
	return db.executeUpdate();


*/
