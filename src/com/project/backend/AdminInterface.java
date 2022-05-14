package com.project.backend;

import java.util.ArrayList;

public interface AdminInterface {
	ArrayList<Admin> getAllAdmins();
	Admin getAdmin(int adminId);
	boolean addAdmin(int adminId, String adminName);
	boolean updateAdmin(int oldAdminId, int adminId, String adminName);
	boolean deleteAdmin(int adminId);

	ArrayList<Lecturer> getAllLecturers();
	Lecturer getLecturer(int lecturerId);
	boolean addLecturer(int lecturerId, String lecturerName, int modifiedBy);
	boolean updateLecturer(int oldLecturerId, int lecturerId, String lecturerName, int modifiedBy);
	boolean deleteLecturer(int lecturerId);

	ArrayList<Subject> getAllSubjects();
	Subject getSubject(String subjectId);
	boolean addSubject(String subjectId, String subjectName, int modifiedBy);
	boolean updateSubject(String oldSubjectId, String subjectId, String subjectName, int modifiedBy);
	boolean deleteSubject(String subjectId);

	ArrayList<Workload> getAllWorkloads();
	Workload getWorkload(int workloadId);
	Workload getWorkload(int lecturerId, String subjectId);
	Workload getWorkload(int lecturerId, String subjectId, int exceptWorkloadId);
	boolean addWorkload(int lecturerId, String subjectId, int modifiedBy);
	boolean updateWorkload(int workloadId, int lecturerId, String subjectId, int modifiedBy);
	boolean deleteWorkload(int workloadId);

	ArrayList<Student> getAllStudents();
	Student getStudent(String studentId);
	boolean addStudent(String studentId, String studentName, String studentEmail, int modifiedBy);
	boolean updateStudent(String oldStudentId, String studentId, String studentName, String studentEmail, int modifiedBy);
	boolean deleteStudent(String studentId);

	ArrayList<String> getSystemLogTypes();
	ArrayList<Log> getSystemLogs();
	ArrayList<Log> getSystemLogs(String type);
}
