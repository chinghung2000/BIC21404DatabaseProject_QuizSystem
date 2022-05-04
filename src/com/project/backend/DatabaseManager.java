package com.project.backend;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DatabaseManager {
	private Connection connection;
	private PreparedStatement pstmt;

	// constructor to receive database connection
	public DatabaseManager(Connection connection) {
		this.connection = connection;
	}

	// to prepare a SQL statement and bind respective parameters
	public boolean prepare(String statement, Object... parameters) {
		try {
			this.pstmt = this.connection.prepareStatement(statement, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			System.out.println("DatabaseManager: Preparing SQL statement: \"" + statement + "\"...");
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
				} else if (parameter instanceof Character || parameter instanceof String) {
					this.pstmt.setString(i, (String) parameter);
				} else if (parameter instanceof Date) {
					this.pstmt.setDate(i, (Date) parameter);
				} else {
					this.pstmt.setNull(i, java.sql.Types.NULL);
				}

				i++;
			}

			return true;
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors: " + e.toString());
			return false;
		}
	}

	// to execute SQL statement with returning results
	public ResultSet executeQuery() {
		try {
			System.out.println("DatabaseManager: Executing prepared SQL statement...");
			ResultSet rs = this.pstmt.executeQuery();
			int rowCount = rs.last() ? rs.getRow() : 0;
			rs.beforeFirst();
			System.out.println("DatabaseManager: " + rowCount + " row(s) found.");
			return rs;
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors: " + e.toString());
			return null;
		}
	}

	// to execute SQL statement without return result
	public boolean executeUpdate() {
		try {
			System.out.println("DatabaseManager: Executing prepared SQL statement...");
			int affectedRowCount = this.pstmt.executeUpdate();
			System.out.println("DatabaseManager: " + affectedRowCount + " row(s) affected.");
			return true;
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors: " + e.toString());
			return false;
		}
	}

	// to close the database connection
	public boolean close() {
		try {
			this.connection.close();
			System.out.println("DatabaseManager: Database connection closed.");
			return true;
		} catch (SQLException e) {
			System.out.println("DatabaseManager: There are some errors: " + e.toString());
			return false;
		}
	}
}
