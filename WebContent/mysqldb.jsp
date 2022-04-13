<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.project.backend.*"%>


<%
MySQL mysql = new MySQL();
DatabaseManager db = new DatabaseManager(mysql.connect());
db.close();
%>