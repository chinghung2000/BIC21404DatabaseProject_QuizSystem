<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
String userId = session.getAttribute("user_id") != null ? (String) session.getAttribute("user_id") : null;
String userType = session.getAttribute("user_type") != null ? (String) session.getAttribute("user_type") : null;

if (userId == null || userType == null || !userType.equals("lecturer")) {
	response.sendRedirect("index.jsp");
} else {
	if (request.getServletPath().equals("/checkSessionLecturer.jsp")) {
		response.sendRedirect("index.jsp");
	} else if (request.getServletPath().equals("/task.jsp")) {
		if (request.getParameter("subject_id") == null) {
			response.sendRedirect("workload.jsp");
		}
	} else if (request.getServletPath().equals("/viewSubmission.jsp")) {
		if (request.getParameter("subject_id") == null || request.getParameter("task_id") == null) {
			response.sendRedirect("workload.jsp");
		}
	}
}
%>