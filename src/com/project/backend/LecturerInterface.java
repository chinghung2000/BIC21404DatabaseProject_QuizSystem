package com.project.backend;

public interface LecturerInterface {
	void getAllWorkloads(int lecturerId);
	
	void getAllQuizTF(int workloadId);
	boolean addQuizTF(int workloadId, String question, boolean answer, int modifiedBy);
	boolean updateQuizTF(int quizTFId, String question, boolean answer, int modifiedBy);
	boolean deleteQuizTF(int quizTFId);
	void getAllQuizTFResults(int workloadId);
	
	void getAllQuizObj(int workloadId);
	boolean addQuizObj(int workloadId, String question, String choiceA, String choiceB, String choiceC, String choiceD, char answer, int modifiedBy);
	boolean updateQuizObj(int quizObjId, String question, String choiceA, String choiceB, String choiceC, String choiceD, char answer, int modifiedBy);
	boolean deleteQuizObj(int quizObjId);
	void getAllQuizObjResults(int workloadId);
	
	void getAllTasks(int workloadId);
	boolean addTask(int workloadId, String taskName, String fileName, int modifiedBy);
	boolean updateTask(int taskId, int workloadId, String taskName, String fileName, int modifiedBy);
	boolean deleteTask(int taskId);
	void getAllSubmissions(int taskId);
}
