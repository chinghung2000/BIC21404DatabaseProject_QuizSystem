package com.project.backend;

public interface StudentInterface {
	void getAllRegisteredSubjects(String studentId);
	boolean addRegisteredSubject(String studentId, int workloadId);
	boolean deleteRegisteredSubject(int registeredSubjectId);
	
	void getAllQuizTF();
	boolean updateQuizTFMark(int registeredSubjectId, int quizTFMark);
	
	void getAllQuizObj();
	boolean updateQuizObjMark(int registeredSubjectId, int quizObjMark);
	
	void getAllTasks(int workloadId);
	void getAllSubmissions(int taskId, String studentId);
	boolean addSubmission(int taskId, String studentId, String fileName);
	boolean deleteSubmission(int submissionId);
}
