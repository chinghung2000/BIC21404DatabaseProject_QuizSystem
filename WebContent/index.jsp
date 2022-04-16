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
		xhttp.open("POST", "api/login.jsp", true);
		xhttp.setRequestHeader("Content-Type", "application/json");
		xhttp.send(jsonString);

		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				switch (this.status) {
					case 200:
						var r = JSON.parse(this.responseText);
						
						if (r["ok"] === true) {
							location.href = r["target"];
						} else {
							if ("message" in r) {
								$e("span-login-message").innerHTML = r["message"];
							} else {
								$e("span-login-message").innerHTML = "Error " + r["error_code"] + ": " + r["description"];
							}
						}
						
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
	margin: 120px auto 0px;
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
	font-family: verdana;
	font-size: 16px;
}

div.login-field-radio {
	margin: 10px 0px;
	padding-left: 100px;
}

input[type=radio] {
	cursor: pointer;
}

input[type=text]:hover, [type=password]:hover, [type=radio]:hover {
	outline: 1px solid;
}

label.login-field-radio {
	cursor: pointer;
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
	border-radius: 5px;
	font-family: verdana;
	font-size: 16px;
	box-shadow: 1px 1px 1px 0px;
	cursor: pointer;
}

button:hover {
	box-shadow: 0px 0px 1px 0px;
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
					<input type="text" id="input-user-id" name="user_id">
				</div>
				<div class="login-field">
					<label class="login-field" for="input-password">Password:</label>
					<input type="password" id="input-password" name="password">
				</div>
				<div class="login-field-radio">
					<input type="radio" id="input-radio-admin" name="user_type" value="admin">
					<label class="login-field-radio" for="input-radio-admin">Admin</label>
					<br>
					<input type="radio" id="input-radio-lecturer" name="user_type" value="lecturer">
					<label class="login-field-radio" for="input-radio-lecturer">Lecturer</label>
					<br>
					<input type="radio" id="input-radio-student" name="user_type" value="student">
					<label class="login-field-radio" for="input-radio-student">Student</label>
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