<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Registration</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function $n(name) {
		var elements = document.getElementsByName(name);
		return elements;
	}
	
	function XHRequest(method, jsonString) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/" + method + ".jsp", true);
		xhttp.setRequestHeader("Content-Type", "application/json");
		xhttp.send(jsonString);
	
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				switch (this.status) {
					case 200:
						var r = JSON.parse(this.responseText);
						
						if (r["ok"] === true) {
							if ("result" in r) {
								return r["result"];
							}
						} else {
							if ("message" in r) {
								$e("span-message").innerHTML = r["message"];
							} else {
								$e("span-message").innerHTML = "Error " + r["error_code"] + ": " + r["description"];
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
		}
	}
	
	function load() {
		var d = XHRequest("", "");
	}
	
	function add() {
		var d = {};
		d["<key>"] = $e("<id>").value;
		
		if (d["<key>"] != "") {
			XHRequest("", JSON.stringify(d));
		} else {
			$e("span-message").innerHTML = "Please enter ???.";
			setTimeout(clearMessage, 5000);
		}
	}
	
	function remove() {
		var d = {};
		d["<key>"] = $e("<id>").value;
		
		if (d["<key>"] != "") {
			XHRequest("", JSON.stringify(d));
		} else {
			$e("span-message").innerHTML = "Please enter ???.";
			setTimeout(clearMessage, 5000);
		}
	}
	
	function clearMessage() {
		$e("span-message").innerHTML = null;
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

div.menu {
	margin: 10px 30px;
	padding: 10px;
}

div.container {
	border: 2px solid;
	border-radius: 10px;
	margin: 0px 30px;
	padding: 10px;
	min-height: 500px;
}

div.title {
	margin: 10px 0px;
	padding: 10px;
}

span.title {
	font-size: 20px;
}

div.message {
	margin: 10px 0px;
	height: 20px;
 	text-align: center;
}

span.message {
	color: red;
}

div.content {
	margin: 10px 0px;
	padding: 10px;
}

table {
	border: 1px solid #bfbfbf;
	border-collapse: collapse;
}

table tr {
	height: 25px;
}

table th {
	background-color: #efefef;
	text-align: left;
}

table th, table td {
	border: 1px solid #bfbfbf;
	padding: 5px 10px;
	max-width: 400px;
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
	<div class="menu">
		<a href=""><button>Home</button></a>
		<a href=""><button>Admin Registration</button></a>
		<a href=""><button>Lecturer Registration</button></a>
		<a href=""><button>Subject Registration</button></a>
		<a href=""><button>Workload Registration</button></a>
		<a href=""><button>Student Registration</button></a>
		<a href=""><button>View Log</button></a>
		<a href=""><button>Log Out</button></a>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Admin Registration</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table border="1">
				<thead>
					<tr>
						<th>Admin ID</th>
						<th>Admin Name</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" id="input-admin-id" maxlength="6"></td>
						<td><input type="text" id="input-admin-name" style="width: 300px;" maxlength="50"></td>
						<td><button onclick="">ADD</button></td>
						<td></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>