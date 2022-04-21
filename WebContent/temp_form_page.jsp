<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionAdmin.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function XHRequest(APIMethod, jsonString, {async = true, callback = null, nextCall = null} = {}) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/" + APIMethod + ".jsp", async);
		xhttp.setRequestHeader("Content-Type", "application/json");
		xhttp.send(jsonString);
	
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				switch (this.status) {
					case 200:
						var rc = JSON.parse(this.responseText);
						
						if (rc["ok"] === true) {
							// ?
							
							if (callback != null) window[callback](rc);
						} else {
							if ("kickout" in rc) {
								location.href = "index.jsp";
							} else if ("message" in rc) {
								$e("span-message").innerHTML = rc["message"];
							} else {
								$e("span-message").innerHTML = "Error " + rc["error_code"] + ": " + rc["description"];
							}
						}
						
						break;
					case 404:
						alert("Requested server file not found. Error code: " + this.status);
						break;
					default:
						alert("Request failed. " + this.statusText + "Error Code: " + this.status);
				}
			}
			
			if (nextCall != null) window[nextCall]();
		}
	}
	
	function method() {
		var d = {};
		d["<key>"] = $e("<id>").value;
		
		if (d["<key>"] != "") {
			XHRequest("<method>", JSON.stringify(d));
		} else {
			$e("span-message").innerHTML = "Please enter ???.";
			clearMessage();
		}
	}
	
	var t;
	
	function clearMessage() {
		clearTimeout(t);
		t = setTimeout(function () {
			$e("span-login-message").innerHTML = null;
		}, 5000);
	}
</script>
<style type="text/css">
body {
	font-family: verdana;
	font-size: 16px;
}

div.welcome-text {
	margin: 30px;
}

span.welcome-name {
	font-weight: bold;
}

div.container {
	border: 2px solid;
	border-radius: 10px;
	margin: 50px auto 0px;
	padding: 10px;
	width: 400px;
}

div.title {
	margin: 10px 0px;
	padding: 10px;
	text-align: center;
}

span.title {
	font-size: 30px;
}

div.message {
	margin: 10px 0px;
	height: 20px;
 	text-align: center;
}

span.message {
	color: red;
}

div.form {
	margin: 10px 0px;
	padding: 10px;
	height: 200px;
	position: relative;
}

div.form-field {
	margin: 10px 0px;
}

label.form-field {
	width: 160px;
	text-align: right;
	display: inline-block;
}

input[type=text], [type=password] {
	width: 150px;
	font-family: verdana;
	font-size: 16px;
}

input[type=text]:hover, [type=password]:hover {
	outline: 1px solid;
}

div.button {
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
	<div class="welcome-text">
		Welcome, <span class="welcome-name" id="span-welcome-name">Guest</span> !
	</div>
	<hr>
	<div class="container">
		<div class="title">
			<span class="title">Title</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="form">
			
		</div>
	</div>
</body>
</html>