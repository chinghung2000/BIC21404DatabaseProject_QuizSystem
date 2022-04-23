package com.project.backend;

import java.util.ArrayList;

public interface StudentInterface {
	ArrayList<RegisteredSubject> getAllRegisteredSubjects(String studentId);
	boolean addRegisteredSubject(String studentId, int workloadId);
	boolean deleteRegisteredSubject(int registeredSubjectId);
	
	ArrayList<QuizTF> getAllQuizTF(int workloadId);
	boolean updateQuizTFMark(int registeredSubjectId, int quizTFMark);
	
	ArrayList<QuizObjective> getAllQuizObj();
	boolean updateQuizObjMark(int registeredSubjectId, int quizObjMark);
	
	ArrayList<Task> getAllTasks(int workloadId);
	ArrayList<Submission> getAllSubmissions(int taskId, String studentId);
	boolean addSubmission(int taskId, String studentId, String fileName);
	boolean deleteSubmission(int submissionId);
}
