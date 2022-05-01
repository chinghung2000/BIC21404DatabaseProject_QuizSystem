package com.project.backend;

import java.util.ArrayList;

public interface StudentInterface {
	ArrayList<Workload> getWorkload(String studentId, String subjectId);
	
	ArrayList<RegisteredSubject> getAllRegisteredSubjects(String studentId);
	RegisteredSubject getRegisteredSubject(int registeredSubjectId);
	boolean addRegisteredSubject(String studentId, int workloadId);

	ArrayList<Task> getAllTasks(int workloadId);
	Task getTask(int taskId, int workloadId);
	
	ArrayList<Submission> getAllSubmissions(int taskId, String studentId);
	boolean addSubmission(int taskId, String studentId, String fileName);
	
	ArrayList<QuizTrueFalse> getAllQuizTF(int workloadId);
	boolean updateQuizTFMark(int registeredSubjectId, int quizTFMark);

	ArrayList<QuizObjective> getAllQuizObj(int workloadId);
	boolean updateQuizObjMark(int registeredSubjectId, int quizObjMark);
}
