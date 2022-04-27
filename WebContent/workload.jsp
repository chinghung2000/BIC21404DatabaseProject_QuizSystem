<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionLecturer.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Workloads</title>
<script type="text/javascript">
	function $e(id) {
		var element = document.getElementById(id);
		return element;
	}
	
	function XHRequest(APIMethod, jsonString, {async = true, callback = null, nextCall = null} = {}) {
		var xhttp = new XMLHttpRequest();
		xhttp.open("POST", "api/" + APIMethod + ".jsp", async);
		xhttp.setRequestHeader("Content-Type", "application/json");
	
		xhttp.onreadystatechange = function() {
			if (this.readyState === 4) {
				switch (this.status) {
					case 200:
						var rc = JSON.parse(this.responseText);
						
						if (rc["ok"] === true) {
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
		
		xhttp.send(jsonString);
	}
	
	function logout() {
		XHRequest("logout", JSON.stringify({}), {async: false});
		location.href = "index.jsp";
	}
	
	function loadUserInfo(rc = null) {
		if (rc == null) {
			XHRequest("getUserInfo", JSON.stringify({}), {callback: "loadUserInfo"});
		} else {
			$e("span-welcome-name").innerHTML = rc["name"];
		}
	}
	
	function loadTable(rc = null) {
		if (rc == null) {
			XHRequest("getAllWorkloads", JSON.stringify({}), {callback: "loadTable"});
		} else {
			clearTable();
			
			var r = rc["result"]; 
			var tBody = $e("list").tBodies[0];
			var row, cell, button;
			
			for (var i in r) {
				row = tBody.insertRow();
				
				cell = row.insertCell();
				cell.innerHTML = Number(i) + 1;
				
				cell = row.insertCell();
				cell.innerHTML = r[i]["subject_name"];
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "View & Edit";
				button.setAttribute("onclick", "location.href = 'task.jsp?subject_id=" + r[i]["subject_id"] + "';");
				cell.appendChild(button);
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "View & Edit";
				button.setAttribute("onclick", "location.href = 'quizTF.jsp?subject_id=" + r[i]["subject_id"] + "';");
				cell.appendChild(button);
				button = document.createElement("button");
				button.innerHTML = "Result";
				button.setAttribute("onclick", "location.href = 'quizTFResult.jsp?subject_id=" + r[i]["subject_id"] + "';");
				cell.appendChild(button);
				
				cell = row.insertCell();
				button = document.createElement("button");
				button.innerHTML = "View & Edit";
				button.setAttribute("onclick", "location.href = 'quizObj.jsp?subject_id=" + r[i]["subject_id"] + "';");
				cell.appendChild(button);
				button = document.createElement("button");
				button.innerHTML = "Result";
				button.setAttribute("onclick", "location.href = 'quizObjResult.jsp?subject_id=" + r[i]["subject_id"] + "';");
				cell.appendChild(button);
			}
		}
	}
	
	function clearTable() {
		var tBody = $e("list").tBodies[0];
		
		for (var i = tBody.rows.length; i > 0; i--) {
			tBody.deleteRow(0);
		}
	}
	
	var t;
	
	function clearMessage() {
		clearTimeout(t);
		t = setTimeout(function () {
			$e("span-message").innerHTML = null;
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
	padding: 10px;
	height: 20px;
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
<body onload="loadUserInfo(); loadTable();">
	<div class="welcome-text">
		Welcome, <span class="welcome-name" id="span-welcome-name">Guest</span> !
	</div>
	<hr>
	<div class="menu">
		<a href="lecturer.jsp"><button>Home</button></a>
		<a href="workload.jsp"><button>View Workloads</button></a>
		<button onclick="logout();">Log Out</button>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Workloads</span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table id="list" border="1">
				<thead>
					<tr>
						<th>No</th>
						<th>Subject Name</th>
						<th>Assignments &amp; Tutorials</th>
						<th>Quiz (True / False)</th>
						<th>Quiz (Objective)</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	</div>
</body>
</html>