package com.project.backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseManager {
	private Connection connection;
	private PreparedStatement pstmt;
	private String query;

	public DatabaseManager(Connection connection) {
		this.connection = connection;
	}

	public void prepare(String query, Object... parameters) {
		this.query = query;

		try {
			this.pstmt = this.connection.prepareStatement(this.query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			System.out.println("DatabaseManager: Preparing SQL query: \"" + this.query + "\"...");
			int i = 1;

			for (Object parameter : parameters) {
				if (parameter instanceof Boolean) {
					this.pstmt.setBoolean(i, (boolean) parameter);
				} else if (parameter instanceof Integer) {
					this.pstmt.setInt(i, (int) parameter);
				} else if (parameter instanceof Long) {
					this.pstmt.setLong(i, (long) parameter);
				} else if (parameter instanceof Float) {
					this.pstmt.setFloat(i, (float) parameter);
				} else if (parameter instanceof Double) {
					this.pstmt.setDouble(i, (double) parameter);
				} else if (parameter instanceof String) {
					this.pstmt.setString(i, (String) parameter);
				} else {
					this.pstmt.setNull(i, java.sql.Types.NULL);
				}

				i++;
			}

		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors:");
			e.printStackTrace();
		}
	}

	public ResultSet executeQuery() {
		try {
			System.out.println("DatabaseManager: Executing prepared SQL query...");
			ResultSet rs = this.pstmt.executeQuery();
			int rowCount = rs.last() ? rs.getRow() : 0;
			rs.beforeFirst();
			System.out.println("DatabaseManager: " + rowCount + " row(s) found.");
			return rs;
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors:");
			e.printStackTrace();
			return null;
		}
	}

	public void executeUpdate() {
		try {
			System.out.println("DatabaseManager: Executing prepared SQL query...");
			int affectedRowCount = this.pstmt.executeUpdate();
			System.out.println("DatabaseManager: " + affectedRowCount + " row(s) affected.");
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors:");
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			this.connection.close();
			System.out.println("DatabaseManager: Database connection closed.");
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors:");
			e.printStackTrace();
		}
	}
}
