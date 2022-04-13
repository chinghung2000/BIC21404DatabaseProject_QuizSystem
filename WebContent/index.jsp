<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>
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
		xhttp.open("POST", "login.jsp", true);
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
	
	function login() {
		var e = $n("user_type");
		var userType = "";
		
		for (i = 0; i < e.length; i++) {
			if (e[i].checked) {
				userType = e[i].value;
				break;
			}
		}
		
		var d = {};
		d["user_id"] = $e("input-user-id").value;
		d["password"] = $e("input-password").value;
		d["user_type"] = userType;
		
		XHRequest(JSON.stringify(d));
	}
	
	function login1() {
		var ajax = new Ajax;

		var e = $n("user_type");
		var userType;

		for (i = 0; i < e.length; i++) {
			if (e[i].checked) {
				userType = e[i].value;
			}
		}

		ajax.sendGetRequest("login.jsp?user_id=" + $e("input-user-id").value
				+ "&password=" + $e("input-password").value + "&user_type="
				+ userType);

		ajax.xhr.onreadystatechange = function() {
			if (this.readyState == 4) {
				switch (this.status) {
				case 200:
					alert(this.responseText);
					break;
				default:
					alert("Error: " + this.statusText);
				}
			}
		}
	}
</script>
<style type="text/css">
body {
	font-family: verdana;
	font-size: 16px;
}

div.login-container {
	border: 2px solid;
	border-radius: 10px;
	margin: 100px auto 0px;
	padding: 10px;
	width: 325px;
}

div.login-title {
	margin: 10px auto;
	padding: 10px;
	text-align: center;
}

span.login-title {
	font-size: 30px;
}

div.login-form {
	margin: 10px auto;
	padding: 10px;
	height: 200px;
	position: relative;
}

div.login-field {
	margin: 10px 0px;
}

label.login-field {
	width: 100px;
	text-align: right;
	display: inline-block;
}

input[type=text], [type=password] {
	width: 150px;
}

div.login-field-radio {
	margin: 10px 0px;
	padding: 0px 100px;
}

div.login-button {
	margin: 10px auto;
	text-align: center;
	display: block;
	position: absolute;
	left: 0px;
	right: 0px;
	bottom: 0px;
}

input[type=submit] {
	font-family: verdana;
	font-size: 16px;
}
</style>
</head>
<body>
	<div class="login-container">
		<div class="login-title">
			<span class="login-title">Login</span>
		</div>
		<div class="login-form">
<!-- 			<form action="login.jsp" method="post" enctype="application/x-www-form-urlencoded"> -->
			<form>
				<div class="login-field">
					<label class="login-field" for="input-user-id">User ID:</label>
					<input type="text" id="input-user-id" name="user_id" autocomplete="off" required>
				</div>
				<div class="login-field">
					<label class="login-field" for="input-password">Password:</label>
					<input type="password" id="input-password" name="password" required>
				</div>
				<div class="login-field-radio">
					<input type="radio" id="input-radio-admin" name="user_type" value="admin" required>
					<label for="input-radio-admin">Admin</label>
					<br>
					<input type="radio" id="input-radio-lecturer" name="user_type" value="lecturer" required>
					<label for="input-radio-lecturer">Lecturer</label>
					<br>
					<input type="radio" id="input-radio-student" name="user_type" value="student" required>
					<label for="input-radio-student">Student</label>
					<br>
				</div>
				<div class="login-button">
<!-- 					<input type="submit" name="login" value="Login"> -->
				</div>
			</form>
			<button onclick="login();">Login</button>
		</div>
	</div>
</body>
</html>