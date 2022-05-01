package com.project.backend;

import java.util.ArrayList;

public interface LecturerInterface {
	ArrayList<Workload> getAllWorkloads(int lecturerId);
	Workload getWorkload(int lecturerId, String subjectId);

	ArrayList<Task> getAllTasks(int workloadId);
	Task getTask(int taskId, int workloadId);
	boolean addTask(int workloadId, String taskName, String fileName, int modifiedBy);
	boolean updateTask(int taskId, int workloadId, String taskName, String fileName, int modifiedBy);
	boolean deleteTask(int taskId);

	void getAllSubmissions(int taskId);

	ArrayList<QuizTrueFalse> getAllQuizTF(int workloadId);
	QuizTrueFalse getQuizTF(int quizTFId);
	boolean addQuizTF(int workloadId, String question, boolean answer, int modifiedBy);
	boolean updateQuizTF(int quizTFId, String question, boolean answer, int modifiedBy);
	boolean deleteQuizTF(int quizTFId);

	ArrayList<QuizObjective> getAllQuizObj(int workloadId);
	QuizObjective getQuizObj(int quizObjId);
	boolean addQuizObj(int workloadId, String question, String choiceA, String choiceB, String choiceC, String choiceD, char answer, int modifiedBy);
	boolean updateQuizObj(int quizObjId, String question, String choiceA, String choiceB, String choiceC, String choiceD, char answer, int modifiedBy);
	boolean deleteQuizObj(int quizObjId);

	ArrayList<RegisteredSubject> getAllRegisteredSubject(int workloadId);
}
