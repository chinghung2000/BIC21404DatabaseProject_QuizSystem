<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@page import="java.util.Collections"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="com.google.gson.JsonSyntaxException"%>
<%@ page import="com.project.backend.*"%>


<%
//create gson object (for JSON)
Gson gson = new Gson();
boolean execute = false;

//create a Dictionary of data ($d)
HashMap<String, Object> d = new HashMap<String, Object>();

// create a Dictionary of response content ($rc)
HashMap<String, Object> rc = new HashMap<String, Object>();
rc.put("ok", false);

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
				boolean JSONError = true;
				
				// try JSON parsing request body and convert into Dictionary $d 
				try {
					d = gson.fromJson(reqBody, new TypeToken<HashMap<String, Object>>() {}.getType());
					JSONError = false;
				} catch (JsonSyntaxException e) {}
				
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
	
	// validate parameter 'user_id'
	if (d.containsKey("user_id")) {
		if (!d.get("user_id").equals("")) {
			
			// validate parameter 'password'
			if (d.containsKey("password")) {
				if (!d.get("password").equals("")) {
					
					// validate parameter 'user_type'
					if (d.containsKey("user_type")) {
						if (!d.get("user_type").equals("")) {
							ArrayList<String> allowedUserTypes = new ArrayList<String>();
							Collections.addAll(allowedUserTypes, "admin", "lecturer", "student");
							
							if (allowedUserTypes.contains(d.get("user_type"))) {
								
								// execute backend logic...
								// parent if clause for call backend result
								if (true) {
									if (session.isNew()) {
										session.setAttribute("user_id", d.get("user_id"));
										session.setAttribute("user_type", d.get("user_type"));
									}
									
									if (d.get("user_type").equals("admin")) {
										rc.put("home", "/admin.jsp");
									} else if (d.get("user_type").equals("lecturer")) {
										rc.put("home", "/lecturer.jsp");
									} else if (d.get("user_type").equals("student")) {
										rc.put("home", "/student.jsp");
									}
								}
								
								rc.put("ok", true);
							} else {
								rc.put("error_code", 400);
								rc.put("description", "Bad Request: Invalid value for 'user_type'");
							}
						} else {
							rc.put("error_code", 400);
							rc.put("description", "Bad Request: 'user_type' can't be empty");
						}
					} else {
						rc.put("error_code", 400);
						rc.put("description", "Bad Request: Parameter 'user_type' is required");
					}
				} else {
					rc.put("error_code", 400);
					rc.put("description", "Bad Request: 'password' can't be empty");
				}
			} else {
				rc.put("error_code", 400);
				rc.put("description", "Bad Request: Parameter 'password' is required");
			}
		} else {
			rc.put("error_code", 400);
			rc.put("description", "Bad Request: 'user_id' can't be empty");
		}
	} else {
		rc.put("error_code", 400);
		rc.put("description", "Bad Request: Parameter 'user_id' is required");
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