<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Password</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function $n(name) {
		var elements = document.getElementsByName(name);
		return elements;
	}
	
	function XHRequest(jsonString) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/login.jsp", true);
		xhttp.setRequestHeader("Content-Type", "application/json");
		xhttp.send(jsonString);
	
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4) {
				switch (this.status) {
					case 200:
						var r = JSON.parse(this.responseText);
						
						break;
					case 404:
						alert("Requested server file not found. Error code: " + this.status);
						break;
					default:
						alert(this.statusText + "Error Code: " + this.status);
				}
			}
		}
	}
	
	function updatePassword() {
		var d = {};
		
	}
</script>
<style type="text/css">

</style>
</head>
<body>

</body>
</html>