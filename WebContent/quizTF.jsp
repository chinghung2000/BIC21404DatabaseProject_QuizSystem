<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="checkSessionStudent.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz (True/False)</title>
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
							if ("redirect" in rc) {
								location.href = rc["redirect"];
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
			var d = {};
			d["subject_id"] = "<% out.print(request.getParameter("subject_id")); %>";
			
			XHRequest("getAllQuizTF", JSON.stringify(d), {callback: "loadTable"});
		} else {
			clearTable();
			
			var r = rc["result"]; 
			var tBody = $e("list").tBodies[0];
			var row, cell, radio, label, br, button;
			
			for (var i in r) {
				row = tBody.insertRow();
				
				cell = row.insertCell();
				cell.innerHTML = Number(i) + 1;
				
				cell = row.insertCell();
				cell.innerHTML = r[i]["question"];
				cell.setAttribute("data-quiz-tf-id", r[i]["quiz_tf_id"]);
				
				cell = row.insertCell();
				radio = document.createElement("input");
				radio.type = "checkbox";
				radio.value = "true";
				cell.appendChild(radio);
				label = document.createElement("label");
				label.innerHTML = "True";
				cell.appendChild(label);
				br = document.createElement("br");
				cell.appendChild(br);
				radio = document.createElement("input");
				radio.type = "checkbox";
				radio.value = "false";
				cell.appendChild(radio);
				label = document.createElement("label");
				label.innerHTML = "False";
			}
		}
	}
	
	function clearTable() {
		var tBody = $e("list").tBodies[0];
		
		for (var i = tBody.rows.length; i > 0; i--) {
			tBody.deleteRow(0);
		}
	}
	
	function submitQuiz() {
		var answers = checkAnswer();
		
		if (answers !== false) {
			var d= {};
			d["subject_id"] = "<% out.print(request.getParameter("subject_id")); %>";
			d["answers"] = answers;
			
			XHRequest("submitQuizTF", JSON.stringify(d), {async: false});
			location.href = "subject.jsp";
		} else {
			$e("span-message").innerHTML = "Please answer all questions.";
			clearMessage();
		}
	}
	
	function checkAnswer() {
		var tBody = $e("list").tBodies[0];
		var row, cell, radio, choice;
		var answers = [];
		
		for (var i = 0; i < tBody.rows.length; i++) {
			row = tBody.rows[i];
			cell = row.cells[2];
			
			for (var j = 0; j < cell.childNodes.length; j++) {
				radio = cell.childNodes[j];
				if (radio.checked) choice = radio.value;
			}
			
			if (answer == null) return false;
			answers.push({quiz_tf_id: row.cells[1].getAttribute("data-quiz-tf-id"), answer: choice});
		}
		
		return answers;
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

div.info {
	margin: 10px 0px;
	padding: 10px;
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

input[type=checkbox] {
	height: 20px;
	width: 20px;
	cursor: pointer;
}

input[type=checkbox]:hover {
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
		<a href="student.jsp"><button>Home</button></a>
		<a href="registerSubject.jsp"><button>Register Subjects</button></a>
		<a href="subject.jsp"><button>View Subjects</button></a>
		<button onclick="logout();">Log Out</button>
	</div>
	<div class="container">
		<div class="title">
			<span class="title">Quiz (True/False)</span>
		</div>
		<div class="info">
			Subject ID: <span id="span-subject-id"></span>
			<br>
			Subject Name: <span id="span-subject-name"></span>
		</div>
		<div class="message">
			<span class="message" id="span-message"></span>
		</div>
		<div class="content">
			<table id="list" border="1">
				<thead>
					<tr>
						<th>No</th>
						<th>Question</th>
						<th>True/False</th>
					</tr>
				</thead>
				<tbody></tbody>
				<tfoot>
					<tr>
						<td><button onclick="submitQuiz();">Submit</button></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</body>
</html>