<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.Collections"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="com.google.gson.JsonSyntaxException"%>
<%-- <%@ page import="com.project.backend.*"%> --%>


<%
// create gson object (for JSON)
Gson gson = new Gson();
boolean execute = false;

// create a Dictionary of data ($d)
HashMap<String, Object> d = new HashMap<String, Object>();

// create a Dictionary of response content ($rc)
HashMap<String, Object> rc = new HashMap<String, Object>();
rc.put("ok", false);

execute = true;

// execution
if (execute) {
	
}

// check unknown error
if ((boolean) rc.get("ok") == false && rc.get("description") == null) {
	rc.put("error_code", 500);
	rc.put("description", "Internal Server Error: Unknown error found");
}

// echo JSON string of response content ($rc) 
out.println(gson.toJson(rc));
%>