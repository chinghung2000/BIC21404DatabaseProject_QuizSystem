package com.project.backend;

import java.util.ArrayList;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Student extends User implements StudentInterface {
	protected String id;
	protected String password;
	protected String name;
	protected String email;
	protected Admin modifiedBy;
	protected Date modifiedOn;

	public Student() {
		super();
	}

	public Student(ResultSet rs) {
		try {
			this.id = rs.getString("student_id");
			this.name = rs.getString("student_name");
			this.email = rs.getString("student_email");
			this.modifiedBy = new Admin();
			this.modifiedBy.id = rs.getInt("admin_id");
			this.modifiedBy.name = rs.getString("admin_name");
			this.modifiedOn = new Date(rs.getTimestamp("modified_on").getTime());
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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
	public ArrayList<Workload> getAllWorkloads() {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT w.workload_id, l.lecturer_id, l.lecturer_name, s.subject_id, s.subject_name, a.admin_id, a.admin_name, w.modified_on FROM workload w INNER JOIN lecturer l ON w.lecturer_id = l.lecturer_id INNER JOIN subject s ON w.subject_id = s.subject_id INNER JOIN admin a ON w.modified_by = a.admin_id;");
		ResultSet rs = db.executeQuery();
		ArrayList<Workload> workloads = new ArrayList<Workload>();
		
		try {
			while (rs.next()) {
				workloads.add(new Workload(rs));
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return workloads;
	}

	@Override
	public Workload getWorkload(int workloadId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT w.workload_id, l.lecturer_id, l.lecturer_name, s.subject_id, s.subject_name, a.admin_id, a.admin_name, w.modified_on FROM workload w INNER JOIN lecturer l ON w.lecturer_id = l.lecturer_id INNER JOIN subject s ON w.subject_id = s.subject_id INNER JOIN admin a ON w.modified_by = a.admin_id WHERE w.workload_id = ?;",
				workloadId);
		ResultSet rs = db.executeQuery();
		
		try {
			if (rs.next()) {
				return new Workload(rs);
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return null;
	}

	@Override
	public ArrayList<RegisteredSubject> getAllRegisteredSubjects(String studentId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT r.reg_subject_id, st.student_id, st.student_name, w.workload_id, l.lecturer_id, l.lecturer_name, s.subject_id, s.subject_name, r.quiz_tf_mark, r.quiz_obj_mark FROM reg_subject r INNER JOIN student st ON r.student_id = st.student_id INNER JOIN workload w ON r.workload_id = w.workload_id INNER JOIN lecturer l ON w.lecturer_id = l.lecturer_id INNER JOIN subject s ON w.subject_id = s.subject_id WHERE r.student_id = ?;",
				studentId);
		ResultSet rs = db.executeQuery();
		ArrayList<RegisteredSubject> registeredSubjects = new ArrayList<RegisteredSubject>();
		
		try {
			while (rs.next()) {
				registeredSubjects.add(new RegisteredSubject(rs));
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return registeredSubjects;
	}

	@Override
	public RegisteredSubject getRegisteredSubject(String studentId, String subjectId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT r.reg_subject_id, st.student_id, st.student_name, w.workload_id, l.lecturer_id, l.lecturer_name, s.subject_id, s.subject_name, r.quiz_tf_mark, r.quiz_obj_mark FROM reg_subject r INNER JOIN student st ON r.student_id = st.student_id INNER JOIN workload w ON r.workload_id = w.workload_id INNER JOIN lecturer l ON w.lecturer_id = l.lecturer_id INNER JOIN subject s ON w.subject_id = s.subject_id WHERE r.student_id = ? AND w.subject_id = ?;",
				studentId, subjectId);
		ResultSet rs = db.executeQuery();
		
		try {
			if (rs.next()) {
				return new RegisteredSubject(rs);
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return null;
	}

	@Override
	public boolean addRegisteredSubject(String studentId, int workloadId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("INSERT INTO reg_subject (student_id, workload_id) VALUES (?, ?);",
				studentId, workloadId);
		return db.executeUpdate();
	}

	@Override
	public ArrayList<Task> getAllTasks(int workloadId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT t.task_id, t.workload_id, t.task_name, t.task_file_name, l.lecturer_id, l.lecturer_name, t.modified_on FROM task t INNER JOIN lecturer l ON t.modified_by = l.lecturer_id WHERE t.workload_id = ?;",
				workloadId);
		ResultSet rs = db.executeQuery();
		ArrayList<Task> tasks = new ArrayList<Task>();
		
		try {
			while (rs.next()) {
				tasks.add(new Task(rs));
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return tasks;
	}

	@Override
	public Task getTask(int taskId, int workloadId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT t.task_id, t.workload_id, t.task_name, t.task_file_name, l.lecturer_id, l.lecturer_name, t.modified_on FROM task t INNER JOIN lecturer l ON t.modified_by = l.lecturer_id WHERE t.task_id = ? AND t.workload_id = ?;",
				taskId, workloadId);
		ResultSet rs = db.executeQuery();
		
		try {
			if (rs.next()) {
				return new Task(rs);
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return null;
	}

	@Override
	public ArrayList<Submission> getAllSubmissions(int taskId, String studentId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT sn.submission_id, sn.task_id, s.student_id, s.student_name, sn.submission_file_name, sn.submission_file_hash FROM submission sn INNER JOIN student s ON sn.student_id = s.student_id WHERE sn.task_id = ? AND sn.student_id = ?;",
				taskId, studentId);
		ResultSet rs = db.executeQuery();
		ArrayList<Submission> submissions = new ArrayList<Submission>();
		
		try {
			while (rs.next()) {
				submissions.add(new Submission(rs));
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return submissions;
	}

	@Override
	public boolean addSubmission(int taskId, String studentId, String fileName, String fileHash) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("INSERT INTO submission (task_id, student_id, submission_file_name, submission_file_hash) VALUES (?, ?, ?, ?);",
				taskId, studentId, fileName, fileHash);
		return db.executeUpdate();
	}

	@Override
	public ArrayList<QuizTrueFalse> getAllQuizTF(int workloadId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT q.quiz_tf_id, q.workload_id, q.question, q.answer, l.lecturer_id, l.lecturer_name, q.modified_on FROM quiz_tf q INNER JOIN lecturer l ON q.modified_by = l.lecturer_id WHERE q.workload_id = ?;",
				workloadId);
		ResultSet rs = db.executeQuery();
		ArrayList<QuizTrueFalse> quizTrueFalse = new ArrayList<QuizTrueFalse>();
		
		try {
			while (rs.next()) {
				quizTrueFalse.add(new QuizTrueFalse(rs));
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return quizTrueFalse;
	}

	@Override
	public boolean updateQuizTFMark(int registeredSubjectId, int quizTFMark) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("UPDATE reg_subject SET quiz_tf_mark = ? WHERE reg_subject_id = ?;",
				quizTFMark, registeredSubjectId);
		return db.executeUpdate();
	}

	@Override
	public ArrayList<QuizObjective> getAllQuizObj(int workloadId) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("SELECT q.quiz_obj_id, q.workload_id, q.question, q.choice_a, q.choice_b, q.choice_c, q.choice_d, q.answer, l.lecturer_id, l.lecturer_name, q.modified_on FROM quiz_obj q INNER JOIN lecturer l ON q.modified_by = l.lecturer_id WHERE q.workload_id = ?;",
				workloadId);
		ResultSet rs = db.executeQuery();
		ArrayList<QuizObjective> quizObjective = new ArrayList<QuizObjective>();
		
		try {
			while (rs.next()) {
				quizObjective.add(new QuizObjective(rs));
			}
		} catch (SQLException e) {
			System.out.println("Student: There are some errors: " + e.toString());
		}
		
		return quizObjective;
	}

	@Override
	public boolean updateQuizObjMark(int registeredSubjectId, int quizObjMark) {
		DatabaseManager db = new DatabaseManager(new MySQL().connect());
		
		db.prepare("UPDATE reg_subject SET quiz_obj_mark = ? WHERE reg_subject_id = ?;",
				quizObjMark, registeredSubjectId);
		return db.executeUpdate();
	}
}
