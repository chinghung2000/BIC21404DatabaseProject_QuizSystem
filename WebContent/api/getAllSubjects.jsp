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

// create a Dictionary of data ($d)
HashMap<String, Object> d = new HashMap<String, Object>();

// create a Dictionary of response content ($rc)
HashMap<String, Object> rc = new HashMap<String, Object>();
rc.put("ok", false);

// define logic control variables
boolean execute = false;


// check whether request method is 'POST'
if (request.getMethod().equals("POST")) {
	
	// check existence of Content-Type header
	if (request.getContentType() != null) {
		
		// check whether Content-Type is 'application/json'
		if (request.getContentType().equals("application/json")) {
			
			// read raw data from the request body
			BufferedReader br = request.getReader();
			String reqBody = br.readLine();
			br.close();
			
			// check whether request body is not null 
			if (reqBody != null) {
				boolean JSONError;
				
				// try JSON parsing request body and convert into Dictionary $d 
				try {
					d = gson.fromJson(reqBody, new TypeToken<HashMap<String, Object>>() {}.getType());
					JSONError = false;
				} catch (JsonSyntaxException e) {
					JSONError = true;
				}
				
				// check whether it's no error in JSON parsing
				if (!JSONError) {
					// permit execution
					execute = true;
				} else {
					rc.put("error_code", 400);
					rc.put("description", "Bad Request: Bad POST Request: Can't parse JSON object");
				}
			} else {
				rc.put("error_code", 400);
				rc.put("description", "Bad Request: Bad POST Request: Content is empty");
			}
		} else {
			rc.put("error_code", 400);
			rc.put("description", "Bad Request: Bad POST Request: Unsupported content-type");
		}
	} else {
		rc.put("error_code", 400);
		rc.put("description", "Bad Request: Bad POST Request: Undefined content-type");
	}
} else {
	rc.put("error_code", 405);
	rc.put("description", "Method Not Allowed: No POST request was received");
}


// execution
if (execute) {
	
	// execute backend logic...
	// parent if clause for call backend result (to-be)
	if (true) {
		ArrayList<HashMap<String, Object>> result = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> subject = new HashMap<String, Object>();
		
		subject.put("subject_id", "BIC10303");
		subject.put("subject_name", "Algebra");
		subject.put("modified_by", "Ahmad Syahmi");
		subject.put("modified_on", "21/4/2022 7:51:23 PM");
		result.add(subject);
		
		subject = new HashMap<String, Object>();
		subject.put("subject_id", "BIC10204");
		subject.put("subject_name", "Algorithm");
		subject.put("modified_by", "Ahmad Syahmi");
		subject.put("modified_on", "21/4/2022 7:53:11 PM");
		result.add(subject);
		
		rc.put("result", result);
		rc.put("ok", true);
	}
}


// check unknown error
if ((boolean) rc.get("ok") == false && rc.get("description") == null) {
	rc.put("error_code", 500);
	rc.put("description", "Internal Server Error: Unknown error found");
}


// echo JSON string of response content ($rc) 
out.println(gson.toJson(rc));
%>