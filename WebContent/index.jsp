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
		xhttp.open("POST", "userLogin.jsp", true);
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
		
		if (d["user_id"] != "") {
			if (d["password"] != "") {
				if (d["user_type"] != "") {
					XHRequest(JSON.stringify(d));
				} else {
					$e("span-login-message").innerHTML = "Please choose a user type.";
				}
			} else {
				$e("span-login-message").innerHTML = "Please enter password.";
			}
		} else {
			$e("span-login-message").innerHTML = "Please enter user ID.";
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
	margin: 10px 0px;
	padding: 10px;
	text-align: center;
}

span.login-title {
	font-size: 30px;
}

div.login-message {
	margin: 10px 0px;
	height: 20px;
 	text-align: center;
}

span.login-message {
	color: red;
}

div.login-form {
	margin: 10px 0px;
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
	padding-left: 100px;
}

div.login-button {
	margin: 10px 0px;
	text-align: center;
	display: block;
	position: absolute;
	left: 0px;
	right: 0px;
	bottom: 0px;
}

button {
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
		<div class="login-message">
			<span class="login-message" id="span-login-message"></span>
		</div>
		<div class="login-form">
			<form>
				<div class="login-field">
					<label class="login-field" for="input-user-id">User ID:</label>
					<input type="text" id="input-user-id" name="user_id" autocomplete="off">
				</div>
				<div class="login-field">
					<label class="login-field" for="input-password">Password:</label>
					<input type="password" id="input-password" name="password">
				</div>
				<div class="login-field-radio">
					<input type="radio" id="input-radio-admin" name="user_type" value="admin">
					<label for="input-radio-admin">Admin</label>
					<br>
					<input type="radio" id="input-radio-lecturer" name="user_type" value="lecturer">
					<label for="input-radio-lecturer">Lecturer</label>
					<br>
					<input type="radio" id="input-radio-student" name="user_type" value="student">
					<label for="input-radio-student">Student</label>
					<br>
				</div>
			</form>
			<div class="login-button">
				<button onclick="login();">Login</button>
			</div>
		</div>
	</div>
</body>
</html>