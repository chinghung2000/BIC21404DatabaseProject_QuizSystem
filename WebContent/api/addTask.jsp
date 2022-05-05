<%@page import="com.mysql.cj.protocol.ValueDecoder"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.io.File"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="com.google.gson.JsonSyntaxException"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="com.project.backend.*"%>


<%
// create gson object (for JSON)
Gson gson = new Gson();

// create a Dictionary of response content ($rc)
HashMap<String, Object> rc = new HashMap<String, Object>();
rc.put("ok", false);

// define logic control variables
boolean execute = false;


// check whether request method is 'POST'
if (request.getMethod().equals("POST")) {
	
	// check existence of Content-Type header
	if (request.getContentType() != null) {
		
		// check whether Content-Type is 'multipart/form-data'
		if (request.getContentType().indexOf("multipart/form-data") == 0) {
			// permit execution
			execute = true;
		} else {
			rc.put("error_code", 400);
			rc.put("description", "Bad Request: Bad POST Request: Unsupported content-type: Content-type must be multipart/form-data");
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
	
	// definitions of DiskFileItemFactory, ServletFileUpload objects and variables
	int maxMemorySize = 5 * 1024 * 1024 ;	// 5 MB
	int maxFileSize = 5 * 1024 * 1024;		// 5 MB
	
	DiskFileItemFactory dfif = new DiskFileItemFactory();
	dfif.setSizeThreshold(maxMemorySize);
	dfif.setRepository(new File("C:\\JavaWebUploads\\QuizSystem\\temp\\"));
	ServletFileUpload upload = new ServletFileUpload(dfif);
	upload.setFileSizeMax(maxFileSize);
	
	String filePath = "C:\\JavaWebUploads\\QuizSystem\\uploads\\";
	
	HashMap<String, Object> parameters = new HashMap<String, Object>();
	ArrayList<String> files = new ArrayList<String>();
	
	try {
		List<FileItem> fileItems = upload.parseRequest(request);
		Iterator<FileItem> i = fileItems.iterator();
		
		while (i.hasNext()) {
			FileItem fileItem = i.next();
			
			if (fileItem.isFormField()) {
				parameters.put(fileItem.getFieldName(), fileItem.getString());
			} else {
				if (!fileItem.getName().equals("")) {
					parameters.put(fileItem.getFieldName(), fileItem.getName());
					files.add(fileItem.getName());
					File file = new File(filePath + fileItem.getName());
					fileItem.write(file);					 
				}
			}
		}
		
		rc.put("parameters", parameters);
		rc.put("files", files);
		rc.put("ok", true);
	} catch (FileSizeLimitExceededException e) {
		System.out.println(e);
		rc.put("error_code", 400);
		rc.put("message", "File size can't be more than 5 MB");
		rc.put("description", "Bad Request: Bad POST Request: File size exceeds limit (5 MB)");
	} catch (Exception e) {
		System.out.println(e);
		rc.put("error_code", 400);
		rc.put("description", "Bad Request: Bad POST Request: Unknown error");
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