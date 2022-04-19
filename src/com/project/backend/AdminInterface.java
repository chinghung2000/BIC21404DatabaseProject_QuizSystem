package com.project.backend;

public interface AdminInterface {
	void getAllAdmins();
	boolean getAdmin(int adminId);
	boolean addAdmin(int adminId, String adminName);
	boolean updateAdmin(int adminId, String adminName);
	boolean deleteAdmin(int adminId);
	
	void getAllLecturers();
	boolean getLecturer(int lecturerId);
	boolean addLecturer(int lecturerId, String lecturerName, int modifiedBy);
	boolean updateLecturer(int lecturerId, String lecturerName, int modifiedBy);
	boolean deleteLecturer(int lecturerId);
	
	void getAllStudents();
	boolean getStudent(String studentId);
	boolean addStudent(String studentId, String studentName, String studentEmail, int modifiedBy);
	boolean updateStudent(String studentId, String studentName, String studentEmail, int modifiedBy);
	boolean deleteStudent(String studentId);
	
	void getAllSubjects();
	boolean getSubject(String subjectId);
	boolean addSubject(String subjectId, String subjectName, int modifiedBy);
	boolean updateSubject(String subjectId, String subjectName, int modifiedBy);
	boolean deleteSubject(String subjectId);
	
	void getAllWorkloads();
	boolean getWorkload(int workloadId);
	boolean addWorkload(int lecturerId, String subjectId, int modifiedBy);
	boolean updateWorkload(int workloadId, int lecturerId, String subjectId, int modifiedBy);
	boolean deleteWorkload(int workloadId);
	
	void getAllLogs();
	void getAllLogs(String type);
	boolean newLog(String type, String description);
}
