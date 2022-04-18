<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
if (!session.isNew()) {
	response.sendRedirect(request.getContextPath() + "/session.jsp");
}
%>