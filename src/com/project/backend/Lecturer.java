package com.project.backend;

import java.util.ArrayList;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Lecturer extends User implements LecturerInterface {
	protected int id;
	protected String password;
	protected String name;
	protected Admin modifiedBy;
	protected Date modifiedOn;

	public Lecturer() {
		super();
	}

	public Lecturer(ResultSet rs) {
		try {
			this.id = rs.getInt("lecturer_id");
			this.name = rs.getString("lecturer_name");
			this.modifiedBy = new Admin();
			this.modifiedBy.id = rs.getInt("admin_id");
			this.modifiedBy.name = rs.getString("admin_name");
			this.modifiedOn = rs.getDate("modified_on");
		} catch (SQLException e) {
			System.out.println("Lecturer: There are some errors: " + e.toString());
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
	public ArrayList<Workload> getAllWorkloads(int lecturerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Workload getWorkload(int lecturerId, String subjectId) {
		// TODO Auto-generated method stub
		return null;
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
	public boolean addTask(int workloadId, String taskName, String fileName, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateTask(int taskId, int workloadId, String taskName, String fileName, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteTask(int taskId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void getAllSubmissions(int taskId) {
		// TODO Auto-generated method stub

	}

	@Override
	public ArrayList<QuizTrueFalse> getAllQuizTF(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public QuizTrueFalse getQuizTF(int quizTFId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addQuizTF(int workloadId, String question, boolean answer, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateQuizTF(int quizTFId, String question, boolean answer, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteQuizTF(int quizTFId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<QuizObjective> getAllQuizObj(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public QuizObjective getQuizObj(int quizObjId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean addQuizObj(int workloadId, String question, String choiceA, String choiceB, String choiceC,
			String choiceD, char answer, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean updateQuizObj(int quizObjId, String question, String choiceA, String choiceB, String choiceC,
			String choiceD, char answer, int modifiedBy) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean deleteQuizObj(int quizObjId) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public ArrayList<RegisteredSubject> getAllRegisteredSubject(int workloadId) {
		// TODO Auto-generated method stub
		return null;
	}
}
